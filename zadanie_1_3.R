selected_countries <- c("Poland", "France", "Romania")

inflation_diff <- all_countries_inflation[1:(nrow(all_countries_inflation) - 1),] - all_countries_inflation[2:nrow(all_countries_inflation),]
inflation_diff$Period <- all_countries_inflation[1:(nrow(all_countries_inflation) - 1), 1]

inflation_diff_selected_countries <- subset(inflation_diff, select=(append("Period", selected_countries)))
inflation_diff_selected_countries_tidy <- inflation_diff_selected_countries |> pivot_longer(-Period, names_to = "country", values_to = "difference")

inflation_diff_selected_countries_since_2000_data <- inflation_diff_selected_countries_tidy %>% filter(Period >= since_2000 & Period <= now)


###### Visualization

# ### Histogram (multiple) - since 2000
# plot_histogram_multiple(inflation_diff_selected_countries_since_2000_data, "Histogram różnic poziomów inflacji z miesiąca na miesiąc od 2000 roku")

### Histogram (single) - since 2000
plot_histogram_single(inflation_diff_selected_countries_since_2000_data, "Histogram różnic poziomów inflacji z miesiąca na miesiąc od 2000 roku")



# ### All countries
# all_countries_inflation_since_2000_data <- all_countries_inflation_tidy %>% filter(Period >= since_2000 & Period <= now)
# all_countries_inflation_since_2000_data <- all_countries_inflation_since_2000_data %>% filter(country %in% selected_countries)
#
# plot_rate_lines_selected_countries(all_countries_inflation_since_2000_data,"Poziom inflacji w wybranych krajach od 2000 roku", "inflation")
