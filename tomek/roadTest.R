rm(list=ls())
library("ITHIM") # Make sure you're on the devel branch

ITHIM <- createITHIM()

# DistByRoadType

ITHIM.baseline <- readDistByRoadType(ITHIM, system.file("distByRoadTypeBaseline.csv", package = "ITHIM"))
ITHIM.scenario <- readDistByRoadType(ITHIM, system.file("distByRoadTypeScenario.csv", package = "ITHIM"))

# SafetyInNumbers

ITHIM.baseline <- readSafetyInNumbers(ITHIM.baseline, system.file("SiN.csv", package = "ITHIM"))
ITHIM.scenario <- readSafetyInNumbers(ITHIM.scenario, system.file("SiN.csv", package = "ITHIM"))

# RoadInjuries for baseline

ITHIM.baseline <- readRoadInjuries(ITHIM.baseline, system.file("roadInjuriesBaseline.csv", package = "ITHIM"))

# RoadInjuries for scenario using scenario multiplier and baseline RoadInjuries

ITHIM.scenario <- updateRoadInjuries(ITHIM.baseline, ITHIM.scenario)

##################################################################
# refactored functions - individual call

testComputeMultiplier <- computeMultiplier(baseline = ITHIM.baseline, scenario = ITHIM.scenario, safetyInNumbers = getSiN(ITHIM.baseline))

testMultiplyInjuries <- multiplyInjuries(ITHIM.baseline = ITHIM.baseline, ITHIM.scenario = ITHIM.scenario)
