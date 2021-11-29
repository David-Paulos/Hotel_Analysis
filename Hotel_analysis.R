
if (!require('ggplot2')) install.packages('ggplot2'); library('ggplot2')
if (!require('knitr')) install.packages('knitr'); library('knitr')
if (!require('dplyr')) install.packages('dplyr'); library('dplyr')
if (!require('tidyr')) install.packages('tidyr'); library('tidyr')
if (!require('here')) install.packages('tidyr'); library('here')
if (!require('readr')) install.packages('readr'); library('readr')
hotel_df <- read.csv("https://d3c33hcgiwev3.cloudfront.net/GL0bk8O2Sja9G5PDtko2uQ_31e445d7ca64417eb45aeaa08ec90bf1_hotel_bookings.csv?Expires=1638230400&Signature=USt5k8o~ozCdZsiMpeoLs36t0FSDYc5Ie8eDBabhXGMe7XBSUAVl5f4OLYF1OREYGNBj6OnFVpwO62yzrl6OuV2IsuWg9bimdg~kZzotnJ1q2YbuE-z64SJvic1q2i0sZiTtCb-KLQXATDczdDCIwqVf3l36tI0rGyQzocTNgS4_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A")

hotel_types <- unique(hotel_df$hotel)
hotel_types_df <- data.frame(hotel_types)
colnames(hotel_types_df) <- c("Types of Hotels")
kable(hotel_types_df) 
city_hotels <- hotel_df %>% filter(hotel == "City Hotel")
ggplot(city_hotels) + geom_bar(mapping=aes(x=arrival_date_month), fill="dodgerblue1") + 
  theme(axis.text.x = element_text(angle = 45)) + ggtitle("City Hotels") + xlab("") + 
  ylab("Number of guest arrivals")
city_hotels_months_count <- city_hotels %>% count(arrival_date_month)
city_hotels_months_count_df <- data.frame(city_hotels_months_count)
colnames(city_hotels_months_count_df) <- c("Months", "Arrivals")
kable(city_hotels_months_count_df %>% arrange(-Arrivals))

resort_hotels <- hotel_df %>% filter(hotel == "Resort Hotel")
ggplot(resort_hotels) + geom_bar(mapping=aes(x=arrival_date_month), fill="springgreen4") + 
  theme(axis.text.x = element_text(angle = 45)) + ggtitle("Resort Hotels") + xlab("") + 
  ylab("Number of guest arrivals")
resort_hotels_months_count <- resort_hotels %>% count(arrival_date_month)
resort_hotels_months_count_df <- data.frame(resort_hotels_months_count)
colnames(resort_hotels_months_count_df) <- c("Months", "Arrivals")
kable(resort_hotels_months_count_df %>% arrange(-Arrivals))

# unique(hotel_df$meal)
ranking_of_packages <- c("Nº 1", "Nº 2", "Nº 3", "Nº 4", "Nº 5")
packages <- c("BB", "HB", "SC", "Undefined", "FB")
packages_meaning <- c("Bed and Breakfast", "Half Board", "Self Catering", "Undefined", "Full Board")
packages_meaning_in_english <- c("Bed, Breakfast", "Bed, Breakfast, Dinner", "Bed", "Undefined", "Bed, Breakfast, Lunch, Dinner")
packages_units_sold <- c(92310, 14463, 10650, 1169, 798)
meal_plans_df <- data.frame(ranking_of_packages, packages, packages_meaning, packages_meaning_in_english, packages_units_sold)
colnames(meal_plans_df) <- c("Ranking", "Hotel packages", "Meaning of Hotel packages", "What's included on each package", "Units sold in 2015, 2016 and 2017")
kable(meal_plans_df)

ggplot(hotel_df) + geom_bar(mapping=aes(x= market_segment, fill= market_segment)) + 
  theme(axis.text.x = element_text(angle=90)) + labs(fill= "Market Segment", x= "", y="Number of reservations") + 
  facet_wrap(~hotel)