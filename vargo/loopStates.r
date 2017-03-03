library(devtools)
install_github("syounkin/ITHIM", ref="devel", force=TRUE)
library("ITHIM")
packageVersion("ITHIM")
rm(list=ls())

######## read in ITHIM objects ####### 
#available at https://uwmadison.box.com/shared/static/06doqkc3aiaoqdb569r7si1vthlyvgu9.rds
#states <- readRDS("~/Downloads/ITHIMList.by.state.rds")
states <- readRDS("~/GHI/R/data/ITHIMList.by.state.rds")

####### Compare States ##################

allStatesResults <- data.frame()

for(i in 1:length(states)){

    results <- data.frame()
    state <- names(states[i])
    base <- states[[state]]

    totalDALYs <- data.frame(getBurden(base, dis = "all"),
                    getBurden(base, dis = "BreastCancer"),
                    getBurden(base, dis = "ColonCancer"),
                    getBurden(base, dis = "CVD"),
                    getBurden(base, dis = "Dementia"),
                    getBurden(base, dis = "Depression"),
                    getBurden(base, dis = "Diabetes")
                    )

    names(totalDALYs) <- c("DALY.all","DALY.BreastCancer","DALY.ColonCancer","DALY.CVD","DALY.Dementia","DALY.Depression","DALY.Diabetes")

    baseWalk <- getMeans(base)$walk
    baseCycle <-  getMeans(base)$cycle

    n <- 4
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
                                              nonTravelActivity = activityLevel)

                deltaDALYs <- data.frame(deltaBurden(base, scenario, dis = "all"),
                                         deltaBurden(base, scenario, dis = "BreastCancer"),
                                         deltaBurden(base, scenario, dis = "ColonCancer"),
                                         deltaBurden(base, scenario, dis = "CVD"),
                                         deltaBurden(base, scenario, dis = "Dementia"),
                                         deltaBurden(base, scenario, dis = "Depression"),
                                         deltaBurden(base, scenario, dis = "Diabetes")
                                         )

                names(deltaDALYs) <- c("deltaDALY.all","deltaDALY.BreastCancer","deltaDALY.ColonCancer","deltaDALY.CVD","deltaDALY.Dementia","deltaDALY.Depression","deltaDALY.Diabetes")


                comparativeRisk <-  cbind(comparativeRisk, deltaDALYs, totalDALYs)

                results <- rbind(comparativeRisk, results)     
            }  
        } 
    }

    allStatesResults <- rbind(results, allStatesResults)
    
}

allStatesResults <- within(allStatesResults,{ 
                           pctTotalDALYS = deltaDALY.all/DALY.all
                           pctBreastCancer = deltaDALY.BreastCancer/DALY.BreastCancer
                           pctColonCancer = deltaDALY.ColonCancer/DALY.ColonCancer
                           pctCVD = deltaDALY.CVD/DALY.CVD
                           pctDementia = deltaDALY.Dementia/DALY.Dementia
                           pctDepression = deltaDALY.Depression/DALY.Depression
                           pctDiabetes = deltaDALY.Diabetes/DALY.Diabetes
})

write.csv(allStatesResults, file = "~/GHI/data/stateResults.csv", quote = FALSE, row.names = FALSE)
