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
