NHTS.df <- readRDS(file = "~/GHI/R/data/NHTS.df.rds")
FList <- readRDS(file = "~/GHI/R/data/populationList.rds")

formatMeanMatrix <- function(meanTable){
    meanMatrix <- meanTable %>% select(age,sex,mean) %>% ungroup() %>% spread(sex,mean) %>% select(M,F) %>% as.matrix()
    row.names(meanMatrix) <- paste0("ageClass",1:8)
    return(meanMatrix)
}

msaIDs <- unique(NHTS.df$location)
msaIDs <- as.character(msaIDs[msaIDs!="-1"])

sampleSize <- NHTS.df %>% group_by(location,sex,age) %>% summarise(n=n_distinct(id))
tripDuration <- NHTS.df %>% group_by(location,mode,sex,age) %>% summarise(total=sum(duration))
foo <- right_join(sampleSize,tripDuration, by = c("location","sex","age")) %>% ungroup() %>% mutate(mean = total/n*7) %>% select(location,mode,sex,age,mean) %>% complete(location,mode,sex,age)

meanByLocationByMode <- lapply(split(foo,foo$mode), function(x) split(x, x$location))

MwtList <- lapply(meanByLocationByMode$walk, formatMeanMatrix)
MctList <- lapply(meanByLocationByMode$cycle, formatMeanMatrix)
RwtList <- lapply(MwtList, function(x) x/x[3,2])
RctList <- lapply(MctList, function(x) x/x[3,2])

meanWalkList <- mapply(function(x,y) sum(x*y/sum(y), na.rm = TRUE), MwtList[msaIDs], FList[msaIDs], SIMPLIFY = FALSE)
meanCycleList <- mapply(function(x,y) sum(x*y/sum(y), na.rm = TRUE), MctList[msaIDs], FList[msaIDs], SIMPLIFY = FALSE)

cbind(data.frame(walk = unlist(meanWalkList)), data.frame(cycle = unlist(meanCycleList)))

