rm(list=ls())

library("ITHIM")

ITHIM.baseline <- createITHIM()

source("~/ITHIM/tests/testthat/helper-RI-usage.R")

ITHIM.baseline <- update(ITHIM.baseline, list(distRoadType = ITHIM:::helperCreateArray(excelDistByRoadTypeBaselineWithoutNOV)$createdArray))

ITHIM.baseline <- update(ITHIM.baseline, list(safetyInNumbers = ITHIM:::helperCreateArray(excelSafetyInNumbersWithoutNOV)$createdArray))


ITHIM.scenario <- update(ITHIM.baseline, list(distRoadType = ITHIM:::helperCreateArray(excelDistByRoadTypeScenarioWithoutNOV)$createdArray))


ITHIM.baseline <- update(ITHIM.baseline, list(roadInjuries = ITHIM:::helperCreateArray(excelRoadInjuriesBaselineWithoutNOV)$createdArray))


ITHIM.scenario <- ITHIM:::updateRoadInjuries(ITHIM.baseline, ITHIM.scenario)



# Make sure you're on the devel branch

  # init ITHIM baseline and scenario using data for helper

  # this part can be prone to errors since createITHIM() by default loads SafetyInNumbers and DistByRoadType Baseline from /inst .
  # In case of lack of these files, test won't work
    # get SafetyInNumbers and DistByRoadType Baseline data from helper, not file (this is why read* methods are not used)


excelDistByRoadTypeBaselineWithoutNOV

