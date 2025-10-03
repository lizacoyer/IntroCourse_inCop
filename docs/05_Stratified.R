## -----------------------------------------------------------------------------
# Load the required libraries into the current R session:
pacman::p_load(rio, 
               here, 
               skimr,
               janitor,
               gtsummary, 
               flextable,
               officer,
               epikit, 
               apyramid, 
               scales,
               EpiStats,
               tidyverse
               )


## ----Import_data--------------------------------------------------------------
# Import the raw data set: 
copdata <- rio::import(here::here(
  "data",
  "backup",
  "Spetses_clean2.rds"), 
  trust = TRUE)


## -----------------------------------------------------------------------------
stratall <- copdata %>% 
  # Mutate across to convert cases to numeric:
  mutate(across(.cols = case, 
                .fns = ~ as.numeric(.)))

# Pass data to the csinter function:
pastastrata <- csinter(x = stratall, 
                       cases = "case", 
                       exposure = "veal", 
                       by = "pasta")

pastastrata


## -----------------------------------------------------------------------------
# Perform Wilcoxon rank sum test on veal and pasta:
wilcox.test(veal ~ pasta, 
            data = copdata)


## -----------------------------------------------------------------------------
# Pass data to the csinter function:
champstrata <- csinter(x = stratall, 
                       cases = "case", 
                       exposure = "champagne", 
                       by = "pasta")

