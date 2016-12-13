---
title: "CDC WONDER county estimates for ITHIM"
output: html_document
---
The script creates county-level estimates of disesae burden using the annual number of deaths and the Global Burden of Disease numbers.  This script reads in text files output by CDC's WONDER database for deatiled mortality [https://wonder.cdc.gov/ucd-icd10.html]. There are four required files to get the needed age-gender-cause estimates required for ITHIM. We use the following causes of death for ITHIM from the ICD-10 113 Cause List. 

_Malignant neoplasms of colon, rectum and anus (C18-C21), Malignant neoplasms of trachea, bronchus and  lung (C33-C34), Malignant neoplasm of breast (C50), #Diabetes mellitus (E10-E14), #Alzheimer's disease (G30), Ischemic heart   diseases (I20-I25), Acute and subacute endocarditis (I33), Diseases of pericardium and acute myocarditis (I30-I31,I40),	Essential hypertension and hypertensive renal disease (I10,I12,I15), #Influenza and pneumonia (J09-J18), Other acute lower	respiratory infections (J20-J22,U04), #Chronic lower respiratory diseases (J40-J47), Other diseases of respiratory system	(J00-J06,J30- J39,J67,J70-J98), Motor vehicle accidents	(V02-V04,V09.0,V09.2,V12-V14,V19.0-V19.2,V19.4-V19.6,V20-V79,V80.3-V80.5,V81.0-V81.1,V82.0-V82.1,V83-V86,V87.0-V87.8,V88.0-V88.8, V89.0,V89.2),	Other land transport accidents (V01,V05-V06,V09.1,V09.3-V09.9,V10-V11,V15-V18,V19.3,V19.8-V19.9,V80.0-V80.2,V80.6-V80.9,V81.2-V81.9,V82.2-V82.9,V87.9,V88.9,	V89.1,V89.3,V89.9)_

1. A query by County (all counties in a state), Age (5 yr groups <1 - 84), Gender (both M and F), and ICD-10 113 Cause (see above) for years 99-2014 - named "ST_counties_99-14_5yr" (ie WI_counties_99-14_5yr.txt)
2. A query by County (all counties in a state), Age (5 yr groups <1 - 84), Gender (both M and F), and ICD-10 113 Cause (see above) for 2014 - named "ST_counties_2014_5yr" (ie WI_counties_2014_5yr.txt)
3. A query by County (all counties in a state), Age (10 yr groups 85+), Gender (both M and F), and ICD-10 113 Cause (see above) for years 99-2014 - named "ST_counties_99-14_10yr" (ie WI_counties_99-14_10yr.txt)
4. A query by County (all counties in a state), Age (10 yr groups 85+), Gender (both M and F), and ICD-10 113 Cause (see above) for 2014 - named "ST_counties_2014_10yr" (ie WI_counties_2014_10yr.txt)

The WONDER query must be divided into the 5yr and 10 year groupings because WONDER does not provide any population counts for age groups over 84 years unless they are all grouped into the '85+' group which is only available using WONDER's 10yr grouping. We use the 5 year groups so that we are able to reconstruct the same age groups used in previous versions of ITHIM. 

This chunk reads in the data. Obtaining the full detailed mortality needed for ITHIM requires querying CDC WONDER no less than 4 times. The number of rows must be set for the 10 and 5 yr data files, so that meta-data stored at the end of the text file is not read in.  

```{r}
#read in data for ages 0-84 (AKA 5yr age groups)
numberOfRows <- 33696

wonder <- read.table("./WI_counties_99-14_5yr.txt", sep="\t", as.is = T, nrows = numberOfRows, skip=1)
header <- read.table("./WI_counties_99-14_5yr.txt", sep="\t", as.is = T, nrows = 1)
colnames(wonder) <- unlist(header)


wonderSingleYear <- read.table("./WI_counties_2014_5yr.txt", sep="\t", as.is = T, nrows = numberOfRows, skip=1)
header <- read.table("./WI_counties_2014_5yr.txt", sep="\t", as.is = T, nrows = 1)
colnames(wonderSingleYear) <- unlist(header)
wonderSingleYear$POPclean <- ifelse(wonderSingleYear$Population== "Suppressed", sample(0:9), as.numeric(as.character(wonderSingleYear$Population))) 
wonderSingleYear$POP2014 <- as.numeric(as.character(wonderSingleYear$POPclean))

wonder <- cbind(wonder, wonderSingleYear["POP2014"])


#read in data for ages 85plus (AKA 10yr age groups)
numberOfRows <- 1872
wonder10 <- read.table("./WI_counties_99-14_10yr.txt", sep="\t", as.is = T, nrows = numberOfRows, skip=1)
#header <- read.table("./WI_counties_99-14_10yr.txt", sep="\t", as.is = T, nrows = 1)
colnames(wonder10) <- unlist(header)

wonderSingleYear10 <- read.table("./WI_counties_2014_10yr.txt", sep="\t", as.is = T, nrows = numberOfRows, skip=1)
#header <- read.table("./WI_counties_2014_10yr.txt", sep="\t", as.is = T, nrows = 1)
colnames(wonderSingleYear10) <- unlist(header)
wonderSingleYear10$POPclean <- ifelse(wonderSingleYear10$Population== "Suppressed", sample(0:9), as.integer(as.character(wonderSingleYear10$Population))) 
wonderSingleYear10$POP2014 <- as.numeric(as.character(wonderSingleYear10$POPclean))

wonder10 <- cbind(wonder10, wonderSingleYear10["POP2014"])

wonderall <- rbind(wonder, wonder10)

```

The code binds the data from the 5yr and 10yr age groups to give you all years and includes the age-gender-cause-specific death counts and rate for all years. A column of single-year population is also binded to the table to give you an estimate of the number of people in each age-gender group for that county. Next, the code imputes 'Surpessed' values (counts less than 10) for the all year deaths totals. County-age-gender-cause cells with less than 10 deaths in ~15years  will remian nearly absent from the final data. Though rare, the single year population may also need to be imputed if less than 10 (see above).

Using the imputed death tallies and all year popualtions we calculate a crude rate for each county-age-gener-cause combo, and apply that rate to the single year population to estimate the single year death count. 

```{r}

wonderall$EstImpDeaths <- as.numeric(ifelse(wonderall$Deaths == "Suppressed", sample(0:9), as.integer(as.character(wonderall$Deaths))))
wonderall$EstRate <- wonderall$EstImpDeaths/wonderall$Population
wonderall$EstDeaths <- wonderall$EstRate*wonderall$POP2014

wonderall <- wonderall[,c(2,3,4,6,8,13:16)]
names(wonderall) <- c("county", "countyFIPS", "wonderAge", "wonderGender","wonderCause","POP2014","EstImpDeaths","EstRate","EstDeaths")   


```


One cause in ITHIM is not included in the ICD-10, depression. Here a frame of county-age-gender-depression cells are created, mereged with the appropriate single year populations and merged with the data from WONDER before final application of the burden estimates. 

```{r}

# remove 'Not stated' Age entries
wonderall <- subset(wonderall, wonderAge !="NS")

#depression was not in the WONDER data, since there are no deaths, have to add it manually
depress <- expand.grid(county=unique(wonderall$county), countyFIPS=0, wonderAge=unique(wonderall$wonderAge), wonderGender=unique(wonderall$wonderGender), wonderCause = "Depression", POP2014= 0, EstImpDeaths= 0, EstRate=0, EstDeaths = 0, stringsAsFactors=T)

popSummary <- ddply(wonderall, .(county, wonderGender, wonderAge), summarise, 
                        depressPOP= mean(as.numeric(as.character(POP2014)), na.rm=T))

depress <- merge(depress, popSummary)

depress$POP2014 <- depress$depressPOP

depress <- depress[,c(1:9)]

wonderall <- rbind(wonderall, depress)

```

In order to use this WONDER data with the Global Burden of Disease data from ITHIM, we reclassify the age, gender, and causes to match. This is dependent on the structure of the WONDER query matching ours. 

```{r}
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

wonder <- wonderall[, c("county","wonderGender","ITHIMage","ITHIMcause","EstDeaths","POP2014")]

names(wonder) <- c("county","gender","ITHIMage","ITHIMcause","EstDeaths","POP2014")
```


Finally, this table can be paired with the US GBD numbers to estimate a scaled county burden for each age-gender-cause combination, and this info can be used in ITHIM. 


```{r}

########## this 'wonderall' is a table you can crunch for anything ##################
#summarize by county>Urbanization>Gender<age<cause
wonderSummary <- ddply(wonder, .(county, gender, ITHIMage, ITHIMcause), summarise, 
                       Deaths = sum(as.numeric(as.character(EstDeaths)), na.rm=T),
                       POP = mean(POP2014, na.rm=T)
)


USGBD <- read.csv("../USGBD.csv", header=T)
USGBD$ITHIMage <- as.character(USGBD$ITHIMage)
USGBD$ITHIMcause <- as.character(USGBD$ITHIMcause)

burden <- merge(wonderSummary, USGBD, all.x=T)
burden$deaths <- burden$Deaths
burden$ratio <- ifelse(burden$GBDdeaths == 0, 1, ((burden$deaths/burden$POP)/(burden$GBDdeaths/burden$GBDpop)))
burden$YLL <- burden$ratio * (burden$GBDyll/burden$GBDpop) * burden$POP
burden$YLD <- burden$ratio * (burden$GBDyld/burden$GBDpop) * burden$POP
burden$DALY <- burden$ratio * (burden$GBDdaly/burden$GBDpop) * burden$POP

burden$sex <- factor(ifelse(burden$gender == "Male ","M","F"), levels=c("M","F"))
    
burdenOut <- burden[,c("county","ITHIMcause","sex","ITHIMage","deaths","YLL","YLD","DALY")]
names(burdenOut) <- c("county","disease","sex","ageClass","dproj","yll","yld","daly")

burdenOut <- burdenOut[order(burdenOut$county, burdenOut$disease, burdenOut$sex, burdenOut$ageClass),] 

saveRDS(burdenOut, "./WICountiesBurdens2014.rds")
write.csv(burdenOut, "./WICountiesBurdens2014.csv", row.names=F)

```

We can check the distribution of burden by county-age-gender for particular cause (say, Breast Cancer) in all counties by plotting it. 

