# Plotting Templates

This directory contains templates for creating consistent plots in R using ggplot2.

## Directory Structure

- `plot_template.Rmd`: R Markdown template showing how to set up the environment and include plot scripts
- `plot_script.R`: R script template demonstrating how to create plots following the established conventions
- `combined_plot_script.R`: Template for creating combined plots with proper axis labels and legends

## Important Note on Theme and Text Size Organization for coding agent
⚠️ **CRITICAL**: 
- Rmd setup chunk should ONLY contain:
  - Package loading
  - Base theme (`plttheme`) definition
- Each plot section in Rmd should contain:
  - Text size controls (FIRST, before anything else)
  - Script path
  - Plot settings (save_plots, dimensions, etc.)
  - Commented out `file.edit` command for script creation/modification
  - Script sourcing

## Common Mistakes to Avoid
❌ **DO NOT**:
- Put text size controls in Rmd setup (they should be in each plot section)
- Put text size controls after script path or settings (they must be first in plot section)
- Put text size controls in R scripts (they should be in plot section)
- Define base theme in R scripts (it should be in Rmd setup)
- Put any theme definitions in plot sections (only in setup and R scripts)
- Forget to comment out `file.edit` after creating the script
- Include redundant axis labels in combined plots
- Keep individual legends in combined plots
- Use inconsistent spacing in combined plots
- Save plots without checking save_plots flag
- Hardcode plot saving without conditional check

✅ **DO**:
- Define base theme (`plttheme`) in Rmd setup
- Define text sizes FIRST in each plot section
- Define text theme in each R script
- Keep plot settings together in plot section
- Include commented out `file.edit` command before sourcing
- Source script after all settings are defined
- Remove redundant axis labels in combined plots
- Extract and combine legends for combined plots
- Use proper alignment in combined plots
- Always use conditional plot saving
- Check for directory existence before saving

## Plotting Conventions

### Base Theme (Defined in Rmd setup)
- Transparent panel background
- Horizontal legend at bottom
- Transparent legend background
- Black axis lines (0.3pt width)
- Base text sizes

### Text Sizes (Defined in each plot section)
- Plot title: 10pt
- Axis title: 10pt
- Axis text: 6pt
- Legend title: 8pt
- Legend text: 6pt

### Combined Plot Conventions
- Remove redundant axis labels:
  - Keep labels only on leftmost plots for y-axis
  - Keep labels only on bottom plots for x-axis
  - Use common axis labels for the entire figure
- Legend handling:
  - Extract legend from one plot using `get_legend()`
  - Remove individual legends from all plots
  - Add common legend at the bottom using `plot_grid()`
- Plot alignment:
  - Use `align = "hv"` in `plot_grid()` for proper alignment
  - Use `rel_heights` to control legend spacing
  - Use `ncol` and `nrow` for grid layout
- Common methods:
  - `grid.arrange()`: For simple grid layouts with common labels
  - `plot_grid()`: For more complex layouts with proper alignment

### Plot Saving Conventions
- Always use conditional saving:
  ```r
  if (save_plots) {
      # Create output directory if it doesn't exist
      if (!dir.exists(pltsavedir)) {
          dir.create(pltsavedir, recursive = TRUE)
      }
      
      # Save plot
      ggsave(
          filename = file.path(pltsavedir, "plot_name.png"),
          plot = p,
          width = plot_width,
          height = plot_height,
          dpi = plot_dpi
      )
  }
  ```
- Save settings should be defined in Rmd:
  - `save_plots`: Boolean flag to control saving
  - `pltsavedir`: Output directory path
  - `plot_dpi`: Resolution (default: 1100)
  - `plot_width`: Width in inches
  - `plot_height`: Height in inches

### Plot Dimensions
- Default width: 6.5 inches
- Default height: 2.7 inches
- DPI: 1100

### File Organization
1. Each plot section should be in its own R script
2. R scripts should be sourced from the R Markdown file
3. Plots should be saved to a designated output directory
4. Use consistent naming conventions for output files
5. **IMPORTANT**: Text size controls must be defined FIRST in each plot section
6. **IMPORTANT**: Include commented out `file.edit` command before sourcing
7. **IMPORTANT**: Always use conditional plot saving

## Usage

1. Copy the template files to your project
2. For each plot section in the Rmd file:
   - Define text size controls FIRST
   - Define script path and plot settings
   - Include commented out `file.edit` command for script creation/modification
   - Source the appropriate R script
3. In each R script:
   - Define only the text theme
   - Create and save the plot
4. For combined plots:
   - Create individual plots with appropriate axis labels
   - Extract and combine legends
   - Use proper alignment and spacing
   - Add common axis labels
5. For plot saving:
   - Set `save_plots` flag in Rmd
   - Define output directory and dimensions
   - Use conditional saving in R script
   - Check directory existence before saving
6. Adjust plot dimensions and settings as needed while maintaining the established conventions

## Required Packages
- ggplot2
- dplyr
- tidyr
- gridExtra
- plotly
- readxl
- scales
- grid
- cowplot # Plotting_Template
