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
other_countries_inflation <- select(inflation_data, matches("Period|Bulgaria|Czech|Denmark|Croatia|Hungary|Poland|Romania|Sweden"))
all_countries_inflation <- select(inflation_data, !matches("EU"))
poland_inflation <- select(inflation_data, matches("Period|Poland"))

# -- Creating subsets (deposists)
deposits_data <- subset(deposits_data, select=-c(Estonia..Estonian.kroon, Malta..Maltese.lira, Latvia..Latvian.lats, Lithuania..Lithuanian.litas, Slovakia..Slovak.koruna, Slovenia..Slovenian.tolar))

for ( col in 2:ncol(deposits_data)){
  colnames(deposits_data)[col] <-  gsub("\\..*","",colnames(deposits_data)[col])
}

eurozone_countries_deposits <- select(deposits_data, matches("Period|Austria|Belgium|Cyprus|Germany|Estonia|Spain|Finland|France|Greece|Ireland|Italy|Lithuania|Luxembourg|Latvia|Malta|Netherlands|Portugal|Slovenia|Slovakia"))
other_countries_deposits <- select(deposits_data, matches("Period|Bulgaria|Czech|Denmark|Croatia|Hungary|Poland|Romania|Sweden"))
all_countries_deposits <- deposits_data
poland_deposits <- select(deposits_data, matches("Period|Poland"))


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

# -- Creating subsets with average rate (deposits)
eurozone_countries_deposits_avg <- data.frame(eurozone_countries_deposits[1], "Kraje w strefie Euro"=(rowMeans(eurozone_countries_deposits[2:20], na.rm=TRUE)))
other_countries_deposits_avg <- data.frame(other_countries_deposits[1], "Kraje poza strefa Euro"=(rowMeans(other_countries_deposits[2:9], na.rm=TRUE)))
all_countries_deposits_avg <- data.frame(all_countries_deposits[1], "UE"=(rowMeans(all_countries_deposits[2:28], na.rm=TRUE)))
poland_deposits <- data.frame(poland_deposits[1], "Polska"=(rowMeans(poland_deposits[2], na.rm=TRUE)))

deposits_avg <- data.frame(
  deposits_data[1],
  eurozone_countries_deposits_avg[2],
  other_countries_deposits_avg[2],
  all_countries_deposits_avg[2],
  poland_deposits[2]
)



# Converting data to tidy form (inflation)
eurozone_countries_inflation_tidy <- eurozone_countries_inflation |> pivot_longer(-Period, names_to = "country", values_to = "inflation")
other_countries_inflation_tidy <- other_countries_inflation |> pivot_longer(-Period, names_to = "country", values_to = "inflation")
all_countries_inflation_tidy <- all_countries_inflation |> pivot_longer(-Period, names_to = "country", values_to = "inflation")
poland_inflation_tidy <- poland_inflation |> pivot_longer(-Period, names_to = "country", values_to = "inflation")
inflation_avg_tidy <- inflation_avg |> pivot_longer(-Period, names_to = "origin", values_to = "inflation")

# -- Converting data to tidy form (deposits)
eurozone_countries_deposits_tidy <- eurozone_countries_deposits |> pivot_longer(-Period, names_to = "country", values_to = "deposits")
other_countries_deposits_tidy <- other_countries_deposits |> pivot_longer(-Period, names_to = "country", values_to = "deposits")
all_countries_deposits_tidy <- all_countries_deposits |> pivot_longer(-Period, names_to = "country", values_to = "deposits")
poland_deposits_tidy <- poland_deposits |> pivot_longer(-Period, names_to = "country", values_to = "deposits")
deposits_avg_tidy <- deposits_avg |> pivot_longer(-Period, names_to = "origin", values_to = "deposits")



# Creating merged tidy data (inflation)
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

# -- Creating merged tidy data (deposits)
eurozone_countries_deposits_tidy_origin <- eurozone_countries_deposits_tidy
other_countries_deposits_tidy_origin <- other_countries_deposits_tidy
all_countries_deposits_tidy_origin <- all_countries_deposits_tidy
poland_deposits_tidy_origin <- poland_deposits_tidy

eurozone_countries_deposits_tidy_origin['origin'] <- "Kraje w strefie Euro"
other_countries_deposits_tidy_origin['origin'] <- "Kraje poza strefą Euro"
all_countries_deposits_tidy_origin['origin'] <- "UE"
poland_deposits_tidy_origin['origin'] <- "Polska"

deposits_tidy_origin <- rbind(eurozone_countries_deposits_tidy_origin,
                               other_countries_deposits_tidy_origin,
                               all_countries_deposits_tidy_origin,
                               poland_deposits_tidy_origin)



# Creating ranges of intervals
since_2000 <- as.Date("01/01/2000", "%d/%m/%Y")
before_pandemic <- as.Date("01/01/2018", "%d/%m/%Y")
pandemic <- as.Date("01/03/2020", "%d/%m/%Y")
before_war <- as.Date("01/02/2021", "%d/%m/%Y")
war <- as.Date("01/02/2022", "%d/%m/%Y")
now <- as.Date("01/09/2022", "%d/%m/%Y")



# Split data to intervals
### Average data (inflation)
inflation_avg_since_2000_data <- inflation_avg_tidy %>% filter(Period >= since_2000 & Period <= now)
inflation_avg_before_pandemic_data <- inflation_avg_tidy %>% filter(Period >= before_pandemic & Period < pandemic)
inflation_avg_pandemic_data <- inflation_avg_tidy %>% filter(Period >= pandemic & Period < before_war)
inflation_avg_before_war_data <- inflation_avg_tidy %>% filter(Period >= before_war & Period < war)
inflation_avg_war_data <- inflation_avg_tidy %>% filter(Period >= war & Period <= now)

### -- Average data (deposits)
deposits_avg_since_2000_data <- deposits_avg_tidy %>% filter(Period >= since_2000 & Period <= now)
deposits_avg_before_pandemic_data <- deposits_avg_tidy %>% filter(Period >= before_pandemic & Period < pandemic)
deposits_avg_pandemic_data <- deposits_avg_tidy %>% filter(Period >= pandemic & Period < before_war)
deposits_avg_before_war_data <- deposits_avg_tidy %>% filter(Period >= before_war & Period < war)
deposits_avg_war_data <- deposits_avg_tidy %>% filter(Period >= war & Period <= now)



### Eurozone (inflation)
eurozone_inflation_since_2000_data <- eurozone_countries_inflation_tidy %>% filter(Period >= since_2000 & Period <= now)
eurozone_inflation_before_pandemic_data <- eurozone_countries_inflation_tidy %>% filter(Period >= before_pandemic & Period < pandemic)
eurozone_inflation_pandemic_data <- eurozone_countries_inflation_tidy %>% filter(Period >= pandemic & Period < before_war)
eurozone_inflation_before_war_data <- eurozone_countries_inflation_tidy %>% filter(Period >= before_war & Period < war)
eurozone_inflation_war_data <- eurozone_countries_inflation_tidy %>% filter(Period >= war & Period <= now)

### -- Eurozone (deposits)
eurozone_deposits_since_2000_data <- eurozone_countries_deposits_tidy %>% filter(Period >= since_2000 & Period <= now)
eurozone_deposits_before_pandemic_data <- eurozone_countries_deposits_tidy %>% filter(Period >= before_pandemic & Period < pandemic)
eurozone_deposits_pandemic_data <- eurozone_countries_deposits_tidy %>% filter(Period >= pandemic & Period < before_war)
eurozone_deposits_before_war_data <- eurozone_countries_deposits_tidy %>% filter(Period >= before_war & Period < war)
eurozone_deposits_war_data <- eurozone_countries_deposits_tidy %>% filter(Period >= war & Period <= now)



### Countries outside the eurozone (inflation)
other_inflation_since_2000_data <- other_countries_inflation_tidy %>% filter(Period >= since_2000 & Period <= now)
other_inflation_before_pandemic_data <- other_countries_inflation_tidy %>% filter(Period >= before_pandemic & Period < pandemic)
other_inflation_pandemic_data <- other_countries_inflation_tidy %>% filter(Period >= pandemic & Period < before_war)
other_inflation_before_war_data <- other_countries_inflation_tidy %>% filter(Period >= before_war & Period < war)
other_inflation_war_data <- other_countries_inflation_tidy %>% filter(Period >= war & Period <= now)

### -- Countries outside the eurozone (deposits)
other_deposits_since_2000_data <- other_countries_deposits_tidy %>% filter(Period >= since_2000 & Period <= now)
other_deposits_before_pandemic_data <- other_countries_deposits_tidy %>% filter(Period >= before_pandemic & Period < pandemic)
other_deposits_pandemic_data <- other_countries_deposits_tidy %>% filter(Period >= pandemic & Period < before_war)
other_deposits_before_war_data <- other_countries_deposits_tidy %>% filter(Period >= before_war & Period < war)
other_deposits_war_data <- other_countries_deposits_tidy %>% filter(Period >= war & Period <= now)



### Origin (inflation)
inflation_since_2000_data <- inflation_tidy_origin %>% filter(Period >= since_2000 & Period <= now)
inflation_before_pandemic_data <- inflation_tidy_origin %>% filter(Period >= before_pandemic & Period < pandemic)
inflation_pandemic_data <- inflation_tidy_origin %>% filter(Period >= pandemic & Period < before_war)
inflation_before_war_data <- inflation_tidy_origin %>% filter(Period >= before_war & Period < war)
inflation_war_data <- inflation_tidy_origin %>% filter(Period >= war & Period <= now)

### -- Origin (deposits)
deposits_since_2000_data <- deposits_tidy_origin %>% filter(Period >= since_2000 & Period <= now)
deposits_before_pandemic_data <- deposits_tidy_origin %>% filter(Period >= before_pandemic & Period < pandemic)
deposits_pandemic_data <- deposits_tidy_origin %>% filter(Period >= pandemic & Period < before_war)
deposits_before_war_data <- deposits_tidy_origin %>% filter(Period >= before_war & Period < war)
deposits_war_data <- deposits_tidy_origin %>% filter(Period >= war & Period <= now)

