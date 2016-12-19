library(ggplot2)
library(plyr)

#######DETAILS ON WONDER QUERY#######
# ---
#   Dataset: Underlying Cause of Death, 1999-2014
# Query Parameters:
#   Title: ITHIM2014_HHS_urb_age_sex_16years
# 2013 Urbanization: All
# Autopsy: All
# Five-Year Age Groups: All
# Gender: Female, Male
# HHS Regions: All
# Hispanic Origin: All
# ICD-10 113 Cause List: Malignant neoplasms of colon, rectum and anus (C18-C21), Malignant neoplasms of trachea, bronchus and
# lung (C33-C34), Malignant neoplasm of breast (C50), #Diabetes mellitus (E10-E14), #Alzheimer's disease (G30), Other forms of
# chronic ischemic heart disease (I20,I25), Acute and subacute endocarditis (I33), Diseases of pericardium and acute myocarditis
# (I30-I31,I40), #Essential hypertension and hypertensive renal disease (I10,I12,I15), #Cerebrovascular diseases (I60-I69),
# #Influenza and pneumonia (J09-J18), Other acute lower respiratory infections (J20-J22,U04), #Chronic lower respiratory diseases
# (J40-J47), Other diseases of respiratory system (J00-J06,J30- J39,J67,J70-J98), Motor vehicle accidents
# (V02-V04,V09.0,V09.2,V12-V14,V19.0-V19.2,V19.4-V19.6,V20-V79,V80.3-V80.5,V81.0-V81.1,V82.0-V82.1,V83-V86,V87.0-V87.8,V88.0-V88.8
#  V89.0,V89.2)
# Other land transport accidents
# (V01,V05-V06,V09.1,V09.3-V09.9,V10-V11,V15-V18,V19.3,V19.8-V19.9,V80.0-V80.2,V80.6-V80.9,V81.2-V81.9,V82.2-V82.9,V87.9,V88.9
#  V89.1,V89.3,V89.9)
# 
# Place of Death: All
# Race: All
# Weekday: All
# Year/Month: All
# Group By: Five-Year Age Groups, Gender, HHS Region, 2013 Urbanization, ICD-10 113 Cause List
# Show Totals: Disabled
# Show Zero Values: True
# Show Suppressed: True
# Calculate Rates Per: 100,000
# Rate Options: Default intercensal populations for years 2001-2009 (except Infant Age Groups)
# ---
#   Help: See http://wonder.cdc.gov/wonder/help/ucd.html for more information.
# ---
#   Query Date: Jul 19, 2016 4:46:10 PM
# ---
#   Suggested Citation: Centers for Disease Control and Prevention, National Center for Health Statistics. Underlying Cause of Death
# 1999-2014 on CDC WONDER Online Database, released 2015. Data are from the Multiple Cause of Death Files, 1999-2014, as compiled
# from data provided by the 57 vital statistics jurisdictions through the Vital Statistics Cooperative Program. Accessed at
# http://wonder.cdc.gov/ucd-icd10.html on Jul 19, 2016 4:46:10 PM
# ---
#   Messages:
#   1. Totals and Percent of Total are disabled when data are grouped by 113 or 130 Cause Lists. Check Caveats below for more
# information.
# 2. Selections made to any variable in [HHS Regions, 2013 Urbanization] cause equivalent selections in the other variables. More
# Information: http://wonder.cdc.gov/wonder/help/faq.html#related-variables.
# 3. Totals are not available for these results due to suppression constraints. More Information:
#   http://wonder.cdc.gov/wonder/help/faq.html#Privacy.
# ---
#   Footnotes:
#   1. A '#' symbol preceding the label indicates a rankable cause of death. More information.
# ---
#   Caveats:
#   1. Totals and Percent of Total are disabled when data are grouped by a 113 or 130 Cause List because both aggregate and detailed
# values are displayed in the table. Also be aware that charts and maps containing both aggregate and detail data could be
# misleading.
# 2. Population and rates are labeled 'Not Applicable' when they include a subset of ages 85-100+ because populations are not
# available for those ages. More information: http://wonder.cdc.gov/wonder/help/ucd.html#Ages 85-100.
# 3. Circumstances in Georgia for the years 2008 and 2009 have resulted in unusually high death counts for the ICD-10 cause of
# death code R99, "Other ill-defined and unspecified causes of mortality." Caution should be used in interpreting these data.
# More information: http://wonder.cdc.gov/wonder/help/ucd.html#Georgia-Reporting-Anomalies.
# 4. Circumstances in New Jersey for the year 2009 have resulted in unusually high death counts for the ICD-10 cause of death code
# R99, "Other ill-defined and unspecified causes of mortality" and therefore unusually low death counts in other ICD-10 codes,
# most notably R95, "Sudden Infant Death Syndrome" and X40-X49, "Unintentional poisoning." Caution should be used in
# interpreting these data. More information: http://wonder.cdc.gov/wonder/help/ucd.html#New-Jersey-Reporting-Anomalies.
# 5. Circumstances in California resulted in unusually high death counts for the ICD-10 cause of death code R99, "Other
# ill-defined and unspecified causes of mortality" for deaths occurring in years 2000 and 2001. Caution should be used in
# interpreting these data. More information: http://wonder.cdc.gov/wonder/help/ucd.html#California-Reporting-Anomalies.
# 6. Data are Suppressed when the data meet the criteria for confidentiality constraints. More information:
#   http://wonder.cdc.gov/wonder/help/ucd.html#Assurance of Confidentiality.
# 7. Death rates are flagged as Unreliable when the rate is calculated with a numerator of 20 or less. More information:
#   http://wonder.cdc.gov/wonder/help/ucd.html#Unreliable.
# 8. Deaths of persons with Age "Not Stated" are included in "All" counts and rates, but are not distributed among age groups,
# so are not included in age-specific counts, age-specific rates or in any age-adjusted rates. More information:
#   http://wonder.cdc.gov/wonder/help/ucd.html#Not Stated.
# 9. The population figures for year 2014 are bridged-race estimates of the July 1 resident population, from the Vintage 2014
# postcensal series released by NCHS on June 30, 2015. The population figures for year 2013 are bridged-race estimates of the July
# 1 resident population, from the Vintage 2013 postcensal series released by NCHS on June 26, 2014. The population figures for
# year 2012 are bridged-race estimates of the July 1 resident population, from the Vintage 2012 postcensal series released by NCHS
# on June 13, 2013. The population figures for year 2011 are bridged-race estimates of the July 1 resident population, from the
# Vintage 2011 postcensal series released by NCHS on July 18, 2012. Population figures for 2010 are April 1 Census counts. The
# population figures for years 2001 - 2009 are bridged-race estimates of the July 1 resident population, from the revised
# intercensal county-level 2000 - 2009 series released by NCHS on October 26, 2012. Population figures for 2000 sssssare April 1 Census
# counts. Population figures for 1999 are from the 1990-1999 intercensal series of July 1 estimates. Population figures for the
# infant age groups are the number of live births. <br/><b>Note:</b> Rates and population figures for years 2001 - 2009 differ
# slightly from previously published reports, due to use of the population estimates which were available at the time of release.
# 10. The population figures used in the calculation of death rates for the age group 'under 1 year' are the estimates of the
# resident population that is under one year of age. More information: http://wonder.cdc.gov/wonder/help/ucd.html#Age Group.
#################################


#read in data for ages 0-84 (AKA 5yr age groups)
numberOfRows <- 29376

wonder <- read.table(url("https://uwmadison.box.com/shared/static/cooyb4c8ghgewv2x021ulkj6vtcuazlu.txt"), sep="\t", as.is = T, nrows = numberOfRows, skip=1)
header <- read.table(url("https://uwmadison.box.com/shared/static/cooyb4c8ghgewv2x021ulkj6vtcuazlu.txt"), sep="\t", as.is = T, nrows = 1)
colnames(wonder) <- unlist(header)


wonderSingleYear <- read.table(url("https://uwmadison.box.com/shared/static/lu3feh7x4r9wpfan9q7og9f6684xvtlk.txt"), sep="\t", as.is = T, nrows = numberOfRows, skip=1)
header <- read.table(url("https://uwmadison.box.com/shared/static/lu3feh7x4r9wpfan9q7og9f6684xvtlk.txt"), sep="\t", as.is = T, nrows = 1)
colnames(wonderSingleYear) <- unlist(header)
wonderSingleYear$POPclean <- ifelse(wonderSingleYear$Population== "Suppressed", sample(0:9), as.integer(as.character(wonderSingleYear$Population))) 
wonderSingleYear$POP2014 <- as.numeric(as.character(wonderSingleYear$POPclean))

wonder <- cbind(wonder, wonderSingleYear["POP2014"])


#read in data for ages 85plus (AKA 10yr age groups)
numberOfRows <- 1632
wonder10 <- read.table(url("https://uwmadison.box.com/shared/static/1kkqovgdf8dycghol2ijupmv7bm7gtfo.txt"), sep="\t", as.is = T, nrows = numberOfRows, skip=1)
#header <- read.table(url("https://uwmadison.box.com/shared/static/1kkqovgdf8dycghol2ijupmv7bm7gtfo.txt"), sep="\t", as.is = T, nrows = 1)
colnames(wonder10) <- unlist(header)

wonderSingleYear10 <- read.table(url("https://uwmadison.box.com/shared/static/kmcxc847bzppi7wjluzwmelpk8a56en6.txt"), sep="\t", as.is = T, nrows = numberOfRows, skip=1)
#header <- read.table(url("https://uwmadison.box.com/shared/static/kmcxc847bzppi7wjluzwmelpk8a56en6.txt"), sep="\t", as.is = T, nrows = 1)
colnames(wonderSingleYear10) <- unlist(header)
wonderSingleYear10$POP2014 <- wonderSingleYear10$Population

wonder10 <- cbind(wonder10, wonderSingleYear10["POP2014"])

wonderall <- rbind(wonder, wonder10)

wonderall$EstImpDeaths <- as.numeric(ifelse(wonderall$Deaths == "Suppressed", sample(0:9), as.numeric(as.character(wonderall$Deaths))))
wonderall$EstRate <- wonderall$EstImpDeaths/wonderall$Population
wonderall$EstDeaths <- wonderall$EstRate*wonderall$POP2014

wonderall <- wonderall[,c(2,3,4,6,8,13:16)]
names(wonderall) <- c("state", "stateFIPS", "wonderAge", "wonderGender","wonderCause","POP2014","EstImpDeaths","EstRate","EstDeaths")   

unique(wonderall$wonderGender)
unique(wonderall$wonderAge)

#check state metro population
foo <- subset(wonderall, state =="Wisconsin")
sum(foo$POP2014)/16
sum(wonderall$POP2014)/16       #272,667,942


# remove 'Not stated' Age entries
wonderall <- subset(wonderall, wonderAge !="NS")

#depression was not in the WONDER data, since there are no deaths, have to add it manually
depress <- expand.grid(state=unique(wonderall$state), stateFIPS=0, wonderAge=unique(wonderall$wonderAge), wonderGender=unique(wonderall$wonderGender), 
                       wonderCause = "Depression", POP2014= 0, EstImpDeaths= 0, EstRate=0, EstDeaths = 0, stringsAsFactors=T)

popSummary <- ddply(wonderall, .(state, wonderGender, wonderAge), summarise, 
                        depressPOP= mean(as.integer(as.character(POP2014)), na.rm=T))



#check state metro population
foo <- subset(popSummary, state =="Wisconsin")
sum(foo$depressPOP)
sum(popSummary$depressPOP)   #272,667,942

depress <- merge(depress, popSummary)

depress$POP2014 <- depress$depressPOP

depress <- depress[,c(1:9)]

wonderall <- rbind(wonderall, depress)

#check state metro population
foo <- subset(wonderall, state =="Wisconsin")
sum(foo$POP2014)/17     # 17 causes of death
#state pop ok
sum(wonderall$POP2014)/17
#national pop ok      #272,667,942


#recode cause of death for ITHIM
ITHIMcauseKey <- c("ColonCancer","LungCancer","BreastCancer","Diabetes","Dementia","IHD","InflammatoryHD","InflammatoryHD","HHD",
                   "Stroke","AcuteRespInfections","AcuteRespInfections","RespiratoryDisease","RespiratoryDisease","RTIs","RTIs", "Depression")
names(ITHIMcauseKey) <- unique(wonderall$wonderCause)
wonderall$ITHIMcause <- ITHIMcauseKey[as.character(wonderall$wonderCause)]

#recode aage for ITHIM
ITHIMageKey <- c("ageClass1", "ageClass1", "ageClass2", "ageClass2", "ageClass3", "ageClass3", "ageClass3", "ageClass4", "ageClass4", "ageClass4",
                 "ageClass5", "ageClass5", "ageClass5", "ageClass6", "ageClass6", "ageClass7", "ageClass7", "ageClass8", "ageClass8")
names(ITHIMageKey) <- unique(wonderall$wonderAge)
wonderall$ITHIMage <- ITHIMageKey[as.character(wonderall$wonderAge)]

#wonder <- wonderall[, c("state","wonderGender","ITHIMage","ITHIMcause","EstDeaths","POP2014")]

#names(wonder) <- c("state","gender","ITHIMage","ITHIMcause","EstDeaths","POP2014")

sum(wonder$POP2014)/17

########## this 'wonderall' is a table you can crunch for anything ##################
#summarize by state>Urbanization>Gender<age<cause
wonderSummary <- ddply(wonderall, .(state, wonderGender, ITHIMage, ITHIMcause, wonderCause ), summarise, 
                       Deaths = sum(as.integer(as.character(EstDeaths)), na.rm=T),
                       POP = sum(POP2014, na.rm=T)
)

wonderSummary <- ddply(wonderSummary, .(state, wonderGender, ITHIMage, ITHIMcause), summarise, 
                       Deaths = sum(as.integer(as.character(Deaths)), na.rm=T),
                       POP = mean(POP, na.rm=T)
)

names(wonderSummary) <- c("state","gender","ITHIMage","ITHIMcause","deaths","POP")



USGBD <- read.csv("../USGBD.csv", header=T)
USGBD$ITHIMage <- as.character(USGBD$ITHIMage)
USGBD$ITHIMcause <- as.character(USGBD$ITHIMcause)

burden <- merge(wonderSummary, USGBD, all.x=T)

burden$ratio <- ifelse(burden$GBDdeaths == 0, 1, ((burden$deaths/burden$POP)/(burden$GBDdeaths/burden$GBDpop)))
burden$YLL <- burden$ratio * (burden$GBDyll/burden$GBDpop) * burden$POP
burden$YLD <- burden$ratio * (burden$GBDyld/burden$GBDpop) * burden$POP
burden$DALY <- burden$ratio * (burden$GBDdaly/burden$GBDpop) * burden$POP

burden$sex <- factor(ifelse(burden$gender == "Male","M","F"), levels=c("M","F"))

      
burdenOut <- burden[,c("state","ITHIMcause","sex","ITHIMage","deaths","YLL","YLD","DALY")]
names(burdenOut) <- c("state","disease","sex","ageClass","dproj","yll","yld","daly")

burdenOut <- burdenOut[order(burdenOut$state, burdenOut$disease, burdenOut$sex, burdenOut$ageClass),] 
# This file can be linked to the ITHIM object 


