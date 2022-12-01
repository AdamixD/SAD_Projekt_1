plot_inflation_lines_origin <- function(data, title) {
  data |>
    ggplot(aes(x=Period, y=inflation, group=origin, color=origin)) +
    scale_color_viridis(discrete = TRUE, labels = c("Kraje poza strefą Euro", "Kraje w strefie Euro", "Polska", "UE")) +
    geom_line(size=1.5) +
    guides(fill=guide_legend(title=NULL)) +
    xlab("Data") + ylab("Inflacja") +
    ggtitle(title) +
    theme_ipsum() +
    theme(
      legend.title = element_blank(),
      plot.title = element_text(size=18),
      axis.title.x = element_text(size=14),
      axis.title.y = element_text(size=14),
    )
}

plot_inflation_lines_country <- function(data, title) {
  data |>
    ggplot(aes(x=Period, y=inflation, group=country, color=country)) +
    scale_color_viridis(discrete = TRUE) +
    geom_line(size=1.5) +
    guides(fill=guide_legend(title=NULL)) +
    xlab("Data") + ylab("Inflacja") +
    ggtitle(title) +
    theme_ipsum() +
    theme(
      legend.title = element_blank(),
      plot.title = element_text(size=18),
      axis.title.x = element_text(size=14),
      axis.title.y = element_text(size=14),
    )
}

plot_inflation_boxes <- function(data, title) {
  data |>
    ggplot(aes(origin, inflation, fill=origin)) +
    geom_boxplot(size=0.7) +
    scale_fill_viridis(discrete = TRUE, alpha=0.6) +
    ylab("Inflacja") +
    ggtitle(title) +
    theme_ipsum() +
    theme(
      legend.position = "none",
      plot.title = element_text(size=18),
      axis.title.x = element_blank(),
      axis.title.y = element_text(size=14)
    )
}

plot_inflation_lines_country_multiple <-  function(data1, title1, data2, title2) {
  ggarrange(plot_inflation_lines_country(data1, title1),
            plot_inflation_lines_country(data2, title2),
            ncol = 2, nrow = 1)
}



### Line (origin)
# Creating plot - since 2000
plot_inflation_lines_origin(since_2000_data, "Poziom inflacji od 2000 roku")

# Creating plot - before pandemic
plot_inflation_lines_origin(before_pandemic_data, "Poziom inflacji przed pandemią")

# Creating plot -  pandemic
plot_inflation_lines_origin(pandemic_data, "Poziom inflacji w szczycie pandemii")

# Creating plot - before war
plot_inflation_lines_origin(before_war_data, "Poziom inflacji przed wojną")

# Creating plot - war
plot_inflation_lines_origin(war_data, "Poziom inflacji od początku wojny")



### Line (country) - Eurozone
# Creating plot - since 2000
plot_inflation_lines_country(eurozone_since_2000_data, "Poziom inflacji w strefie Euro od 2000 roku")

# Creating plot - before pandemic
plot_inflation_lines_country(eurozone_before_pandemic_data, "Poziom inflacji w strefie Euro przed pandemią")

# Creating plot -  pandemic
plot_inflation_lines_country(eurozone_pandemic_data, "Poziom inflacji w strefie Euro w szczycie pandemii")

# Creating plot - before war
plot_inflation_lines_country(eurozone_before_war_data, "Poziom inflacji w strefie Euro przed wojną")

# Creating plot - war
plot_inflation_lines_country(eurozone_war_data, "Poziom inflacji w strefie Euro od początku wojny")



### Line (country) - Countries not in eurozone
# Creating plot - since 2000
plot_inflation_lines_country(other_since_2000_data, "Poziom inflacji poza strefą Euro od 2000 roku")

# Creating plot - before pandemic
plot_inflation_lines_country(other_before_pandemic_data, "Poziom inflacji poza strefą Euro przed pandemia")

# Creating plot -  pandemic
plot_inflation_lines_country(other_pandemic_data, "Poziom inflacji poza strefą Euro w szczycie pandemii")

# Creating plot - before war
plot_inflation_lines_country(other_before_war_data, "Poziom inflacji poza strefą Euro przed wojną")

# Creating plot - war
plot_inflation_lines_country(other_war_data, "Poziom inflacji poza strefą Euro od początku wojny")



### Line (country) - Multiple zones
# Creating plot - since 2000
plot_inflation_lines_country_multiple(eurozone_since_2000_data, "Poziom inflacji w strefie Euro od 2000 roku",
                                      other_since_2000_data, "Poziom inflacji poza strefą Euro od 2000 roku")

# Creating plot - before pandemic
plot_inflation_lines_country_multiple(eurozone_before_pandemic_data, "Poziom inflacji w strefie Euro przed pandemią",
                                      other_before_pandemic_data, "Poziom inflacji poza strefą Euro przed pandemią")

# Creating plot -  pandemic
plot_inflation_lines_country_multiple(eurozone_pandemic_data, "Poziom inflacji w strefie Euro w szczycie pandemii",
                                      other_pandemic_data, "Poziom inflacji poza strefą Euro w szczycie pandemii")

# Creating plot - before war
plot_inflation_lines_country_multiple(eurozone_before_war_data, "Poziom inflacji w strefie Euro przed wojną",
                                      other_before_war_data, "Poziom inflacji poza strefą Euro przed wojną")

# Creating plot - war
plot_inflation_lines_country_multiple(eurozone_war_data, "Poziom inflacji w strefie Euro od początku wojny",
                                      other_war_data, "Poziom inflacji poza strefą Euro od początku wojny")



### Box - Average inflation in period
# Creating plot - since 2000
plot_inflation_boxes(since_2000_data, "Poziom inflacji od 2000 roku (uśredniona wartość w okresie)")

# Creating plot - before pandemic
plot_inflation_boxes(before_pandemic_data, "Poziom inflacji przed pandemią (uśredniona wartość w okresie)")

# Creating plot -  pandemic
plot_inflation_boxes(pandemic_data, "Poziom inflacji w szczycie pandemii (uśredniona wartość w okresie)")

# Creating plot - before war
plot_inflation_boxes(before_war_data, "Poziom inflacji przed wojną (uśredniona wartość w okresie)")

# Creating plot - war
plot_inflation_boxes(war_data, "Poziom inflacji od początku wojny (uśredniona wartość w okresie)")



### Box - Inflation in period
# Creating plot - since 2000
plot_inflation_boxes(inflation_since_2000_data, "Poziom inflacji od 2000 roku")

# Creating plot - before pandemic
plot_inflation_boxes(inflation_before_pandemic_data, "Poziom inflacji przed pandemią")

# Creating plot -  pandemic
plot_inflation_boxes(inflation_pandemic_data, "Poziom inflacji w szczycie pandemii")

# Creating plot - before war
plot_inflation_boxes(inflation_before_war_data, "Poziom inflacji przed wojną")

# Creating plot - war
plot_inflation_boxes(inflation_war_data, "Poziom inflacji od początku wojny")



### Summary
# Eurozone
summary_eurozone_since_2000 <- inflation_since_2000_data |> filter(origin == 'Kraje w strefie Euro') |> summary()
summary_eurozone_before_pandemic <- inflation_before_pandemic_data |> filter(origin == 'Kraje w strefie Euro') |> summary()
summary_eurozone_pandemic <- inflation_pandemic_data |> filter(origin == 'Kraje w strefie Euro') |> summary()
summary_eurozone_before_war <- inflation_before_war_data |> filter(origin == 'Kraje w strefie Euro') |> summary()
summary_eurozone_war_data <- inflation_war_data |> filter(origin == 'Kraje w strefie Euro') |> summary()

summary_eurozone_since_2000[,3]
summary_eurozone_before_pandemic[,3]
summary_eurozone_pandemic[,3]
summary_eurozone_before_war[,3]
summary_eurozone_war_data[,3]


# Other countries
summary_other_since_2000 <- inflation_since_2000_data |> filter(origin == 'Kraje poza strefą Euro') |> summary()
summary_other_before_pandemic <- inflation_before_pandemic_data |> filter(origin == 'Kraje poza strefą Euro') |> summary()
summary_other_pandemic <- inflation_pandemic_data |> filter(origin == 'Kraje poza strefą Euro') |> summary()
summary_other_before_war <- inflation_before_war_data |> filter(origin == 'Kraje poza strefą Euro') |> summary()
summary_other_war_data <- inflation_war_data |> filter(origin == 'Kraje poza strefą Euro') |> summary()

summary_other_since_2000[,3]
summary_other_before_pandemic[,3]
summary_other_pandemic[,3]
summary_other_before_war[,3]
summary_other_war_data[,3]