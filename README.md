Samuel G. Younkin
May, 2016

Welcome to the GHI repository! I hope you will be loving it!

The analysis is performed by running ./R/ITHIM.R.

8 data files are needed:

1. NHTS (National Household Transportation Survey)
  - DAYV2PUB.CSV
  - PERV2PUB.CSV
2. CDC (Center for Disease Control Wonder Database)
  - HHSmetro_Age_sex_2010-14.csv
  - HHSmetro_Age_sex_2014_AllCause.csv
  - USGBD.csv
3. ATUS (American Time Use Survey)
  - ATUS_to_METS_key.csv
  - atuscps_0311.dat
  - atussum_0311.dat

The manuscript code is contained in the manuscript directory.  The
manuscript can be created using the Makefile in the manuiscript
directory.  Only one file is needed to create the manuscript (once
ITHIM.R has been succesfully run) and it is hhsmap.png, the map of the
HHS regions.
