![banner image](logo/graphical_abstract.bmp) 

# AreaEstimator3I3DGEE

**An R package to calculate area estimates using 3I3D-GEE outputs**

<br><br>

## [Manuscript](https://www.topolino.it/character/pluto/) 

## Citation

> Saverio Francini*, Ronald E. McRoberts, Giovanni D’Amico, Nicholas C. Coops, Txomin Hermosilla, Joanne C. White, Michael A. Wulder, Marco Marchetti, Giuseppe Scarascia Mugnozza and Gherardo Chirici

<br><br>

## [Google Earth Engine user interface](https://code.earthengine.google.com/?accept_repo=users/sfrancini/S23I3D) 

## Install and Test the package

#### Install the AreaEstimator3I3DGEE package. 
To do it, paste the code below in the R Console and press enter

`install.packages("devtools", repos = "http://cran.us.r-project.org")`
`devtools::install_github("saveriofrancini/AreaEstimator3I3DGEE")`

#### Execute the package using test data distributed within the package.
To do it, paste the code below in the R Console and press enter.

`AreaEstimator3I3DGEE::estimateAreaAndCalculateMapAccuracy()`

If everything went fine, outputs are now in your working directory. 
Of course you can specify a different folder for outputs and use the package with your own 3I3D-GEE outputs.

<br><br>
