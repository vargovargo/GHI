rm(list=ls())
library(ggplot2)
library(reshape2)
library(plyr)
library(foreign)

setwd("~/Box Documents/work/CoBenefits/MaggieShare/FARS/FARSunzip")

acc.names <- c("ACCIDENT.dbf","accident.dbf", "accident.DBF", "ACCIDENT.DBF", "Accident.dbf","Accident.DBF")

veh.names <- c("VEHICLE.dbf","vehicle.dbf", "VEHICLE.DBF","vehicle.DBF", "Vehicle.dbf","Vehicle.DBF")

per.names <- c("PERSON.dbf","person.dbf", "PERSON.DBF","person.DBF", "Person.dbf","Person.BDF")

year <- as.numeric(readline("Which year are you interested in? (will grab data 2 years before and after your entry)"))



#####################################################
#####  load census data
#####################################################

library(UScensus2000tract)
library(UScensus2010)
#library(UScensus2010tract)
#install.tract("osx")


data(states.names)
lower48 = states.names[!states.names %in% c("alaska", "hawaii", "district_of_columbia")]
lower48 = paste0(lower48, ".tract")

 
data(list = lower48[1])
spLower48 = get(lower48[1])[,1:4]
rm(list = lower48[1])
for (i in 2:48) {
    data(list = lower48[i])
    spLower48 = spRbind(spLower48, get(lower48[i])[,1:4])
    rm(list = lower48[i])
}



#####################################################
#####  begin FARS processing loop
#####################################################

years <- c(year-2, year-1, year, year+1, year+2)
stupid <- c("DBF98")

for(i in 1:5){
#i=2

# year=2012
path <- ifelse(years[i] == 1998, 
                             paste("ftp://ftp.nhtsa.dot.gov/fars/", years[i],"/DBF/FARS",stupid,".zip", sep=""),
                             paste("ftp://ftp.nhtsa.dot.gov/fars/", years[i],"/DBF/FARS",years[i],".zip", sep=""))


temp <- tempfile()
download.file(path,temp)

files <- unzip(temp, list=T)$Name

accident <- read.dbf(unzip(temp, files[files %in% acc.names]), as.is=T)
#names(accident) <- c("STATE"  ,  "COUNTY"   ,"MONTH"  ,  "DAY"  ,    "HOUR" ,    "MINUTE" ,  "VE_FORMS", "PERSONS" , "PEDS" ,    "NHS" ,    "ROAD_FNC", "ROUTE"  ,  "SP_JUR" ,  "HARM_EV" , "MAN_COLL" ,"REL_JUNC", "REL_ROAD", "TRAF_FLO", "NO_LANES", "SP_LIMIT", "ALIGNMNT", "PROFILE" , "PAVE_TYP" ,"SUR_COND" ,"TRA_CONT", "T_CONT_F", "HIT_RUN" , "LGT_COND" ,"WEATHER" , "C_M_ZONE", "NOT_HOUR", "NOT_MIN" , "ARR_HOUR" ,"ARR_MIN",  "HOSP_HR" , "HOSP_MN" , "SCH_BUS" , "CF1"  ,    "CF2"  ,    "CF3"    ,  "FATALS" ,  "DAY_WEEK", "DRUNK_DR" ,"ST_CASE" , "CITY" ,    "MILEPT" ,  "YEAR" ,    "TWAY_ID" , "RAIL"   ,  "latitude", "longitud")

PERSON <- read.dbf(unzip(temp, files[files %in% per.names]), as.is=T)
#names(PERSON) <- c("STATE"  ,  "VEH_NO" ,  "PER_NO"  , "N_MOT_NO" ,"AGE" ,     "SEX"   ,   "PER_TYP"  ,"SEAT_POS" ,"REST_USE", "AIR_BAG" , "EJECTION", "EJ_PATH" , "EXTRICAT" ,"LOCATION" ,"DRINKING", "ALC_DET" , "ATST_TYP" ,"ALC_RES" , "DRUGS" ,   "DRUG_DET" ,"DRUGTST1", "DRUGRES1" ,"DRUGTST2","DRUGRES2", "DRUGTST3" ,"DRUGRES3" ,"INJ_SEV" , "HOSPITAL" ,"DEATH_MO" ,"DEATH_DA", "DEATH_HR" ,"DEATH_MN", "LAG_HRS",  "LAG_MINS", "RACE",     "HISPANIC", "P_CF1" ,   "P_CF2" ,   "P_CF3" ,   "WORK_INJ", "DOA"   ,   "ST_CASE" , "DEATH_YR" ,"DEATH_TM", "CERT_NO" , "MAKE"  ,   "BODY_TYP" ,"ROLLOVER", "TOW_VEH" , "SPEC_USE" ,"EMER_USE", "IMPACT1" , "IMPACT2" , "IMPACTS" , "FIRE_EXP" ,"MAK_MOD" , "MOD_YEAR", "VINA_MOD", "SER_TR" ,  "VIN_BT",   "WHLBS_SH", "WHLBS_LG" ,"MCYCL_DS", "VIN_WGT" , "WGTCD_TR", "COUNTY"  , "MONTH" ,   "DAY"   ,   "HOUR"  ,   "MINUTE" ,  "VE_FORMS", "ROAD_FNC" ,"HARM_EV" , "MAN_COLL", "SCH_BUS" )

VEHICLE <- read.dbf(unzip(temp,files[files %in% veh.names]), as.is=T)
#names(VEHICLE) <- c("VIN", "VIN_1"   , "VIN_2" ,   "VIN_3" ,   "VIN_4"  ,  "VIN_5" ,   "VIN_6"  ,  "VIN_7"  ,  "VIN_8"  ,  "VIN_9"  ,  "VIN_10" ,  "VIN_11"  , "VIN_12" ,  "STATE"  ,  "VEH_NO" ,  "OCUPANTS" ,"MAKE" ,    "MODEL","BODY_TYP" ,"REG_STAT" ,"OWNER"   , "ROLLOVER", "J_KNIFE" , "TRAV_SP" , "HAZ_CARG", "TOW_VEH" , "V_CONFIG", "AXLES"  ,  "CARGO_BT" ,"SPEC_USE", "EMER_USE" ,"IMPACT1" , "IMPACT2",  "UNDERIDE" ,"DEFORMED", "IMPACTS"  ,"TOWAWAY" , "FIRE_EXP", "VEH_CF1",  "VEH_CF2" , "VEH_MAN" , "AVOID" ,   "M_HARM" ,  "DEATHS" ,  "VIN_LNGT", "BUS_USE",  "GVWR"  ,   "ST_CASE"  ,"MAK_MOD" , "MOD_YEAR" ,"VINA_MOD", "SER_TR" ,  "VIN_BT" ,  "MCARR_ID" ,"FLDCD_TR" ,"WHLBS_SH", "WHLBS_LG", "MCYCL_DS", "VIN_WGT" , "WGTCD_TR", "DR_PRES" , "DR_DRINK", "L_STATE" , "L_STATUS" ,"CDL_STAT" ,"L_ENDORS" ,"L_COMPL" , "L_RESTRI", "VIOLCHG1", "VIOLCHG2" ,"VIOLCHG3" ,"PREV_ACC" ,"PREV_SUS" ,"PREV_DWI" ,"PREV_SPD" ,"PREV_OTH" ,"LAST_MO" , "FIRST_MO", "DR_CF1" ,  "DR_CF2" ,  "DR_CF3" ,  "DR_CF4" ,  "DR_WGT",   "DR_HGT" ,  "LAST_YR" , "FIRST_YR", "DR_ZIP" ,  "MONTH" ,   "VE_FORMS", "HARM_EV",  "MAN_COLL", "HIT_RUN" )


unlink(temp)


#####################################################
#####  get tracts
#####################################################
library(sp)
library(geoR)
library(reshape)
library(rgdal)


latlon <- accident[,names(accident) %in% c("ST_CASE","latitude","longitud","LONGITUD","longitude", "LATITUDE")]
latlon <- na.omit(latlon)
names(latlon) <- c("ST_CASE", "latitude", "longitud")
latlon <- subset(latlon, longitud > -124.73 & longitud < -66 & latitude > 24.55 & latitude < 49.3) 
ST_CASE = as.data.frame(latlon[,1])
names(ST_CASE)="ST_CASE"							#SID = station ID
locations=latlon[,c(3,2)]					#locations=x,y coordinates
locations=SpatialPointsDataFrame(locations,ST_CASE)
proj4string(locations)<-CRS("+proj=longlat +datum=NAD83 +ellps=GRS80 +towgs84=0,0,0")	#set projection 

#proj4string(locations)<-CRS(ifelse(year < 2010, 
#                        "+proj=longlat +datum=NAD83 +ellps=GRS80 +towgs84=0,0,0",
#                        "+proj=longlat +ellps=GRS80 +datum=NAD83 +no_defs +towgs84=0,0,0"))	#set projection 


acc.tract <- over(locations, spLower48)
latlon <- cbind(latlon, acc.tract)


#####################################################
#####  categorize accidents by harmful event
#####################################################

acc2 <- accident[, names(accident) %in% c("ST_CASE","HARM_EV")]

acc2$NOV<-      ifelse(acc2$HARM_EV == 11,1,
                ifelse(acc2$HARM_EV == 14, 1,
                ifelse(acc2$HARM_EV == 15, 1,
                ifelse(acc2$HARM_EV > 16 & acc2$HARM_EV < 50, 1, 0
                
)))) 


acc2$PED<-      ifelse(acc2$HARM_EV == 8,1,0
) 

acc2$BIKE<-      ifelse(acc2$HARM_EV == 9,1,0
) 

acc2$CAR<-      ifelse(acc2$HARM_EV == 12,1,
                ifelse(acc2$HARM_EV == 13,1,0
))

acc3 <- subset(acc2, NOV ==1 | PED ==1 | BIKE ==1 | CAR ==1)


#####################################################
#####  identify striking and struck vehicles in collisions
#####################################################

veh2 <- VEHICLE[,names(VEHICLE) %in% c("ST_CASE", "VEH_NO","BODY_TYP", "IMPACTS")]

veh3 <- subset(veh2, IMPACTS ==1)
veh3$strikingcar <- veh3$BODY_TYP

veh4 <- subset(veh2, IMPACTS !=1 & IMPACTS !=9)






#crucial rule about which vehicle type to use as struck vehicle, important for accidents with more than 2 vehicles
######
veh.struck <- ddply(veh4, .(ST_CASE), summarise, 
               first = BODY_TYP[1],
               second = BODY_TYP[2]            
)


#####################################################
#####  link striking and struck with person records
#####################################################


per2 <- PERSON[, names(PERSON) %in% c("ST_CASE","STATE","COUNTY","VEH_NO","PER_NO","INJ_SEV","BODY_TYP","IMPACTS","ROAD_FNC", "HARM_EV")]

per2$FATAL <- ifelse(per2$INJ_SEV == 4 , 1, 0)                  
per2$SERIOUS <- ifelse(per2$INJ_SEV == 3 , 1, 0)


per3 <- merge(per2, acc3, by.x="ST_CASE",by.y="ST_CASE",all.x=T )

per4 <- merge(per3, veh3, by.x="ST_CASE",by.y="ST_CASE",all.x=T )

per4 <- merge(per4, veh.struck, by.x="ST_CASE",by.y="ST_CASE",all.x=T )

per4 <- merge(per4, latlon, by.x="ST_CASE",by.y="ST_CASE",all.x=T )

per4$ROW <-       ifelse(per4$PED == 1, 91,
                  ifelse(per4$BIKE == 1, 92,
                  ifelse(per4$NOV == 1, per4$BODY_TYP.x, per4$first)))
                                 
                  
per4$COL <- ifelse(per4$NOV == 1, 93, per4$strikingcar)


per4$ROW[is.na(per4$ROW)] <-  per4$COL[is.na(per4$ROW)]

per5 <- subset(per4, NOV ==1 | PED ==1 | BIKE ==1 | CAR ==1)   

#####################################################
#####  recoding
#####################################################

injuries <- as.data.frame(matrix(c(0:6,9,"No Injury","Other","Other","Serious","Fatal","Other","Other","Other"), ncol = 2, nrow = 8))
names(injuries) <- c("INJ_SEV","injury.severity")

harm <- as.data.frame(matrix(c(8,9,12,13,"Pedestrian","Bicycle","Motor Vehicle","Motor Vehicle"), ncol = 2, nrow = 4))
names(harm) <- c("HARM_EV","first.harmful.event")

body <- as.data.frame(matrix(c(1:93,"Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Car","Bus","Bus","Bus","Bus","Bus","Bus","Bus","Bus","Bus","Bus","Truck","Truck","Truck","Truck","Truck","Truck","Truck","Truck","Truck","Truck","Truck","Truck","Truck","Truck","Truck","Truck","Truck","Truck","Truck","Truck","Motorcycle","Motorcycle","Motorcycle","Motorcycle","Motorcycle","Motorcycle","Motorcycle","Motorcycle","Motorcycle","Motorcycle","Motorcycle", "Ped","Bike", "NOV"), ncol = 2, nrow = 93))
names(body) <- c("BODY_TYP","striking.vehicle")

func <- as.data.frame(matrix(c(1:6,11:16,"Highway","Highway","Arterial","Local","Local","Local","Highway","Highway","Highway","Arterial","Local","Local"), ncol = 2, nrow = 12))
names(func) <- c("ROAD_FNC","functional.class")



#####################################################
#####  renaming
#####################################################

# per6 <- merge(per5, injuries, by.x="INJ_SEV", by.y="INJ_SEV", all.x=T)
# per6 <- merge(per6, harm, by.x="HARM_EV", by.y="HARM_EV", all.x=T)
per6 <- merge(per5, body, by.x="ROW", by.y="BODY_TYP", all.x=T)
per6 <- merge(per6, body, by.x="COL", by.y="BODY_TYP", all.x=T)
per6 <- merge(per6, func, by.x="ROAD_FNC", by.y="ROAD_FNC", all.x=T)

per7 <- subset(per6, FATAL == 1 | SERIOUS == 1)

per7$FATAL <-   ifelse(per7$FATAL == 1, "FATAL","SERIOUS")

# # data(illinois.tract10)
# ggplot(subset(per7, STATE==17), aes(x=longitud, y=latitude))+ geom_point() + plot(illinois.tract10)

# nrow(subset(per7, STATE==17))

#####################################################
#####  summarizing
#####################################################

per8 <- per7[,names(per7) %in% c("ST_CASE","STATE","COUNTY","tract","FATAL","striking.vehicle.x","striking.vehicle.y","functional.class")]

per8 <- per8[,c("ST_CASE","STATE","COUNTY","tract","FATAL","striking.vehicle.x","striking.vehicle.y","functional.class")]

names(per8) <- c("ID","STATE","COUNTY", "TRACT", "FATAL","HARM","STRIKE","FUNC") 

per9 <- na.omit(per8)

FARS.sum <- ddply(per9, .(STATE, COUNTY,TRACT, FATAL, FUNC, HARM, STRIKE), summarise, 
               number = length(ID)
            
)
#MWcounty.key  <- read.csv("~/Box Documents/work/CoBenefits/MaggieShare/TripleWinCountyKey.csv", header=T)
#FARS.sum <- merge(FARS.sum, MWcounty.key, by.x=c("STATE","COUNTY"), by.y=c("STATE","COUNTY"))

#FARS.MW <- subset(FARS.sum, STATE==55 | STATE==17 | STATE== 18 | STATE==26 | STATE== 27 | STATE==39 | STATE==19)

##############################################
#create tables
##############################################

FARS.sum$HARM = factor(FARS.sum$HARM, levels=c('Ped','Bike','Car','Truck','Bus','Motorcycle'))

FARS.cast <- dcast(FARS.sum, STATE + COUNTY + TRACT + FATAL + FUNC + HARM ~ STRIKE, sum)
FARS.cast$year <- years[i]

FARS.CNTY.cast <- dcast(FARS.sum, STATE + COUNTY + FATAL + FUNC + HARM ~ STRIKE, sum)
FARS.CNTY.cast$year <- years[i]

 # fiveyeart <- FARS.cast

 # fiveyearc <- ifelse(i == 1, as.data.frame(FARS.CNTY.cast), rbind(fiveyearc, FARS.CNTY.cast))



namet <- paste("~/Box Documents/work/CoBenefits/MaggieShare/FARS/tracts/",years[i],"_tract.csv", sep="")
namec <- paste("~/Box Documents/work/CoBenefits/MaggieShare/FARS/counties/",years[i],"_county.csv", sep="")

write.csv(FARS.cast, namet, row.names=F)
write.csv(FARS.CNTY.cast, namec, row.names=F)
}

#FARS.processed <- read.csv("~/Box Documents/work/CoBenefits/MaggieShare/FARS/MW_2002.csv", header=T)

#####################################################
#####  average 5 years of FARS
#####################################################
setwd("~/Box Documents/work/CoBenefits/MaggieShare/FARS/counties/")

year1 <- read.csv("2001_county.csv")
year1 <- melt(year1, id=c("STATE", "COUNTY","FATAL","FUNC","HARM","year"))
year2 <- read.csv("2002_county.csv")
year2 <- melt(year2, id=c("STATE", "COUNTY","FATAL","FUNC","HARM","year"))
year3 <- read.csv("2003_county.csv")
year3 <- melt(year3, id=c("STATE", "COUNTY","FATAL","FUNC","HARM","year"))
year4 <- read.csv("2004_county.csv")
year4 <- melt(year4, id=c("STATE", "COUNTY","FATAL","FUNC","HARM","year"))
year5 <- read.csv("2005_county.csv")
year5 <- melt(year5, id=c("STATE", "COUNTY","FATAL","FUNC","HARM","year"))

fiveyrs <- rbind(year1, year2, year3, year4, year5)

fyravg <- ddply(fiveyrs, .(STATE, COUNTY, FATAL, FUNC, HARM, variable), summarize, 
                    avg_count = sum(value, na.rm=T)/5
)
fyravg <- dcast(fyravg, STATE + COUNTY + FATAL + FUNC + HARM ~ variable, mean,  value.var = "avg_count")
fyravg <- fyravg[,c("STATE", "COUNTY", "FATAL", "FUNC", "HARM", "Ped", "Bike", "Bus", "Car", "Truck", "Motorcycle", "NOV")]

write.csv(fyravg, "Countyavg_01-05.csv", row.names=F)

threeyrs <- rbind(year1, year2, year3)

threeyravg <- ddply(threeyrs, .(STATE, COUNTY, FATAL, FUNC, HARM, variable), summarize, 
                    avg_count = sum(value, na.rm=T)/3
)

threeyravg <- dcast(threeyravg, STATE + COUNTY + FATAL + FUNC + HARM ~ variable, mean,  value.var = "avg_count")
threeyravg <- threeyravg[,c("STATE", "COUNTY", "FATAL", "FUNC", "HARM", "Ped", "Bike", "Bus", "Car", "Truck", "Motorcycle", "NOV")]
write.csv(threeyravg, "Countyavg_01-03.csv", row.names=F)



#####################################################
#####  sluething FARS
#####################################################

x<- 490040

x.acc <- subset(accident, ST_CASE == x)
x.per <- subset(PERSON, ST_CASE == x)
x.veh <- subset(VEHICLE, ST_CASE == x)

x.process <- subset(per7, ST_CASE == x)
x.process
