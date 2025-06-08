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
data1 <- data.frame(
    x = 1:100,
    y = cumsum(rnorm(100)),
    group = "A"
)
data2 <- data.frame(
    x = 1:100,
    y = cumsum(rnorm(100)),
    group = "B"
)

# Create individual plots
# Plot 1: With all labels and legend
p1 <- ggplot(data1, aes(x = x, y = y, color = group)) +
    geom_line() +
    labs(
        title = "Plot 1",
        x = "X Axis",
        y = "Y Axis",
        color = "Group"
    ) +
    pltthemetemp

# Plot 2: Without x-axis label (for combined plots)
p2 <- ggplot(data2, aes(x = x, y = y, color = group)) +
    geom_line() +
    labs(
        title = "Plot 2",
        y = "Y Axis",
        color = "Group"
    ) +
    theme(axis.title.x = element_blank()) +
    pltthemetemp

# Plot 3: Without any axis labels (for combined plots)
p3 <- ggplot(data1, aes(x = x, y = y, color = group)) +
    geom_line() +
    labs(
        title = "Plot 3",
        color = "Group"
    ) +
    theme(
        axis.title.x = element_blank(),
        axis.title.y = element_blank()
    ) +
    pltthemetemp

# Plot 4: Without legend (for combined plots)
p4 <- ggplot(data2, aes(x = x, y = y, color = group)) +
    geom_line() +
    labs(
        title = "Plot 4",
        x = "X Axis",
        y = "Y Axis"
    ) +
    theme(legend.position = "none") +
    pltthemetemp

# Extract legend from p1
legend <- get_legend(p1)

# Remove legends from all plots
p1 <- p1 + theme(legend.position = "none")
p2 <- p2 + theme(legend.position = "none")
p3 <- p3 + theme(legend.position = "none")

# Combine plots using plot_grid
combined_plot <- plot_grid(
    p1, p2, p3, p4,
    ncol = 2,
    nrow = 2,
    align = "hv"
)

# Add common legend
combined_plot <- plot_grid(
    combined_plot,
    legend,
    ncol = 1,
    rel_heights = c(4, 0.2)
)

# Add common axis labels using ggdraw
combined_plot <- ggdraw() +
    draw_plot(combined_plot, x = 0.02, y = 0.02, width = 0.98, height = 0.98) +
    draw_label("Y Axis Label", x = 0.02, y = 0.5, angle = 90, size = axis_title_size) +
    draw_label("X Axis Label", x = 0.5, y = 0.02, size = axis_title_size)

# Save plots if save_plots is TRUE
if (save_plots) {
    # Create output directory if it doesn't exist
    if (!dir.exists(pltsavedir)) {
        dir.create(pltsavedir, recursive = TRUE)
    }
    
    # Save combined plot
    ggsave(
        filename = file.path(pltsavedir, "combined_plot.png"),
        plot = combined_plot,
        width = plot_width,
        height = plot_height,
        dpi = plot_dpi
    )
}

# Display plot
print(combined_plot) 