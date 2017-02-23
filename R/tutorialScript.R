library("devtools")
install_github("syounkin/ITHIM", ref="devel")
library("ITHIM")
fileNamesList <- list(
    activeTransportTimeFile = "~/ITHIM/inst/activeTransportTime.csv",
    roadInjuriesFile = "~/ITHIM/inst/roadInjuries.csv",
    GBDFile = "~/ITHIM/inst/gbd.csv"
)
ITHIM <- createITHIM(fileNamesList)
