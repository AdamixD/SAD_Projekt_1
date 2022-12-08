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

plot_histogram_single <- function(data, title) {
  for (c in unique(data$country)) {
    sub_data <- data |> filter(country == c)
    plot <- sub_data |>
      ggplot(aes(difference, group=1, label=c)) +
      geom_histogram(aes(y=..density..), binwidth=0.1, alpha=0.7, fill="#DCE319FF", color="#95D840FF") +
      geom_density(alpha = 0.2, fill="#481567FF", color="#481567FF") +
      stat_function(fun = dnorm, n = 101, args = list(mean = mean(sub_data$difference, na.rm=TRUE),
                                                      sd = sd(sub_data$difference, na.rm=TRUE)),
                    color="#aa1836", size=1) +
      ggtitle(paste(title, " - ", c)) +
      xlab("Różnica inflacji") + ylab( "Gęstość") +
      theme_ipsum() +
      theme(
        legend.title = element_blank(),
        plot.title = element_text(size=18),
        axis.title.x = element_text(size=14),
        axis.title.y = element_text(size=14),
      )
    print(plot)
  }
}

plot_histogram_multiple <- function(data, title) {
  data |>
    ggplot( aes(x=difference, fill=country, color=country)) +
    geom_histogram(alpha=0.4, position = 'identity') +
    scale_color_viridis(discrete = TRUE, alpha=0.6) +
    scale_fill_viridis(discrete = TRUE) +
    xlab("Różnica inflacji") + ylab("Liczba wystąpień") +
    ggtitle(title) +
    theme_ipsum() +
    theme(
      legend.title = element_blank(),
      plot.title = element_text(size=18),
      axis.title.x = element_text(size=14),
      axis.title.y = element_text(size=14),
    )
}