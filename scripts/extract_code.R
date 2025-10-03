######################################
# Generate R scripts from .qmd files
######################################


# Check for and load required packages ------------------------------------

# Check if the 'pacman' package is installed, if not install it:
if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")

# Load required packages with pacman:
pacman::p_load(
  here,
  tidyverse
)


# Get .qmd files and extract R code ---------------------------------------

# Get all .qmd files in scripts folder
qmd_files <- list.files(
  path = here("scripts"),
  pattern = "\\.qmd$",
  full.names = FALSE
)

# Remove index from file list (R code not needed):
qmd_files <- qmd_files[!qmd_files %in% "index.qmd"]

# Extract code from each .qmd file to .R file in same folder
walk(qmd_files, ~ {
  input_file <- here("scripts", .x)
  output_file <- here("scripts", str_replace(.x, "\\.qmd$", ".R"))
  knitr::purl(
    input = input_file,
    output = output_file,
    documentation = 1
  )
})