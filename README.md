3d-greenland
============

Data and code for producing 3D models.

Data Preperation
----------------


Some notes on a process for creating the .STL files from polar datasets. Generated during the dataviz hackathon 11/3-4/2014.

A process that can be followed uses what are called "height-maps". The idea is to obtain grey scale images (.png) of the bed and surface of the region of interest. Having these images, a short C program can be run to produce the corresponding STL file.

Getting the data
----------------

Begin by downloading and appropriate data set providing bed and surface elevation. A quick option is to take these from the SeaRISE data sets, located here:

http://websrv.cs.umt.edu/isis/images/a/a5/Greenland_5km_v1.1.nc

Saving a  grayscale .png
------------------------

These netcdf files can be challenging for a new comer to work with. One way of doing it is to load the data into a program like Q-GIS in order to view it. ncview is also popular. Here, I explain the steps for saving the .png from QGIS.

* Open QGIS
* Import the netcdf file containing the data as a raster. This is done with the icon that looks like a small chessboard with a plus on it. It is located on the left side of the screen.
* Select the rasters to import.
* Display, zoom, and refine the region that you are planning to print. Double click the raster in the left panel to alter the mapping of values to gray colors. Look closely at the bottom of this dialog box, when "Style" is selected on the left. The resampling technique should probably be bilinear of cubic in order to get the desired effect.
* Once the desired region is displayed with appropriate dynamic range in grayscale, and with appropriate resampling technique, save it as a .png file though the "Save as image..." dialog under the File menu.

Converting the .png to an .stl
------------------------------

Download, and install libtrix:

https://github.com/anoved/libtrix

with

make
sudo make install

Then build hmstl:

https://github.com/anoved/hmstl

with:

make

Use hmstl to create the .stl file from the .png. The README file has many examples, but it is mostly just a matter of:

./hmstl -z <RESCALE Z> -i <INPUT FILE>.png -o <OUTPUT FILE>.stl

It is also possible to include a mask, see the REAME.


