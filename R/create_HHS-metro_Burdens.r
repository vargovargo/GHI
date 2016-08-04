library("plyr")
#setwd("~/Box Sync/work/CoBenefits/MaggieShare/VitalStats/CDCwonder/")

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
#wonder <- read.table("./ITHIM2014_HHS_urb_age_sex_16years.txt", header=T, sep="\t",colClasses=c("Notes"="null"), strip.white=T)

#wonder <- read.csv("./HHSmetro_Age_sex_2010-14.csv", header=T)
wonder <- read.csv("./../data/burden/HHSmetro_Age_sex_2010-14.csv", header=T)
names(wonder) <- c("HHSRegion", "HHSRegionCode", "gender", "genderCode","WONDERage","WONDERageCode","ICD10",  "ICD10Code", "deaths5yr", "population5yr", "crudeRate")

foo <- unique(wonder$HHSRegion)
foo2 <- unique(wonder$HHSRegionCode)


HHSRegions <- matrix(c("CT","ME","MA","NH","RI","VT","NJ","NY","DE","DC","MD","PA","VA","WV","AL","FL","GA","KY","MS","NC","SC","TN","IL","IN","MI","MN","OH","WI","AR","LA","NM","OK","TX","IA","KS","MO","NE","CO","MT","ND","SD","UT","WY","AZ","CA","HI","NV","AK","ID","OR","WA",1,1,1,1,1,1,2,2,3,3,3,3,3,3,4,4,4,4,4,4,4,4,5,5,5,5,5,5,6,6,6,6,6,7,7,7,7,8,8,8,8,8,8,9,9,9,9,10,10,10,10,"HHS1","HHS1","HHS1","HHS1","HHS1","HHS1","HHS2","HHS2","HHS3","HHS3","HHS3","HHS3","HHS3","HHS3","HHS4","HHS4","HHS4","HHS4","HHS4","HHS4","HHS4","HHS4","HHS5","HHS5","HHS5","HHS5","HHS5","HHS5","HHS6","HHS6","HHS6","HHS6","HHS6","HHS7","HHS7","HHS7","HHS7","HHS8","HHS8","HHS8","HHS8","HHS8","HHS8","HHS9","HHS9","HHS9","HHS9","HHS10","HHS10","HHS10","HHS10"), nrow=51,ncol=3)


# remove 'Not stated' Age entries
wonder <- subset(wonder, WONDERageCode !="NS")

#recode cause of death for ITHIM
ITHIMcauseKey <- c("ColonCancer","LungCancer","BreastCancer","Diabetes","Dementia","IHD","InflammatoryHD","InflammatoryHD","HHD",
                   "Stroke","AcuteRespInfections","AcuteRespInfections","RespiratoryDisease","RespiratoryDisease","RTIs","RTIs")
names(ITHIMcauseKey) <- unique(wonder$ICD10)
wonder$ITHIMcause <- ITHIMcauseKey[as.character(wonder$ICD10)]

#recode aage for ITHIM
ITHIMageKey <- c("ageClass1", "ageClass1", "ageClass2", "ageClass2", "ageClass3", "ageClass3", "ageClass3", "ageClass4", "ageClass4", "ageClass4",
                 "ageClass5", "ageClass5", "ageClass5", "ageClass6", "ageClass6", "ageClass7", "ageClass7", "ageClass8", "ageClass8",
                 "ageClass8", "ageClass8", "ageClass8")
names(ITHIMageKey) <- unique(wonder$WONDERage)
wonder$ITHIMage <- ITHIMageKey[as.character(wonder$WONDERage)]



wonder <- wonder[, c("HHSRegion","gender","ITHIMage","ITHIMcause","deaths5yr","population5yr")]

#depression was not in the WONDER data, since there are no deaths, have to add it manually
depress <- expand.grid(HHSRegion=unique(wonder$HHSRegion), gender=unique(wonder$gender),
                       ITHIMage = unique(wonder$ITHIMage), ITHIMcause = "Depression", deaths5yr = "0", population5yr = "0", stringsAsFactors=T)


wonder2 <- rbind(wonder, depress)
tail(wonder2)



#replace 'Suppressed' values with random number 0-9
wonder2$newDeaths <- as.numeric(ifelse(wonder2$deaths5yr == "Suppressed", sample(0:9), as.numeric(as.character(wonder2$deaths5yr))))
class(wonder2$newDeaths) = "numeric"
class(wonder2$population5yr) = "numeric"





#summarize by HHS>Urbanization>Gender<age<cause
wonderSummary <- ddply(wonder2, .(HHSRegion, gender, ITHIMage, ITHIMcause), summarise,
                       numberOfDeaths5yr = sum(as.numeric(as.character(newDeaths)), na.rm=T)
)

#read in data for single year population
#processed in Excel, to combine two WONDER queries, need to go back and script the processing of the raw WONDER output
pop14 <- read.csv("./../data/burden/HHSmetro_Age_sex_2014_AllCause.csv", header=T)
sum(as.numeric(as.character(pop14$Population)),na.rm=T)  #checking US 'Metro' population here 272,667,942
sum(as.numeric(as.character(pop14$Deaths)),na.rm=T)  #checking US 'Metro' deaths here 2,125,273

names(pop14) <- c("HHSRegion", "HHSRegionCode","gender", "genderCode","WONDERage","WONDERageCode", "deaths2014AllCause", "population2014", "crudeRate2014","random1","random2")

#this is delicate(read sloppy), really need to check the order of age groups returned by the 'unique(pop14$WONDERage)' request
ITHIMageKey2 <- c("ageClass8", "ageClass1", "ageClass7", "ageClass7", "ageClass6", "ageClass6", "ageClass1", "ageClass5", "ageClass5",
                 "ageClass5","ageClass4", "ageClass3", "ageClass4", "ageClass2", "ageClass2", "ageClass3", "ageClass4", "ageClass3",
                 "ageClass8")
names(ITHIMageKey2) <- unique(pop14$WONDERage)
pop14$ITHIMage <- ITHIMageKey2[as.character(pop14$WONDERage)]

pop14 <-  pop14[, c("HHSRegion","gender","ITHIMage","deaths2014AllCause","population2014")]
pop14$deaths2014 <- as.numeric(ifelse(pop14$deaths2014 == "Suppressed", sample(0:9), as.numeric(as.character(pop14$deaths2014))))

sum(as.numeric(as.character(pop14$population2014)),na.rm=T)    #checking US 'Metro' population here 272,667,942
sum(as.numeric(as.character(pop14$deaths2014)),na.rm=T)     #checking US 'Metro' deaths here 2,125,273

popSummary <- ddply(pop14, .(HHSRegion, gender, ITHIMage), summarise,
                    population2014 = sum(as.numeric(as.character(population2014)), na.rm=T),
                   AllCauseDeaths2014 = sum(as.numeric(as.character(deaths2014AllCause)), na.rm=T)
)

sum(popSummary$population2014) #checking US population here 272,667,942
sum(popSummary$AllCauseDeaths2014)

HHSmetroCauseSpecific <- merge(wonderSummary, popSummary)

USGBD <- read.csv("./../data/burden/USGBD.csv", header=T)
USGBD$ITHIMage <- as.character(USGBD$ITHIMage)
USGBD$ITHIMcause <- as.character(USGBD$ITHIMcause)

burden <- merge(HHSmetroCauseSpecific, USGBD, all.x=T)
burden$deaths <- burden$numberOfDeaths5yr/5
burden$ratio <- ifelse(burden$GBDdeaths == 0, 1, ((burden$deaths/burden$population2014)/(burden$GBDdeaths/burden$GBDpop)))
burden$YLL <- burden$ratio * (burden$GBDyll/burden$GBDpop) * burden$population2014
burden$YLD <- burden$ratio * (burden$GBDyld/burden$GBDpop) * burden$population2014
burden$DALY <- burden$ratio * (burden$GBDdaly/burden$GBDpop) * burden$population2014

#gah <- subset(burden, ITHIMcause == "RespiratoryDisease")

#ggplot(gah, aes(x=ITHIMage, y=YLD, fill=factor(HHSRegion))) + geom_bar(stat="identity") + geom_point(aes(y=GBDyld)) + facet_grid(gender ~ .)
#ggplot(gah, aes(x=ITHIMage, y=DALY)) + geom_bar(stat="identity") + geom_point(aes(y=GBDdaly)) + facet_grid(gender ~ HHSRegion)

burden$sex <- factor(ifelse(burden$gender == "Male","M","F"))
levels(burden$sex)  <- c("M","F")


burden$sex

burdenOut <- burden[,c("HHSRegion","ITHIMcause","sex","ITHIMage","deaths","YLL","YLD","DALY")]
names(burdenOut) <- c("HHS","disease","sex","ageClass","dproj","yll","yld","daly")

burdenOut <- burdenOut[order(burdenOut$HHS, burdenOut$disease, burdenOut$sex, burdenOut$ageClass),]

write.csv(burdenOut, "./HHSburdens.csv", row.names=F)

