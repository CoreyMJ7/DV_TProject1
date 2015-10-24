require("jsonlite")
require("RCurl")
require("ggplot2")

# Three data frames for specific graphing cases
death_df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from DEATH where NUMBER_OF_DEATHS < 100000"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_nar784', PASS='orcl_nar784', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))


summary(death_df)
head(death_df)




