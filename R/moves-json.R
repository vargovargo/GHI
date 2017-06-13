foo <- fromJSON("~/Downloads/moves-export (1).json")
masterList <- foo[[1]]
dfTotal <- data.frame()
nDays <- length(masterList) - 1

for(i in 1:nDays){
    nSegments <- length(masterList[[i]]$segments)
    for( j in 1:nSegments ){
        nActivities <- length(masterList[[i]]$segments[[j]]$activities)
        if( masterList[[i]]$segments[[j]]$type == "move" ){
            for(k in 1:nActivities){
                subList <- masterList[[i]]$segments[[j]]$activities[[k]]
                df <- data.frame(activity = subList$activity, duration = subList$duration, distance = subList$distance)
                dfTotal <- rbind(dfTotal, df)
            }
        }
    }
}
