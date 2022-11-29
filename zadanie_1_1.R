plot_inflation_lines <- function(data, title) {
  data |>
    ggplot(aes(x=Period, y=inflation, group=origin, color=origin)) +
    geom_line(size=1.5) +
    scale_color_viridis(discrete = TRUE) +
    guides(fill=guide_legend(title=NULL)) +
    xlab("Data") + ylab("Inflacja") +
    ggtitle(title) +
    theme_ipsum()
}

plot_inflation_lines_2 <- function(data, title) {
  data |>
    ggplot(aes(Period, inflation, group = origin)) +
    geom_line(aes(color = origin), size=2) +
    xlab("Data") + ylab("Inflacja") +
    ggtitle(title) +
    theme_economist()
}


# Creating plot - entire interval
plot_inflation_lines(inflation_avg_tidy, "Poziom inflacji na przestrzeni lat")

# Creating plot - before pandemic
plot_inflation_lines(before_pandemic_data, "Poziom inflacji przed pandemia")

# Creating plot -  pandemic
plot_inflation_lines(pandemic_data, "Poziom inflacji w szczycie pandemii")

# Creating plot - before war
plot_inflation_lines(before_war_data, "Poziom inflacji przed wojna")

# Creating plot - war
plot_inflation_lines(war_data, "Poziom inflacji od poczatku wojny")

