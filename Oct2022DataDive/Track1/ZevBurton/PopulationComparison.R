# Population

## Getting data
names(male_pop) <- male_pop[12,]
names(male_pop)[3] <- "Country"
names(female_pop) <- female_pop[12,]
names(female_pop)[3] <- "Country"

## Filtering
kenya_male <- male_pop[male_pop$Country == "Kenya",] %>% filter(Year == 2019)
kenya_female <- female_pop[female_pop$Country == "Kenya",] %>% filter(Year == 2019)

somalia_male <- male_pop[male_pop$Country == "Somalia",] %>% filter(Year == 2019)
somalia_female <- female_pop[female_pop$Country == "Somalia",] %>% filter(Year == 2019)

## Creating dataset
pop_of_interest <- rbind(somalia_male, somalia_female)
pop_of_interest <- rbind(pop_of_interest, kenya_male)
pop_of_interest <- rbind(pop_of_interest, kenya_female)
Gender <- c("Male", "Female", "Male", "Female")
pop_of_interest$Gender <- Gender
pop_of_interest <- pop_of_interest[,c(3, 33, 12:32)]

data <- melt(pop_of_interest, id.vars=c("Country", "Gender"))
data$value <- as.double(data$value)

## Graphing!
ggplot(data = data, aes(x = variable, fill = Gender,
                          y = ifelse(test = Gender == "Male",
                                     yes = -value, no = value))) + 
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("#E73D5A","#2921DE"))+
  scale_y_continuous(labels = abs, limits = max(data$value) * c(-1,1)) +
  labs(y = "Population",
       x = "Age Group",
       title = "Population Pyramids",
       subtitle = "Data from the United Nations Department of Economic and Social Affairs") + 
  coord_flip() +
  facet_wrap(~ Country) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  theme_minimal() +
  theme(strip.text.x = element_text(size = 14),
        text=element_text(size=14,  family="serif")
  )

## As Population_Percentage
kenya <- data[data$Country == "Kenya",]
kenya_pop <- sum(kenya$value)
kenya$value <- kenya$value / kenya_pop

somalia <- data[data$Country == "Somalia",]
somalia_pop <- sum(somalia$value)
somalia$value <- somalia$value / somalia_pop

pop_percent <- rbind(kenya, somalia)
ggplot(data = pop_percent, aes(x = variable, fill = Gender,
                        y = ifelse(test = Gender == "Male",
                                   yes = -value, no = value))) + 
  geom_bar(stat = "identity")+
  scale_fill_manual(values = c("#E73D5A","#2921DE"))+
  scale_y_continuous(labels = abs, limits = max(pop_percent$value) * c(-1,1)) +
  labs(y = "Population Percentage",
       x = "Age Group",
       title = "Population Percentage Pyramids",
       subtitle = "Data from the United Nations Department of Economic and Social Affairs") + 
  coord_flip() +
  facet_wrap(~ Country) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  theme_minimal() +
  theme(strip.text.x = element_text(size = 14),
        text=element_text(size=14,  family="serif")
  )

## Saving Data
write.csv(data, "PopulationData.csv")
write.csv(pop_percent, "PopulationDataByPercent.csv")
