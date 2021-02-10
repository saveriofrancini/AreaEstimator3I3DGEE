#' estimateAreaAndCalculateMapAccuracy function
#'
#' Calculate area estimates and map accuracy using 3I3D-GEE outputs
#' @return  list
#' @keywords mapAccuracy
#' @export
#' @examples
#' estimateAreaAndCalculateMapAccuracy()

# doi paper
# ............................................

estimateAreaAndCalculateMapAccuracy <- function(
  counts = system.file("counts", "counts.csv", package = "AreaEstimator3I3DGEE"),
  sample = system.file("sample", "sample.shp", package = "AreaEstimator3I3DGEE"),
  outPath = getwd()
){

# core code
# read inputs
counts <- read.table(counts, sep = ",", header = T)[,2:4]
sample  <- raster::shapefile(sample)@data
# calculate area estimates
counts$nBuffer <- gsub("[^0-9.-]", "", as.character(counts$nBuffer))
counts$nChange <- gsub("[^0-9.-]", "", as.character(counts$nChange))
counts$nForest <- gsub("[^0-9.-]", "", as.character(counts$nForest))
counts  <- as.double(c(counts$nChange, counts$nBuffer, counts$nForest))
areaTot <- sum(counts)/100 # ha
w <- counts/sum(counts)
cm <- table(sample$classesMap, sample$reference)
sum <- apply(cm, 1, sum)
ReferenceClasses  <- colnames(cm)
nReferenceClasses <- ncol(cm)
out <- NULL
for (ReferenceClasses_i in ReferenceClasses) {
ReferenceClasses_i_counts <- as.double(cm[,colnames(cm)==ReferenceClasses_i])
p <- ReferenceClasses_i_counts/sum
pxw <- p*w
sumpxw <- sum(pxw)
Varp <- (p*(1-p))/sum
w2xVarp <- (w^2)*Varp
sumw2xVarp <- sum(w2xVarp)
sqrtsumw2xVarp <- sqrt(sumw2xVarp)
area <- sumpxw*areaTot
SE <-   sqrtsumw2xVarp*areaTot
SEpercentage <- SE/area*100
CI <- SE*2
out <- rbind(out, c(ReferenceClasses_i, area, SE, SEpercentage, CI))
}
colnames(out) <- c("referenceClass", "area(ha)", "SE(ha)", "SE%", "CI(ha)")
areaEstimates <- out
write.table(out, file.path(outPath, "areaEstimates.csv"), row.names = F)

# ............................................
# calculate map accuracy

TP <- cm[1,1]
FP <- cm[1,2]
FN <- cm[3,1]
TN <- cm[3,2]
bufferDisturbance <- cm[2,1]
bufferUndisturbedForest <- cm[2,2]
omissions               <- round(FN/(TP+FN)*100, 1)
commissions             <- round(FP/(TP+FP)*100, 1)
percentageOfBufferBeingDisturbance <- round(bufferDisturbance/(bufferDisturbance+bufferUndisturbedForest)*100, 1)
percentageOfBufferBeingNoDisturbance <- round(bufferUndisturbedForest/(bufferDisturbance+bufferUndisturbedForest)*100, 1)
out <- cbind(omissions, commissions, percentageOfBufferBeingDisturbance, percentageOfBufferBeingNoDisturbance)
mapAccuracy <- out
#colnames(out) <- c("referenceClass", "area", "SE", "SE%", "CI")
write.table(out, file.path(outPath, "mapAccuracy.csv"), row.names = F)
return(list(areaEstimates, mapAccuracy))
}
