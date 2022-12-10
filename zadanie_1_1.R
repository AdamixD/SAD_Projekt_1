###### Visualization

### Line (avg)
# Creating plot - since 2000
plot_rate_lines_avg(inflation_avg_since_2000_data, "Poziom inflacji od 2000 roku", "inflation")

# Creating plot - since 2018
plot_rate_lines_avg(inflation_avg_since_2018_data, "Poziom inflacji od 2018 roku", "inflation")

# Creating plot - before pandemic
plot_rate_lines_avg(inflation_avg_before_pandemic_data, "Poziom inflacji przed pandemią", "inflation")

# Creating plot -  pandemic
plot_rate_lines_avg(inflation_avg_pandemic_data, "Poziom inflacji w szczycie pandemii", "inflation")

# Creating plot - before war
plot_rate_lines_avg(inflation_avg_before_war_data, "Poziom inflacji przed wojną", "inflation")

# Creating plot - war
plot_rate_lines_avg(inflation_avg_war_data, "Poziom inflacji od początku wojny", "inflation")



### Line (country) - Eurozone
# Creating plot - since 2000
plot_rate_lines_country(eurozone_inflation_since_2000_data, "Poziom inflacji w strefie Euro od 2000 roku", "inflation")

# Creating plot - before pandemic
plot_rate_lines_country(eurozone_inflation_before_pandemic_data, "Poziom inflacji w strefie Euro przed pandemią", "inflation")

# Creating plot -  pandemic
plot_rate_lines_country(eurozone_inflation_pandemic_data, "Poziom inflacji w strefie Euro w szczycie pandemii", "inflation")

# Creating plot - before war
plot_rate_lines_country(eurozone_inflation_before_war_data, "Poziom inflacji w strefie Euro przed wojną", "inflation")

# Creating plot - war
plot_rate_lines_country(eurozone_inflation_war_data, "Poziom inflacji w strefie Euro od początku wojny", "inflation")



### Line (country) - Countries outside the Eurozone
# Creating plot - since 2000
plot_rate_lines_country(other_inflation_since_2000_data, "Poziom inflacji poza strefą Euro od 2000 roku", "inflation")

# Creating plot - before pandemic
plot_rate_lines_country(other_inflation_before_pandemic_data, "Poziom inflacji poza strefą Euro przed pandemia", "inflation")

# Creating plot -  pandemic
plot_rate_lines_country(other_inflation_pandemic_data, "Poziom inflacji poza strefą Euro w szczycie pandemii", "inflation")

# Creating plot - before war
plot_rate_lines_country(other_inflation_before_war_data, "Poziom inflacji poza strefą Euro przed wojną", "inflation")

# Creating plot - war
plot_rate_lines_country(other_inflation_war_data, "Poziom inflacji poza strefą Euro od początku wojny", "inflation")



### Line (country) - Multiple zones
# Creating plot - since 2000
plot_rate_lines_country_multiple(eurozone_inflation_since_2000_data, "Poziom inflacji w strefie Euro od 2000 roku",
                                 other_inflation_since_2000_data, "Poziom inflacji poza strefą Euro od 2000 roku",
                                 "inflation")

# Creating plot - before pandemic
plot_rate_lines_country_multiple(eurozone_inflation_before_pandemic_data, "Poziom inflacji w strefie Euro przed pandemią",
                                 other_inflation_before_pandemic_data, "Poziom inflacji poza strefą Euro przed pandemią",
                                 "inflation")

# Creating plot -  pandemic
plot_rate_lines_country_multiple(eurozone_inflation_pandemic_data, "Poziom inflacji w strefie Euro w szczycie pandemii",
                                 other_inflation_pandemic_data, "Poziom inflacji poza strefą Euro w szczycie pandemii",
                                 "inflation")

# Creating plot - before war
plot_rate_lines_country_multiple(eurozone_inflation_before_war_data, "Poziom inflacji w strefie Euro przed wojną",
                                 other_inflation_before_war_data, "Poziom inflacji poza strefą Euro przed wojną",
                                 "inflation")

# Creating plot - war
plot_rate_lines_country_multiple(eurozone_inflation_war_data, "Poziom inflacji w strefie Euro od początku wojny",
                                 other_inflation_war_data, "Poziom inflacji poza strefą Euro od początku wojny",
                                 "inflation")



### Box - Average inflation in period
# # Creating plot - since 2000
# plot_rate_boxes(inflation_avg_since_2000_data, "Poziom inflacji od 2000 roku (uśredniona wartość w okresie)", "inflation")
#
# # Creating plot - before pandemic
# plot_rate_boxes(inflation_avg_before_pandemic_data, "Poziom inflacji przed pandemią (uśredniona wartość w okresie)", "inflation")
#
# # Creating plot -  pandemic
# plot_rate_boxes(inflation_avg_pandemic_data, "Poziom inflacji w szczycie pandemii (uśredniona wartość w okresie)", "inflation")
#
# # Creating plot - before war
# plot_rate_boxes(inflation_avg_before_war_data, "Poziom inflacji przed wojną (uśredniona wartość w okresie)", "inflation")
#
# # Creating plot - war
# plot_rate_boxes(inflation_avg_war_data, "Poziom inflacji od początku wojny (uśredniona wartość w okresie)", "inflation")
#


### Box - Inflation in period
# Creating plot - since 2000
plot_rate_boxes(inflation_since_2000_data, "Poziom inflacji od 2000 roku", "inflation")

# Creating plot - before pandemic
plot_rate_boxes(inflation_before_pandemic_data, "Poziom inflacji przed pandemią", "inflation")

# Creating plot -  pandemic
plot_rate_boxes(inflation_pandemic_data, "Poziom inflacji w szczycie pandemii", "inflation")

# Creating plot - before war
plot_rate_boxes(inflation_before_war_data, "Poziom inflacji przed wojną", "inflation")

# Creating plot - war
plot_rate_boxes(inflation_war_data, "Poziom inflacji od początku wojny", "inflation")



###### Summary

### Eurozone
summary_inflation_eurozone_since_2000 <- inflation_since_2000_data |> filter(origin == 'Kraje w strefie Euro') |> summary()
summary_inflation_eurozone_before_pandemic <- inflation_before_pandemic_data |> filter(origin == 'Kraje w strefie Euro') |> summary()
summary_inflation_eurozone_pandemic <- inflation_pandemic_data |> filter(origin == 'Kraje w strefie Euro') |> summary()
summary_inflation_eurozone_before_war <- inflation_before_war_data |> filter(origin == 'Kraje w strefie Euro') |> summary()
summary_inflation_eurozone_war_data <- inflation_war_data |> filter(origin == 'Kraje w strefie Euro') |> summary()

summary_inflation_eurozone_since_2000[,3]
summary_inflation_eurozone_before_pandemic[,3]
summary_inflation_eurozone_pandemic[,3]
summary_inflation_eurozone_before_war[,3]
summary_inflation_eurozone_war_data[,3]


### Countries outside the Eurozone
summary_inflation_other_since_2000 <- inflation_since_2000_data |> filter(origin == 'Kraje poza strefą Euro') |> summary()
summary_inflation_other_before_pandemic <- inflation_before_pandemic_data |> filter(origin == 'Kraje poza strefą Euro') |> summary()
summary_inflation_other_pandemic <- inflation_pandemic_data |> filter(origin == 'Kraje poza strefą Euro') |> summary()
summary_inflation_other_before_war <- inflation_before_war_data |> filter(origin == 'Kraje poza strefą Euro') |> summary()
summary_inflation_other_war_data <- inflation_war_data |> filter(origin == 'Kraje poza strefą Euro') |> summary()

summary_inflation_other_since_2000[,3]
summary_inflation_other_before_pandemic[,3]
summary_inflation_other_pandemic[,3]
summary_inflation_other_before_war[,3]
summary_inflation_other_war_data[,3]