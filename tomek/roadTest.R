rm(list=ls())

library("ITHIM") # Make sure you're on the devel branch

# SafetyInNumbers and DistByRoadType Baseline data already included via default input files

ITHIM.baseline <- createITHIM()

# Scenario DistByRoadType

ITHIM.scenario <- update(ITHIM.baseline, list(distRoadType = ITHIM:::readDistByRoadType(system.file("distByRoadTypeScenario.csv", package = "ITHIM"))))

# RoadInjuries for baseline

ITHIM.baseline <- update(ITHIM.baseline, list(roadInjuries = ITHIM:::readRoadInjuries(system.file("roadInjuries.csv", package = "ITHIM"))))

# RoadInjuries for scenario using scenario multiplier and baseline RoadInjuries

ITHIM.scenario <- ITHIM:::updateRoadInjuries(ITHIM.baseline, ITHIM.scenario)

## rm(list=ls())
## library("ITHIM") # Make sure you're on the devel branch

## ITHIM <- createITHIM()

## # DistByRoadType

## ITHIM.baseline <- readDistByRoadType(ITHIM, system.file("distByRoadTypeBaseline.csv", package = "ITHIM"))
## ITHIM.scenario <- readDistByRoadType(ITHIM, system.file("distByRoadTypeScenario.csv", package = "ITHIM"))

## # SafetyInNumbers

## ITHIM.baseline <- readSafetyInNumbers(ITHIM.baseline, system.file("SiN.csv", package = "ITHIM"))
## ITHIM.scenario <- readSafetyInNumbers(ITHIM.scenario, system.file("SiN.csv", package = "ITHIM"))

## # RoadInjuries for baseline

## ITHIM.baseline <- readRoadInjuries(ITHIM.baseline, system.file("roadInjuriesBaseline.csv", package = "ITHIM"))

## # RoadInjuries for scenario using scenario multiplier and baseline RoadInjuries

## ITHIM.scenario <- updateRoadInjuries(ITHIM.baseline, ITHIM.scenario)

## ##################################################################
## # refactored functions - individual call

## testComputeMultiplier <- computeMultiplier(baseline = ITHIM.baseline, scenario = ITHIM.scenario, safetyInNumbers = getSiN(ITHIM.baseline))

## testMultiplyInjuries <- multiplyInjuries(ITHIM.baseline = ITHIM.baseline, ITHIM.scenario = ITHIM.scenario)
