#This script creates population weighted PM2.5 concentrations for each state's metro are and returns that info for the ITHIM Object

library(plyr)
library(jsonlite)

#ACS API
ACSpop <- as.data.frame(fromJSON("http://api.census.gov/data/2015/acs5?get=B01001_001E,NAME&for=county:*&key=f78d6b6c18608edc379b5a06c55407ceb45e7038"))
ACSpop <- ACSpop[-1,]
colnames(ACSpop) <- c("ACSpopulation","COUNTY_STATE","stateOnly","countyOnly")
ACSpop$countyFIPS <- as.integer(paste(ACSpop$stateOnly, ACSpop$countyOnly, sep=""))
rownames(ACSpop) <- ACSpop$countyFIPS

# read in county level estimates from National Environmental Public Health Tracking Network
# https://ephtracking.cdc.gov/DataExplorer/

countyPM <- read.csv(url("https://uwmadison.box.com/shared/static/axjc8dtbe34nmjfqf73biti22kvw90i5.csv"))
countyPM <- countyPM[,1:6]

# read in county urbanicity from National Center for Health Statistics
# https://www.cdc.gov/nchs/data_access/urban_rural.htm

countyKEY <- read.csv(url("https://uwmadison.box.com/shared/static/uwnsg9bsqafecgmkszmllc0qdy8c2228.csv"))
countyKEY <- countyKEY[,c("FIPSnum","NCHS_County","Metro")]

#Merge the 3 filws
counties <- merge(countyPM, countyKEY, by.x="countyFIPS", by.y = "FIPSnum")
counties <- merge(counties, ACSpop)
#This file can be used later to look at finer stratification of county urbanicity

#look at metro counties only
countiesMETRO <- subset(counties, Metro =="metro")
countiesMETRO$ACSpopulation <- as.integer(as.character(countiesMETRO$ACSpopulation)) 

stateMETRO <- ddply(countiesMETRO, .(stateOnly), summarise,
                    stateMetroPop = sum(ACSpopulation, na.rm=T)
                    )

foo <- merge (countiesMETRO, stateMETRO)

foo$weightedConc <- foo$Conc * (foo$ACSpopulation/foo$stateMetroPop)


#returns the population-weighted PM2.5 concentration for the metro counties in each state
#these values can be the baseline PM concentrations for the ITHIM object
stateConc <- ddply(foo, .(State, stateFIPS), summarise,
                    metroConc = sum(weightedConc, na.rm=T)
)

