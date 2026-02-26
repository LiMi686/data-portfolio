library(readr)
library(readxl)
library(dplyr)
library(ggplot2)
library(tidyr)
# install.packages("lubridate")
library(lubridate)
library(stringr)
# install.packages("zoo")
library(zoo)

# import datasets
cholera = read_csv("datasets/Cholera.csv")
head(cholera, 5)

covid = read_csv("datasets/COVID-19.csv")
head(covid, 5)

dengue = read_excel("datasets/Dengue.xlsx")
head(dengue, 5)


# stream graph for cholera #####################################################
# aggregate values of Total_Cases and Deaths by Year
cholera_aggregated = cholera %>% group_by(Year) %>% summarise(
  Total_Cases_sum = sum(Total_Cases, na.rm = TRUE),
  Deaths_sum = sum(Deaths, na.rm = TRUE)
)

cholera_aggregated$Total_Cases_sum = cholera_aggregated$Total_Cases_sum * (-1)
colnames(cholera_aggregated)[2] = "Total Cases"
colnames(cholera_aggregated)[3] = "Deaths"

head(cholera_aggregated, 5)

# longer format
cholera_long = cholera_aggregated %>% 
  pivot_longer(
    cols = c("Total Cases", "Deaths"), 
    names_to = "Group",
    values_to = "Counts"
  )

head(cholera_long, 5)

# create stream graph using ggplot
ggplot() + 
  geom_area(data = cholera_long, 
            aes(x = Year, y = Counts, fill = Group), alpha=0.6) +
  scale_fill_manual(values=c("#F05039", "#1F449C")) +
  annotate("text", x = 2006, y = 60000, label = "Year 2006, 6311 Deaths", size = 2.2, color = "darkred") +
  annotate("text", x = 2011, y = -589843, label = "Year 2011, 0.59M Cases", size = 3, color = "darkblue") +
  annotate("text", x = 2011, y = 60000, label = "Year 2011, 7816 Deaths", size = 2.2, color = "darkred") +
  annotate("text", x = 2017, y = -1227392, label = "Year 2017, 1.2M Cases", size = 3, color = "darkblue") +
  annotate("text", x = 2017, y = 60000, label = "Year 2017, 5654 Deaths", size = 2.2, color = "darkred") +
  annotate("text", x = 2019, y = -923038, label = "Year 2019, 0.92M Cases", size = 3, color = "darkblue") +
  annotate("text", x = 2023, y = -535321, label = "Year 2023, 0.53M Cases", size = 3, color = "darkblue") +
  labs(title = "Deaths vs. Total Cases for Cholera from Year 2000 - 2023") +
  xlim(1998, 2025) +
  theme_void() +
  theme(legend.key.size = unit(0.5, 'cm'),
        legend.title = element_blank(),
        legend.text = element_text(size=7),
        plot.title = element_text(hjust = 0.5))






# stream graph for covid #######################################################
# extract Year-Month from column Date_reported
covid$Year = year(covid$Date_reported)
covid$Month = month(covid$Date_reported)

# aggregate values of New_cases and New_deaths by Date_reported
covid_aggregated = covid %>% group_by(Year, Month) %>% summarise(
  New_cases_sum = sum(New_cases, na.rm = TRUE),
  New_deaths_sum = sum(New_deaths, na.rm = TRUE)
)

head(covid_aggregated, 5)

covid_aggregated$New_cases_sum = covid_aggregated$New_cases_sum * (-1)
colnames(covid_aggregated)[3] = "New Cases"
colnames(covid_aggregated)[4] = "New Deaths"

# longer format
covid_long = covid_aggregated %>% 
  pivot_longer(
    cols = c("New Cases", "New Deaths"), 
    names_to = "Group",
    values_to = "Counts"
  )

covid_long$time <- rep(1:57, each = 2)

head(covid_long, 5)

covid_count_order = covid_long[order(abs(covid_long$Counts),decreasing = TRUE),]

# create stream graph using ggplot
ggplot() + 
  geom_area(data = covid_long, 
            aes(x = time, y = Counts, fill = Group), alpha=0.6) +
  scale_fill_manual(values=c("#1F449C", "#F05039")) +
  annotate("text", x = 25, y = -91789126, label = "Jan 2022, 91.79M Cases", size = 2, color = "darkblue") +
  annotate("text", x = 36, y = -90982778, label = "Dec 2022, 90.98M Cases", size = 2, color = "darkblue") +
  annotate("text", x = 26, y = -58931493, label = "Feb 2022, 58.93M Cases", size = 2, color = "darkblue") +
  annotate("text", x = 31, y = -31236317, label = "July 2022, 31.24M Cases", size = 2, color = "darkblue") +
  annotate("text", x = 13, y = 3600000, label = "Jan 2021, 0.44M Deaths", size = 1.5, color = "darkred") +
  annotate("text", x = 17, y = 1800000, label = "May 2021, 0.39M Deaths", size = 1.5, color = "darkred") +
  labs(title = "New Deaths vs. New Cases for Covid-19 from Year 2020 - 2024") +
  theme_void() +
  theme(legend.key.size = unit(0.5, 'cm'),
        legend.title = element_blank(),
        legend.text = element_text(size=7),
        plot.title = element_text(hjust = 0.5))






# stream graph for dengue ######################################################
# extract Year-Month from column date
dengue$Year = year(dengue$date)
dengue$Month = month(dengue$date)

# aggregate values of New_cases and New_deaths by Date_reported
dengue_aggregated = dengue %>% group_by(Year, Month) %>% summarise(
  cases_sum = sum(cases, na.rm = TRUE),
  deaths_sum = sum(deaths, na.rm = TRUE)
)

head(dengue_aggregated, 5)

dengue_aggregated$cases_sum = dengue_aggregated$cases_sum * (-1)
colnames(dengue_aggregated)[3] = "Cases"
colnames(dengue_aggregated)[4] = "Deaths"

head(dengue_aggregated, 5)

# longer format
dengue_long = dengue_aggregated %>% 
  pivot_longer(
    cols = c("Cases", "Deaths"), 
    names_to = "Group",
    values_to = "Counts"
  )

dengue_long$time <- rep(1:177, each = 2)

head(dengue_long, 5)

dengue_count_order = dengue_long[order(abs(dengue_long$Counts),decreasing = TRUE),]
dengue_deaths_order = dengue_count_order[dengue_count_order$Group=="Deaths", ]

# create stream graph using ggplot
ggplot() + 
  geom_area(data = dengue_long, 
            aes(x = time, y = Counts, fill = Group), alpha=0.6) +
  scale_fill_manual(values=c("#1F449C", "#F05039")) +
  annotate("text", x = 171, y = -2744539, label = "Mar 2024, 2.74M Cases", size = 2, color = "darkblue") +
  annotate("text", x = 159, y = -815778, label = "Mar 2023, 0.82M Cases", size = 2, color = "darkblue") +
  annotate("text", x = 75, y = -735043, label = "Mar 2016, 0.74M Cases", size = 2, color = "darkblue") +
  annotate("text", x = 113, y = -673702, label = "May 2019, 0.67M Cases", size = 2, color = "darkblue") +
  annotate("text", x = 171, y = 90000, label = "Mar 2024, 1823 Deaths", size = 1.5, color = "darkred") +
  annotate("text", x = 164, y = 30000, label = "Aug 2023, 581 Deaths", size = 1.5, color = "darkred") +
  annotate("text", x = 148, y = 30000, label = "Apr 2022, 322 Deaths", size = 1.5, color = "darkred") +
  labs(title = "New Deaths vs. New Cases for Dengue from Year 2010 - 2024") +
  theme_void() +
  theme(legend.key.size = unit(0.5, 'cm'),
        legend.title = element_blank(),
        legend.text = element_text(size=7),
        plot.title = element_text(hjust = 0.5))





