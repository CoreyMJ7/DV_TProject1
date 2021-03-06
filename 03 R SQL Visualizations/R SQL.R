#Our unique graphs are found at the bottom of this code with a description of it in the comments.The data we used looked at the way that Diseases affects different countries by looking at the number of deaths experienced per year (by any disease), and scaled it using a factor called death per 100,000, and looked at the age range of deaths. This data had a year range from 1970-2010 


require(extrafont)

#Graph 1: Scatter plot of number of deaths vs deaths per 100,000. This graph showed that while number of deaths may increase (due to population increase), as the years went by and medicine became more effective the relative death rate per 100,000 actualy went down

ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title='How Disease Affects Number of Deaths Worldwide \n When Compared to Death Per 100,000 Statistics from 1970 to 2010') +
  labs(x="Number of Deaths", y=paste("Death Rate Per 100,000")) +
  layer(data=death_df, 
        mapping=aes(x=as.numeric(as.character(NUMBER_OF_DEATHS)), y=as.numeric(as.character(DEATH_RATE_PER_100_000)), color=YEAR), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  )



#Graph 2: Crosstab that shows the Sum of the number of deaths, deaths per 100,000, and the Ratio of those two measures for Sex and Age Groups and Gives a KPI relating to the ratio.

ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  labs(title='Mortality of the World Population\n Number of Deaths(millions), Sum of Death Rate per 100,000 (millions),\n and Ratio Between the Number of Deaths and Death Rate') +
  labs(x=paste("Age Group"), y=paste("Sex")) +
  layer(data=KPI_df, 
        mapping=aes(x=as.character(age_group), y=sex, label=round(SUM_DEATH,2)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black"), 
        position=position_identity()
  ) +
  layer(data=KPI_df, 
        mapping=aes(x=as.character(age_group), y=sex, label=round(SUM_100,2)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", vjust=2), 
        position=position_identity()
  ) +
  layer(data=KPI_df, 
        mapping=aes(x=as.character(age_group), y=sex, label=round(RATIO, 2)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", vjust=4), 
        position=position_identity()
  ) +
  layer(data=KPI_df, 
        mapping=aes(x=as.character(age_group), y=sex, fill=KPI), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(alpha=0.50), 
        position=position_identity()
        
  )
#Graph 3: Bar chart that compares country to death rate per 1000000 and the average difference associated

df <- death_df %>% group_by(COUNTRY_NAME, SEX) %>% filter(COUNTRY_NAME %in% c("Afghanistan", "China", "Colombia", "Japan", "Korea, Republic of", "Pakistan", "Philippines", "Spain", "United Kingdom", "United States")) %>% filter(SEX %in% c("Female", "Male")) %>% summarize(AVG_DR = mean(DEATH_RATE_PER_100_000))
df1 <- df %>% ungroup %>% group_by(SEX) %>% summarize(WINDOW_AVG_DR=mean(AVG_DR))
df <- inner_join(df, df1, by="SEX") %>% arrange(COUNTRY_NAME)

spread(df, COUNTRY_NAME, AVG_DR) %>% View

ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  facet_wrap(~SEX, ncol=1) +
  labs(title='Country vs Death Rate per 100000 ') +
  labs(x=paste(""), y=paste("Avg. Death Rate per 100000")) +
  layer(data=df, 
        mapping=aes(x=COUNTRY_NAME, y=AVG_DR), 
        stat="identity", 
        stat_params=list(), 
        geom="bar",
        geom_params=list(colour="sky blue", fill="dark green"), 
        position=position_identity()
  ) + coord_flip() +
  layer(data=df, 
        mapping=aes(x=COUNTRY_NAME, y=AVG_DR, label=round(AVG_DR)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", hjust=-0.5), 
        position=position_identity()
  ) +
  layer(data=df, 
        mapping=aes(x=COUNTRY_NAME, y=AVG_DR, label=round(WINDOW_AVG_DR)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", hjust=-2), 
        position=position_identity()
  ) +
  layer(data=df, 
        mapping=aes(x=COUNTRY_NAME, y=AVG_DR, label=round(AVG_DR - WINDOW_AVG_DR)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", hjust=-5), 
        position=position_identity()
  ) +
  layer(data=df, 
        mapping=aes(yintercept = WINDOW_AVG_DR), 
        geom="hline",
        geom_params=list(colour="red")
  ) 



