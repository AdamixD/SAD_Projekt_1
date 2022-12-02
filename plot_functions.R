plot_rate_lines_avg <- function(data, title, type) {
  data |>
    ggplot(aes(x=Period, y= if (type == "inflation") inflation else deposits, group=origin, color=origin)) +
    scale_color_viridis(discrete = TRUE, labels = c("Kraje poza strefą Euro", "Kraje w strefie Euro", "Polska", "UE")) +
    geom_line(size=1.5) +
    guides(fill=guide_legend(title=NULL)) +
    xlab("Data") + ylab(if (type == "inflation") "Inflacja" else "Oprocentowanie depozytów") +
    scale_x_date(date_labels = "%b-%Y") +
    ggtitle(title) +
    theme_ipsum() +
    theme(
      legend.title = element_blank(),
      plot.title = element_text(size=18),
      axis.title.x = element_text(size=14),
      axis.title.y = element_text(size=14),
    )
}

plot_rate_lines_country <- function(data, title, type) {
  data |>
    ggplot(aes(x=Period, y=if (type == "inflation") inflation else deposits, group=country, color=country)) +
    scale_color_viridis(discrete = TRUE) +
    geom_line(size=1.5) +
    guides(fill=guide_legend(title=NULL)) +
    xlab("Data") + ylab(if (type == "inflation") "Inflacja" else "Oprocentowanie depozytów") +
    scale_x_date(date_labels = "%b-%Y") +
    ggtitle(title) +
    theme_ipsum() +
    theme(
      legend.title = element_blank(),
      plot.title = element_text(size=18),
      axis.title.x = element_text(size=14),
      axis.title.y = element_text(size=14),
    )
}

plot_rate_boxes <- function(data, title, type) {
  data |>
    ggplot(aes(origin, if (type == "inflation") inflation else deposits, fill=origin)) +
    geom_boxplot(size=0.7) +
    scale_fill_viridis(discrete = TRUE, alpha=0.6) +
    ylab(if (type == "inflation") "Inflacja" else "Oprocentowanie depozytów") +
    ggtitle(title) +
    theme_ipsum() +
    theme(
      legend.position = "none",
      plot.title = element_text(size=18),
      axis.title.x = element_blank(),
      axis.title.y = element_text(size=14)
    )
}

plot_rate_lines_country_multiple <-  function(data1, title1, data2, title2, type) {
  ggarrange(plot_rate_lines_country(data1, title1, type),
            plot_rate_lines_country(data2, title2, type),
            ncol = 2, nrow = 1)
}
