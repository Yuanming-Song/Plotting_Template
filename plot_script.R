# Add text theme to base theme
text_theme <- theme(
    plot.title = element_text(size = plot_title_size),
    axis.title = element_text(size = axis_title_size),
    axis.text = element_text(size = axis_text_size),
    legend.title = element_text(size = legend_title_size),
    legend.text = element_text(size = legend_text_size)
)
pltthemetemp <- plttheme + text_theme

# Example data
set.seed(123)
data <- data.frame(
    x = 1:100,
    y1 = cumsum(rnorm(100)),
    y2 = cumsum(rnorm(100)),
    group = rep(c("A", "B"), each = 50)
)

# Create example plot
p <- ggplot(data, aes(x = x, y = y1, color = group)) +
    geom_line() +
    labs(
        title = "Example Plot",
        x = "X Axis",
        y = "Y Axis",
        color = "Group"
    ) +
    pltthemetemp

# Save plot if save_plots is TRUE
if (save_plots) {
    # Create output directory if it doesn't exist
    if (!dir.exists(pltsavedir)) {
        dir.create(pltsavedir, recursive = TRUE)
    }
    
    # Save plot
    ggsave(
        filename = file.path(pltsavedir, "example_plot.png"),
        plot = p,
        width = plot_width,
        height = plot_height,
        dpi = plot_dpi
    )
}

# Display plot
print(p) 