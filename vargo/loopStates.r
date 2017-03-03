library(devtools)
install_github("syounkin/ITHIM", ref="devel", force=TRUE)
library("ITHIM")
packageVersion("ITHIM")

######## read in ITHIM objects ####### 
#available at https://uwmadison.box.com/shared/static/06doqkc3aiaoqdb569r7si1vthlyvgu9.rds
#states <- readRDS("~/Downloads/ITHIMList.by.state.rds")
states <- readRDS("~/GHI/R/data/ITHIMList.by.state.rds")

####### Compare States ##################

allStatesResults <- data.frame()

#i=48
for(i in 1:3){ 
  results <- data.frame()
  state <- names(states[i])
  base <- states[[state]]

  baseWalk <- getMeans(base)$walk
  baseCycle <-  getMeans(base)$cycle
  # choose this number which controls the number of runs n=3 > 9 runs of  the CRA
  n <- 3
  
  # mean walking and cyling times are varied from half of the baseline to double the baseline
  wVec <- seq(baseWalk,baseWalk+n,length.out = n+1)
  cVec <- seq(baseCycle,baseCycle+n,length.out = n+1)
  ntVec <- c(2, 5, 10)
  

  for(muNT in ntVec){
    for(wlk in 1:(n+1)){
      for(cyc in 1:(n+1)){
        scenario <- update(base, list(muwt = wVec[wlk], muct = cVec[cyc], muNonTravel = muNT))
        activityLevel <- ifelse(muNT == 2, "Low", ifelse(muNT == 5, "Medium", "Low"))
        comparativeRisk <- data.frame(ST = state,
                                      cycleTime = getMeans(scenario)$cycle, 
                                      walkTime= getMeans(scenario)$walk, 
                                      minIncreaseCycle = cyc-1, 
                                      minIncreaseWalk = wlk-1, 
                                      nonTravelActivity = activityLevel,
                                      pctTotalDALYS = deltaBurden(base, scenario)/getBurden(base),
                                      pctBreastCancer= deltaBurden(base, scenario, dis = "BreastCancer")/getBurden(base, dis = "BreastCancer"),
                                      pctColonCancer= deltaBurden(base, scenario, dis = "ColonCancer")/getBurden(base, dis = "ColonCancer"),
                                      pctCVD = deltaBurden(base, scenario, dis = "CVD")/getBurden(base, dis = "CVD"),
                                      pctDementia = deltaBurden(base, scenario, dis = "Dementia")/getBurden(base, dis = "Dementia"),
                                      pctDiabetes = deltaBurden(base, scenario, dis = "Diabetes")/getBurden(base, dis = "Diabetes"),
                                      pctDepression = deltaBurden(base, scenario, dis = "Depression")/getBurden(base, dis = "Depression")
                                      ## totalDALYS = deltaBurden(base, scenario),               
                                      ## BreastCancer= sumBreastCancer(base, scenario), 
                                      ## ColonCancer= sumColonCancer(base, scenario), 
                                      ## CVD = sumCVD(base, scenario), 
                                      ## Dementia = sumDementia(base, scenario), 
                                      ## Depression = sumDepression(base, scenario),
                                      ## Diabetes = sumDiabetes(base, scenario)
                                      )

        results <- rbind(comparativeRisk, results)     
      }  
    } 
  }

  allStatesResults <- rbind(results, allStatesResults)
 
}
