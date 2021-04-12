#' estimateAreaAndCalculateMapAccuracy function
#'
#' Calculate area estimates and map accuracy using 3I3D-GEE outputs
#'
#' @return  list
#' @keywords mapAccuracy
#' @export
#' @examples
#' estimateAreaAndCalculateMapAccuracy()

# doi paper
# ............................................

estimateAreaAndCalculateMapAccuracy <-
  function(counts = system.file("counts", "counts.csv", package = "AreaEstimator3I3DGEE"),
           sample = system.file("sample", "sample.shp", package = "AreaEstimator3I3DGEE"),
           outPath = getwd()) {
    # core code
    # read inputs
    counts <- read.table(counts, sep = ",", header = T)[, 2:4]
    sample  <- raster::shapefile(sample)@data
    # calculate area estimates
    counts$nBuffer <-
      gsub("[^0-9.-]", "", as.character(counts$nBuffer))
    counts$nChange <-
      gsub("[^0-9.-]", "", as.character(counts$nChange))
    counts$nForest <-
      gsub("[^0-9.-]", "", as.character(counts$nForest))
    counts  <-
      as.double(c(counts$nChange, counts$nBuffer, counts$nForest))
    w <- counts / sum(counts)
    cm <- table(sample$classesMap, sample$reference)
    sum <- apply(cm, 1, sum)
    ReferenceClasses  <- colnames(cm)
    nReferenceClasses <- ncol(cm)
    out <- NULL
    for (ReferenceClasses_i in ReferenceClasses) {
      ReferenceClasses_i_counts <-
        as.double(cm[, colnames(cm) == ReferenceClasses_i])
      p <- ReferenceClasses_i_counts / sum
      pxw <- p * w
      sumpxw <- sum(pxw)
      Varp <- (p * (1 - p)) / sum
      w2xVarp <- (w ^ 2) * Varp
      sumw2xVarp <- sum(w2xVarp)
      sqrtsumw2xVarp <- sqrt(sumw2xVarp)
      area <- sumpxw
      SE <-   sqrtsumw2xVarp
      SEpercentage <- SE / area * 100
      CI <- SE * 2
      out <-
        rbind(out, c(ReferenceClasses_i, area, SE, SEpercentage, CI))
    }
    colnames(out) <-
      c("referenceClass", "area", "SE", "SE%", "CI")
    areaEstimates <- as.data.frame(out)
    write.table(areaEstimates, file.path(outPath, "areaEstimates.csv"), row.names = F)

    # ............................................
    # calculate map accuracy
    commission <- (cm[1, 2] / sum(cm[1, 1:2])) * 100
    omission <- (cm[3, 1] / sum(cm[3, 1:2])) * 100
    disturbedBuffer <- (cm[2, 1] / sum(cm[2, 1:2])) * 100

    out <-
      cbind(round(commission, 2),
            round(omission, 2),
            round(disturbedBuffer, 2))
    colnames(out) <- c("commission (%)", "omission (%)", "bufferPredictedAsDisturbed (%)")
    write.table(out, file.path(outPath, "mapAccuracy.csv"), row.names = F)
    return(list(areaEstimates, out))
  }
