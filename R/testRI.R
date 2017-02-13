rm(list=ls())
library("devtools")
install_github("syounkin/ITHIM", ref="devel")
library("ITHIM")
fileNamesList <- list(
    activeTransportTimeFile = "~/GHI/misc/activeTransportTime.csv",
#    roadInjuriesFile = "~/GHI/misc/stata19.csv",
    roadInjuriesFile = "~/GHI/misc/roadInjuries.csv",
    GBDFile = "~/GHI/misc/gbdEngland.csv"
#    GBDFile = "~/GHI/misc/gbd.csv"
)

ITHIM <- createITHIM(fileNamesList)
#ITHIM <- createITHIM()
scenario <- readRDS(file = "~/Downloads/distByRoadTypeScenario4.rds")
base <- readRDS(file = "~/Downloads/distByRoadTypeBaseline.rds")
ITHIM.baseline <- update(ITHIM, list(distRoadType = base))
ITHIM.scenario <- update(ITHIM, list(distRoadType = base))
ITHIM.scenario <- updateRoadInjuries(ITHIM.baseline, ITHIM.scenario)
RIburden <- computeRoadInjuryBurden(ITHIM.baseline, ITHIM.scenario)
(deltaDeaths <- sum(subset(RIburden, burden == "dproj")$delta))
