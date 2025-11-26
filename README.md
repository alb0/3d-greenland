# 3d-greenland Introduction

This describes data, code, workflows, and notes for producing 3D models of polar data. Mostly pertaining to Greenland topography, you'll find additional files here for Antarctica and other types of data.  

The name of the repo should probably be changed, but you have been warned. 

## History, Background, and Files

This project began in ~2012, printing the Greenland Ice Sheet's bathymetry/sub-ice topography as well as the ice surface from raster data. A few other types of models and prints were explored, but the main thrust of the work was and has been to create two-piece ice-sheet models where the ice sheet is removable and fits on top of a bedrock and bathrymetry model. The bathymetry/topography datasets have since been updated, but the type remains the same: GeoTiff or NetCDF files containing rasters of elevation data. 

The original workflows are best recorded in this poster that was presented at the American Geophysical Union Fall Meeting in 2014 ![linked here](https://github.com/alb0/3d-greenland/blob/master/3DPrintingPoster_v2.pdf). Many different programs were used, some open source and others not. An MakerBot printer was the primary machine used for testing, but another high-quality print was made by a company with a laser-scintering machine that enabled detailed color mapping and higher resolution prints. See below:

![test](https://github.com/alb0/3d-greenland/blob/master/photos/greenland2.jpeg)
![test](https://github.com/alb0/3d-greenland/blob/master/photos/greenland3.jpeg)

This was also a topic of discussion at the ![NSF Polar Cyberinfrastructure Hackathon in NYC](https://nsf-polar-cyberinfrastructure.github.io/datavis-hackathon/) in 2015, with additional prints made. The notes workflows that resulted from that session are ![here](https://github.com/alb0/3d-greenland/blob/master/Post-NSF-Polar-Cyber-DataViz-Hackathon).  Caution to the reader: these are unlikely to be sufficient to recreate any models. 

Since these models were made, the original STL files have been modified by others and used for education and outreach purposes in Greenland. Links and resources to follow. 

### Files and Folders in this Repo
- photos contains photos of 3D prints
- Jakob_3D_Printing contains images, a readme, and stl files for printing a two-piece model of the ice surface and bed near Jakobshavn
- zMapToSTL contains Matlab files for creating STL files from raster elevation datasets
- Other files 
-  
## Improvements and Future Work

**Attempts to recreate the above models have been unsuccessful.** 

A list of issues to fix and goals to pursue:

- A new workflow must be created using entirely free/open-source software
- The above model should be improved
- - Better resolution and smoothing 
  - Better fit between surface and base
  - Cleaned up edges on the surface
- Make a model of Antarctica (this may be challening due to the size, presence of floating ice, etc.)

### Developing the workflow to recreate Greenland model:


