#Our unique graph is found at the bottom of this code with a description of it in the comments.


require(extrafont)

#Graph 1: Fare vs Age w/ null included
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title='How Disease Affects Number of Deaths Worldwide \n When Compared to Death Per 100,000 Statistics') +
  labs(x="Num Deaths", y=paste("Death Rate Per 100,000")) +
  layer(data=death_df, 
        mapping=aes(x=as.numeric(as.character(NUMBER_OF_DEATHS)), y=as.numeric(as.character(DEATH_RATE_PER_100_000)), color=SEX), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  )



#Graph 2: Fare vs Age w/o null 
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  labs(title='Diamonds Crosstab\nSUM_PRICE, SUM_CARAT, SUM_PRICE / SUM_CARAT') +
  labs(x=paste("COLOR"), y=paste("CLARITY")) +
  layer(data=death_df, 
        mapping=aes(x=AGE_GROUP, y=SEX, label=NUM_DEATHS), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black"), 
        position=position_identity()
  ) +
  layer(data=death_df, 
        mapping=aes(x=AGE_GROUP, y=SEX, label=DEATH_RATE_PER_100_000), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", vjust=2), 
        position=position_identity()
  ) +
  layer(data=death_df, 
        mapping=aes(x=AGE_GROUP, y=SEX, label=round(NUMBER_OF_DEATHS/DEATH_RATE_PER_100_000, 2)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", vjust=4), 
        position=position_identity()
  ) +
  layer(data=death_df, 
        mapping=aes(x=AGE_GROUP, y=SEX, fill=KPI), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(alpha=0.50), 
        position=position_identity()
  )



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
