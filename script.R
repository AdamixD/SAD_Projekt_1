library(ggplot2)
library(glue)
library(readr)

getwd()


# Importing data

inflation_data <- read.csv("data/EU_Inflation_HICP_data_mod.csv", header = TRUE, sep = ",")
inflation_data

deposit_data <- read.csv("data/EU_deposits_1yr_data_mod.csv", header = TRUE, sep = ",")
deposit_data



# Converting date features

inflation_data$Period <- as.Date(inflation_data$Period,
                               format = "%d/%m/%Y")

deposit_data$Period <- as.Date(deposit_data$Period,
                               format = "%d/%m/%Y")



# Data visualization (inflation, deposits)

country = "Estonia"

ggplot(data = inflation_data, aes(x = Period, y = inflation_data[ , c(country_inflation)])) +
  geom_bar(stat = "identity", fill = "purple") +
  labs(title = glue("Inflation in {country}"),
       x = "Date", y = "Inflation rate")


country_deposit = "Estonia..Euro"

ggplot(data = deposit_data, aes(x = Period, y = deposit_data[ , c(country_deposit)])) +
  geom_bar(stat = "identity", fill = "red") +
  labs(title = glue("Deposit interest in {country}"),
       x = "Date", y = "Deposit interest rates")





inflation_data_path <- "data/EU_Inflation_HICP_data.csv"
deposits_data_path <- "data/EU_deposits_1yr_data.csv"

inflation_data <- read.csv(inflation_data_path, header = TRUE, sep = ",")
colnames(inflation_data) <- make.names(colnames(inflation_data))
colnames(inflation_data)[1] <- "Period"

deposits_data <- read.csv(deposits_data_path, header = TRUE, sep = ",")
colnames(deposits_data) <- make.names(colnames(deposits_data))
colnames(deposits_data)[1] <- "Period"

head(inflation_data)
