# Prices - Food
comms <- intersect(unique(som_food$commodity), unique(kenya_food$commodity))[2:9]

# Figuring out which commodity
somalia <- som_food[som_food$commodity %in% comms,]
somalia$usdprice <- as.numeric(somalia$usdprice)

kenya <- kenya_food[kenya_food$commodity %in% comms,]
kenya$usdprice <- as.numeric(kenya$usdprice)

somalia_agg <- aggregate(usdprice ~ date + commodity, data = somalia, FUN = mean, na.rm = TRUE)
somalia_agg$Country <- rep("Somalia", nrow(somalia_agg))

kenya_agg <- aggregate(usdprice ~ date + commodity, data = kenya, FUN = mean, na.rm = TRUE)
kenya_agg$Country <- rep("Kenya", nrow(kenya_agg))

com_data <- rbind(somalia_agg, kenya_agg)
com_data$date <- as.Date(com_data$date)

somal <- somalia_agg[somalia_agg$commodity != "Meat (camel)",] # Removing Camel 

maize_ken <- kenya %>% filter(commodity %in% c("Maize (white)")) # Maize has the best data quality
maize_somal <- somal %>% filter(commodity %in% c("Maize (white)"))

data <- rbind(maize_ken, maize_somal)

data <- data[c(1:180,302:481),] # Selecting overlap

ggplot(data = data, aes(x = date, y = usdprice, col = Country, group = Country))+
  geom_line(size = 1.2) +
  scale_color_manual(values = c("#1B991F", "#03BFD9")) +
  ggtitle("Maize Prices from 2006-2020") + 
  theme_minimal() +
  labs(x = "Date",
       y = "Price ($USD)",
       subtitle = "Data provided by HDX") +
  theme(text=element_text(size=14,  family="serif"))
