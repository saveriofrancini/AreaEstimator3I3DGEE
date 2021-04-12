![banner image](logo/graphical_abstract.bmp) 

# AreaEstimator3I3DGEE

**An R package to estimate forest disturbance areas using 3I3D-GEE outputs**

<br><br>

## [Manuscript](https://doi.org/10.1016/j.jag.2021.102663) 

<br><br>

## [Google Earth Engine user interface](https://code.earthengine.google.com/?accept_repo=users/sfrancini/S23I3D) 
This R package calculates forest disturbance areas estimates using [3I3D-GEE](https://code.earthengine.google.com/?accept_repo=users/sfrancini/S23I3D) outputs.
The [3I3D-GEE](https://code.earthengine.google.com/?accept_repo=users/sfrancini/S23I3D) link creates an "S23I3D" repository that you can find into the "Reader" section of the "Scripts" window on your Google Earth Engine account.
The S23I3D repository includes two JavaScript codes: (i) "library" is the code that includes all the functions, and (ii) "run" is the code that allows executing the application and generating the user interface.
To execute the appliction via the user friendly interface, open the "run" code and click on the "Run" button. 

A detailed documentation of the application is in the [appendix](https://www.sciencedirect.com/science/article/pii/S0303243421003706?via%3Dihub#f0015) of the manuscript. 

## AreaEstimator3I3DGEE documentation

[Forest disturbance areas](https://www.sciencedirect.com/science/article/pii/S0303243421003706?via%3Dihub#s0055) and [map accuracies](https://www.sciencedirect.com/science/article/pii/S0303243421003706?via%3Dihub#s0060) can be estimated using the 3I3D-GEE outputs and this R package. AreaEstimator3I3DGEE uses the counts table and the photointerpreted sample as inputs and outputs two CSV files: (i) areaEstimates.csv with the area, SE, and confidence interval estimates for each class defined in the photointerpretation phase (e.g. forest fire, clear-cut and wind damage), and (ii) mapAccuracy.csv with map accuracy assessment in terms of [omission](https://www.sciencedirect.com/science/article/pii/S0303243421003706?via%3Dihub#e0010) and [commission](https://www.sciencedirect.com/science/article/pii/S0303243421003706?via%3Dihub#e0015) errors.

The `AreaEstimator3I3DGEE` R package includes just one function `estimateAreaAndCalculateMapAccuracy()` which requires three parameters: 
- 1 `counts`: the path for the "counts.csv" file you downloaded using 3I3D-GEE.
- 2 `sample`: the path for the "sample.shp" file you downloaded using 3I3D-GEE. The sample is selected using [this](https://www.sciencedirect.com/science/article/pii/S0303243421003706?via%3Dihub#s0045) procedure and needs to be photointerpreted as detailed in the section 3.5. of the [manuscript](https://doi.org/10.1016/j.jag.2021.102663).
- 3 `outPath`: the path to save outputs

## Install and Test the package

#### Install the AreaEstimator3I3DGEE package. 
To do it, paste the code below in the R Console and press enter

`install.packages("devtools", repos = "http://cran.us.r-project.org")`
`devtools::install_github("saveriofrancini/AreaEstimator3I3DGEE")`

#### Execute the package using test (dummy) data distributed within the package.
To do it, paste the code below in the R Console and press enter.

`AreaEstimator3I3DGEE::estimateAreaAndCalculateMapAccuracy()`

<br><br>

> Saverio Francini, Ronald E. McRoberts, Giovanni D’Amico, Nicholas C. Coops, Txomin Hermosilla, Joanne C. White, Michael A. Wulder, Marco Marchetti, Giuseppe Scarascia Mugnozza and Gherardo Chirici. 2022. An open science and open data approach for the statistically robust estimation of forest disturbance areas. International Journal of Applied Earth Observation and Geoinformation. https://doi.org/10.1016/j.jag.2021.102663
