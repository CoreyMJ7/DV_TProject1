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
  )+
  x  = factor(x, levels=c("0-6 d", "7-27 d", "28-364 d","1-4", "5-9", "10-14","15-19", "20-24", "25-29","30-34", "40-44", "45-49","50-54", "55-59","60-64", "65-69", "70-74","75-79", "80+", "All ages"))





#Graph 3: Fare vs Survived w/ As Character
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  #facet_wrap(~SURVIVED) +
  #facet_grid(.~SURVIVED, labeller=label_both) + # Same as facet_wrap but with a label.
  #facet_grid(PCLASS~SURVIVED, labeller=label_both) +
  labs(title='Titanic') +
  labs(x="SURVIVED", y=paste("Fare")) +
  layer(data=df2, 
        mapping=aes(x=SEX, y=as.numeric(as.character(FARE)), color=as.character(SURVIVED)), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )



# Graph 4: Fare vs Survived w/Class Separation
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  facet_grid(PCLASS~SURVIVED, labeller=label_both) +
  labs(title='Titanic') +
  labs(x="SURVIVED", y=paste("FARE")) +
  layer(data=df2, 
        mapping=aes(x=SEX, y=as.numeric(as.character(FARE)), color=SEX), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )





#Graph 5: Fare vs Survived w/P class where age <= 10
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  #facet_wrap(~SURVIVED) +
  #facet_grid(.~SURVIVED, labeller=label_both) + # Same as facet_wrap but with a label.
  facet_grid(PCLASS~SURVIVED, labeller=label_both) +
  labs(title='Titanic where age <= 10') +
  labs(x="SURVIVED", y=paste("Fare")) +
  layer(data=df3, 
        mapping=aes(x=SEX, y=as.numeric(as.character(FARE)), color=SEX), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )



#Graph 6: Age vs Sex w/Embark and Survived - UNIQUE GROUP VISUALIZATION
#Graphs the age vs sex of the passengers and separates this data by where the passenger embarked from and whether they survived
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  #facet_wrap(~SURVIVED) +
  #facet_grid(.~SURVIVED, labeller=label_both) + # Same as facet_wrap but with a label.
  facet_grid(SURVIVED~EMBARKED, labeller=label_both) +
  labs(title='Titanic Age >= 40 vs Sex By Embarked Location & Survival') +
  labs(x="SEX", y=paste("AGE")) +
  layer(data=df4, 
        mapping=aes(x=SEX, y=as.numeric(as.character(AGE)), color=SEX), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.4, height=0)
  )
