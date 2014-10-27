function zMapToSTL(Zmap, fileName, interpFactor, minThickness, maxThickness, maxWidth)
% Function to convert a Zmap into a STL file + visualisation of the result
% Parameters:
%   - ZMap (compulsory) : Map to represent
%   - fileName (compulsory) : STL file name
%   - interpFactor (default 0) : Interpolation factor of the map (0 = disable)
%  Scaling parameters:
%   - minThickness (default 2) : Minimum thickness of the output solid
%   - maxThickness (default 10) : Maximum thickness of the output solid
%   - maxWidth (default = max dimension of the image) : surface scaling
%
% Copyright (C) Damien Berget 2013
% This code is only usable for non-commercial purpose and 
% provided as is with no guaranty of any sort

%1/ parameters setting
%---------------------
if ~exist('Zmap', 'var')
    error('Zmap should be provided')
else
    Z = double(Zmap);
end
if ~exist('interpFactor', 'var')
    interpFactor = 0;
end
if ~exist('minThickness', 'var')
    minThickness = 2;
end
if ~exist('maxThickness', 'var')
    maxThickness = 10;
end
if ~exist('maxWidth', 'var')
    maxWidth = max(size(Z))-1;
end

%2/ X/Y data interpolation
%-------------------------
if interpFactor ~= 0
    Z = interp2(Z, interpFactor, 'cubic');
end

%3/ Vertical scale update:
%-------------------------
% Move minZ to 0
Z = Z - min(Z(:));
% scale Max Z to respect spec thickness
Zmax = max(Z(:));
Z = Z .* (maxThickness - minThickness) / Zmax;

%build X/Y mesh matrix and scalling
maxMatDim = max(size(Z))-1;
maxDim1 = (size(Z, 1) - 1) * maxWidth / maxMatDim;
maxDim2 = (size(Z, 2) - 1) * maxWidth / maxMatDim;
[X,Y] = meshgrid([0:maxDim2/(size(Z,2)-1):maxDim2], [0:maxDim1/(size(Z,1)-1):maxDim1]);

%build triangles for the top face
tri = delaunay(X,Y);

%Bottom triangles
ZBottom   = -minThickness*ones(size(Z));
triBottom = [tri(:,1) tri(:,3) tri(:,2)] + numel(Z);

%linearize x/y/z and assemble bits
Xlin = [X(:);X(:)];
Ylin = [Y(:);Y(:)];
Zlin = [Z(:);ZBottom(:)];

totalTri = [tri; triBottom];

%build & add side triangles
sideIdx = getClockwiseSideIndex(Z);
[sideTri sideX sideY sideZ] = buildSideTriangles(X(sideIdx), Y(sideIdx), Z(sideIdx), X(sideIdx), Y(sideIdx), ZBottom(sideIdx));
sideTri = sideTri + size(Xlin, 1);
Xlin = [Xlin; sideX];
Ylin = [Ylin; sideY];
Zlin = [Zlin; sideZ];
totalTri = [totalTri; sideTri];

%Visu and save file
trisurf(totalTri,Xlin,Ylin,Zlin)
axis equal
writeBinaryStl(fileName, totalTri, Xlin, Ylin, Zlin);

function sideIdx = getClockwiseSideIndex(matrix)

idxMat = 1:numel(matrix);
idxMat = reshape(idxMat, size(matrix));

sideIdx = [];
sideIdx = idxMat(1, :)';
sideIdx = [sideIdx ; idxMat(2:end, end)];
sideIdx = [sideIdx ; idxMat(end, end-1:-1:1)'];
sideIdx = [sideIdx ; idxMat(end-1:-1:1, 1)];

function [sideTri X Y Z] = buildSideTriangles(Xtop, Ytop, Ztop, Xbot, Ybot, Zbot)
sideTri = [];
X = [Xtop; Xbot];
Y = [Ytop; Ybot];
Z = [Ztop; Zbot];
n = numel(Xtop);
for idx = 1:numel(Xtop)-1
    sideTri(end + 1, 1:3) = [idx, idx+n, idx+1];
    sideTri(end + 1, 1:3) = [idx+1, idx+n, idx+n+1];
end

function writeBinaryStl(filename, tri, x, y, z)

fid = fopen(filename, 'wb');

%Header :
% UINT8[80] – Header
description = 'This is a stl mesh';
fwrite(fid, description, '*char');
trail = zeros([80-length(description),1], 'uint8');
fwrite(fid, trail, '*char');

% UINT32 – Number of triangles
fwrite(fid, size(tri, 1), 'uint32');

%write each triangle
for idx = 1:size(tri, 1)
    %build vertex point
    pt1 = [x(tri(idx, 1)), y(tri(idx, 1)), z(tri(idx, 1))];
    pt2 = [x(tri(idx, 2)), y(tri(idx, 2)), z(tri(idx, 2))];
    pt3 = [x(tri(idx, 3)), y(tri(idx, 3)), z(tri(idx, 3))];
    
    %write triangle
    % REAL32[3] – Normal vector
    % REAL32[3] – Vertex 1
    % REAL32[3] – Vertex 2
    % REAL32[3] – Vertex 3
    % UINT16 – Attribute byte count    
    
    %no normal
    fwrite(fid, [0 0 0], 'single');

    %3 points
    fwrite(fid, pt1, 'single');
    fwrite(fid, pt2, 'single');
    fwrite(fid, pt3, 'single');

    %no attibute
    fwrite(fid, 0, 'uint16');

end

fclose(fid);


