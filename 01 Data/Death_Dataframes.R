require("jsonlite")
require("RCurl")
require("ggplot2")

# Dataframe created from CSV table created in SQL
death_df <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from DISEASE where NUMBER_OF_DEATHS < 100000"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_nar784', PASS='orcl_nar784', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

summary(death_df)
head(death_df)

# Dataframe created from CSV table created in SQL
gdp_df <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from GDP_DATA where COUNTRY_NUMBER < 2"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_nar784', PASS='orcl_nar784', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))


summary(gdp_df)
head(gdp_df)


# Create the Crosstab dataframe
KPI_Low_Max_value = .5 
KPI_Medium_Max_value = 1

KPI_df <- death_df %>% group_by(AGE_GROUP, SEX) %>% summarize(sum_death = sum(NUMBER_OF_DEATHS)/1000000, sum_100 = sum(DEATH_RATE_PER_100_000)/1000000) %>% mutate(ratio = sum_death / sum_100) %>% mutate(kpi = ifelse(ratio <= KPI_Low_Max_value, '03 Low', ifelse(ratio <= KPI_Medium_Max_value, '02 Medium', '01 High'))) %>% rename(age_group=AGE_GROUP, sex=SEX, SUM_DEATH=sum_death, SUM_100=sum_100, RATIO=ratio, KPI=kpi)%>%tbl_df

summary(KPI_df)
head(KPI_df)

#Blended dataframes of death in relation to GDP for a given year
new_death_df <- subset(death_df, select = c(COUNTRY_NAME, SEX, NUMBER_OF_DEATHS, DEATH_RATE_PER_100_000))
dplyr::inner_join(new_death_df, gdp_df, by='COUNTRY_NAME') %>% filter(COUNTRY_NAME %in% c("Afghanistan", "China", "Colombia", "Japan", "Korea, Republic of", "Pakistan", "Philippines", "Spain", "United Kingdom", "United States")) %>% View
