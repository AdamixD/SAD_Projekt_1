selected_countries <- c("Poland", "Germany", "Estonia")

inflation_diff <- all_countries_inflation[1:(nrow(all_countries_inflation) - 1),] - all_countries_inflation[2:nrow(all_countries_inflation),]
inflation_diff$Period <- all_countries_inflation[1:(nrow(all_countries_inflation) - 1), 1]

inflation_diff_selected_countries <- subset(inflation_diff, select=(append("Period", selected_countries)))
inflation_diff_selected_countries_tidy <- inflation_diff_selected_countries |> pivot_longer(-Period, names_to = "country", values_to = "difference")

inflation_diff_selected_countries_since_2000_data <- inflation_diff_selected_countries_tidy %>% filter(Period >= since_2000 & Period <= now)
inflation_diff_selected_countries_before_pandemic_data <- inflation_diff_selected_countries_tidy %>% filter(Period >= before_pandemic & Period < pandemic)
inflation_diff_selected_countries_pandemic_data <- inflation_diff_selected_countries_tidy %>% filter(Period >= pandemic & Period < before_war)
inflation_diff_selected_countries_before_war_data <- inflation_diff_selected_countries_tidy %>% filter(Period >= before_war & Period < war)
inflation_diff_selected_countries_war_data <- inflation_diff_selected_countries_tidy %>% filter(Period >= war & Period <= now)



###### Visualization

### Histogram (multiple)
# Creating histogram - since 2000
plot_histogram_multiple(inflation_diff_selected_countries_since_2000_data, "Histogram różnic poziomów inflacji z miesiąca na miesiąc od 2000 roku")

# Creating histogram - before pandemic
plot_histogram_multiple(inflation_diff_selected_countries_before_pandemic_data, "Histogram różnic poziomów inflacji z miesiąca na miesiąc przed pandemią")

# Creating histogram -  pandemic
plot_histogram_multiple(inflation_diff_selected_countries_pandemic_data, "Histogram różnic poziomów inflacji z miesiąca na miesiąc w szczycie pandemii")

# Creating histogram - before war
plot_histogram_multiple(inflation_diff_selected_countries_before_war_data, "Histogram różnic poziomów inflacji z miesiąca na miesiąc przed wojną")

# Creating histogram - war
plot_histogram_multiple(inflation_diff_selected_countries_war_data, "Histogram różnic poziomów inflacji z miesiąca na miesiąc od początku wojny")


### Histogram (single)
# Creating histogram - since 2000
plot_histogram_single(inflation_diff_selected_countries_since_2000_data, "Histogram różnic poziomów inflacji z miesiąca na miesiąc od 2000 roku")

# Creating histogram - before pandemic
plot_histogram_single(inflation_diff_selected_countries_before_pandemic_data, "Histogram różnic poziomów inflacji z miesiąca na miesiąc przed pandemią")

# Creating histogram -  pandemic
plot_histogram_single(inflation_diff_selected_countries_pandemic_data, "Histogram różnic poziomów inflacji z miesiąca na miesiąc w szczycie pandemii")

# Creating histogram - before war
plot_histogram_single(inflation_diff_selected_countries_before_war_data, "Histogram różnic poziomów inflacji z miesiąca na miesiąc przed wojną")

# Creating histogram - war
plot_histogram_single(inflation_diff_selected_countries_war_data, "Histogram różnic poziomów inflacji z miesiąca na miesiąc od początku wojny")


