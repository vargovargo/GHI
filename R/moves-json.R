# Connect and export JSON of your data from this site
# http://moves-export.herokuapp.com/
library(RJSONIO)
library(tidyverse)

rm(list=ls())
foo <- fromJSON("/home/sgy/GHI/data/sgy-moves.json")
masterList <- foo[[1]]
dfTotal <- data.frame()
nDays <- length(masterList) - 1

for(i in 1:nDays){
    nSegments <- length(masterList[[i]]$segments)
    for( j in 1:nSegments ){
        nActivities <- length(masterList[[i]]$segments[[j]]$activities)
        if( !is.null(masterList[[i]]$segments) && masterList[[i]]$segments[[j]]$type == "move" ){
            for(k in 1:nActivities){
                subList <- masterList[[i]]$segments[[j]]$activities[[k]]
                df <- data.frame(activity = subList$activity, duration = subList$duration, distance = subList$distance, starttime = subList$startTime)
                dfTotal <- rbind(dfTotal, df)
            }
        }
    }
}

dfTotal <- dfTotal %>% separate(col = starttime, into = c("date", "time"), sep = "T") %>%  mutate(date = as.Date(date,"%Y%m%d")) %>%
    mutate(dow = factor(weekdays(date),levels=c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")),
           day = format(date, "%d"),
           month = format(date, "%B"))


D <- dfTotal %>% filter(activity != "trp") %>% group_by(date, activity) %>% summarise(dailyMiles=sum(duration)) %>% ungroup()

p <- ggplot(D, aes(x=activity, y = dailyMiles))
p + geom_boxplot()#  +   scale_size_area() + xlab("") + ylab("Total Distance (miles)") + ggtitle("")



## ggplot(aes(x=duration/60, fill=factor(activity)))+ geom_histogram(position="dodge") + facet_grid(.~dow)


## dfTotal %>% filter(activity != "trp") %>%
##     ggplot(aes(x=dow, y= distance/1609.344, fill=factor(activity)))+ geom_bar(stat ="identity",position="stack") + facet_grid(.~month)


## p <- ggplot(dfTotal, aes(x = distance/duration*2.236936, fill = activity))
## p + geom_histogram(position = "dodge") + 
##     scale_size_area() +
##     xlab("My x label") +
##     ylab("My y label") +
##     ggtitle("Weighted Scatterplot of Watershed Area vs. Discharge and Nitrogen Levels (PPM)")

summary(with(subset(dfTotal, activity == "wlk"), distance/duration*2.236936))
