# Importing libraries
library(glue)
library(dplyr)
library(readr)
library(ggthemes)
library(tidyr)
library(hrbrthemes)
library(viridis)
library(ggplot2)
library(ggpubr)

# Importing data
inflation_data <- read.csv("data/EU_Inflation_HICP_data_mod.csv", header = TRUE, sep = ",")
deposits_data <- read.csv("data/EU_deposits_1yr_data_mod.csv", header = TRUE, sep = ",")


# Converting data
inflation_data$Period <- as.Date(inflation_data$Period, format = "%d/%m/%Y")
deposits_data$Period <- as.Date(deposits_data$Period, format = "%d/%m/%Y")


# Converting data to numeric
suppressWarnings(inflation_data[, 2:29] <- sapply(inflation_data[, 2:29], as.numeric))
suppressWarnings(deposits_data[, 2:34] <- sapply(deposits_data[, 2:34], as.numeric))


# Creating subsets (inflation)
eurozone_countries_inflation <- select(inflation_data, matches("Period|Austria|Belgium|Cyprus|Germany|Estonia|Spain|Finland|France|Greece|Ireland|Italy|Lithuania|Luxembourg|Latvia|Malta|Netherlands|Portugal|Slovenia|Slovakia"))
other_countries_inflation <- select(inflation_data, !matches("EU|Austria|Belgium|Cyprus|Germany|Estonia|Spain|Finland|France|Greece|Ireland|Italy|Lithuania|Luxembourg|Latvia|Malta|Netherlands|Portugal|Slovenia|Slovakia"))
all_countries_inflation <- select(inflation_data, !matches("EU"))
poland_inflation <- select(inflation_data, matches("Period|Poland"))


# Creating subsets with average rate (inflation)
eurozone_countries_inflation_avg <- data.frame(eurozone_countries_inflation[1], "Kraje w strefie Euro"=(rowMeans(eurozone_countries_inflation[2:20], na.rm=TRUE)))
other_countries_inflation_avg <- data.frame(other_countries_inflation[1], "Kraje poza strefa Euro"=(rowMeans(other_countries_inflation[2:9], na.rm=TRUE)))
all_countries_inflation_avg <- data.frame(all_countries_inflation[1], "UE"=(rowMeans(all_countries_inflation[2:28], na.rm=TRUE)))
poland_inflation <- data.frame(poland_inflation[1], "Polska"=(rowMeans(poland_inflation[2], na.rm=TRUE)))

inflation_avg <- data.frame(
  inflation_data[1],
  eurozone_countries_inflation_avg[2],
  other_countries_inflation_avg[2],
  all_countries_inflation_avg[2],
  poland_inflation[2]
)

# Converting data to tidy form
eurozone_countries_inflation_tidy <- eurozone_countries_inflation |> pivot_longer(-Period, names_to = "country", values_to = "inflation")
other_countries_inflation_tidy <- other_countries_inflation |> pivot_longer(-Period, names_to = "country", values_to = "inflation")
all_countries_inflation_tidy <- all_countries_inflation |> pivot_longer(-Period, names_to = "country", values_to = "inflation")
poland_inflation_tidy <- poland_inflation |> pivot_longer(-Period, names_to = "country", values_to = "inflation")
inflation_avg_tidy <- inflation_avg |> pivot_longer(-Period, names_to = "origin", values_to = "inflation")


# Creating merged tidy inflation data
eurozone_countries_inflation_tidy_origin <- eurozone_countries_inflation_tidy
other_countries_inflation_tidy_origin <- other_countries_inflation_tidy
all_countries_inflation_tidy_origin <- all_countries_inflation_tidy
poland_inflation_tidy_origin <- poland_inflation_tidy

eurozone_countries_inflation_tidy_origin['origin'] <- "Kraje w strefie Euro"
other_countries_inflation_tidy_origin['origin'] <- "Kraje poza strefą Euro"
all_countries_inflation_tidy_origin['origin'] <- "UE"
poland_inflation_tidy_origin['origin'] <- "Polska"

inflation_tidy_origin <- rbind(eurozone_countries_inflation_tidy_origin,
                          other_countries_inflation_tidy_origin,
                          all_countries_inflation_tidy_origin,
                          poland_inflation_tidy_origin)


# Creating ranges of intervals
since_2000 <- as.Date("01/01/2000", "%d/%m/%Y")
before_pandemic <- as.Date("01/01/2018", "%d/%m/%Y")
pandemic <- as.Date("01/03/2020", "%d/%m/%Y")
before_war <- as.Date("01/02/2021", "%d/%m/%Y")
war <- as.Date("01/02/2022", "%d/%m/%Y")
now <- as.Date("01/09/2022", "%d/%m/%Y")


# Split data to intervals
### Average data
since_2000_data <- inflation_avg_tidy %>% filter(Period >= since_2000 & Period <= now)
before_pandemic_data <- inflation_avg_tidy %>% filter(Period >= before_pandemic & Period < pandemic)
pandemic_data <- inflation_avg_tidy %>% filter(Period >= pandemic & Period < before_war)
before_war_data <- inflation_avg_tidy %>% filter(Period >= before_war & Period < war)
war_data <- inflation_avg_tidy %>% filter(Period >= war & Period <= now)

### Eurozone
eurozone_since_2000_data <- eurozone_countries_inflation_tidy %>% filter(Period >= since_2000 & Period <= now)
eurozone_before_pandemic_data <- eurozone_countries_inflation_tidy %>% filter(Period >= before_pandemic & Period < pandemic)
eurozone_pandemic_data <- eurozone_countries_inflation_tidy %>% filter(Period >= pandemic & Period < before_war)
eurozone_before_war_data <- eurozone_countries_inflation_tidy %>% filter(Period >= before_war & Period < war)
eurozone_war_data <- eurozone_countries_inflation_tidy %>% filter(Period >= war & Period <= now)

### Other countries
other_since_2000_data <- other_countries_inflation_tidy %>% filter(Period >= since_2000 & Period <= now)
other_before_pandemic_data <- other_countries_inflation_tidy %>% filter(Period >= before_pandemic & Period < pandemic)
other_pandemic_data <- other_countries_inflation_tidy %>% filter(Period >= pandemic & Period < before_war)
other_before_war_data <- other_countries_inflation_tidy %>% filter(Period >= before_war & Period < war)
other_war_data <- other_countries_inflation_tidy %>% filter(Period >= war & Period <= now)

### Origin
inflation_since_2000_data <- inflation_tidy_origin %>% filter(Period >= since_2000 & Period <= now)
inflation_before_pandemic_data <- inflation_tidy_origin %>% filter(Period >= before_pandemic & Period < pandemic)
inflation_pandemic_data <- inflation_tidy_origin %>% filter(Period >= pandemic & Period < before_war)
inflation_before_war_data <- inflation_tidy_origin %>% filter(Period >= before_war & Period < war)
inflation_war_data <- inflation_tidy_origin %>% filter(Period >= war & Period <= now)
