## ----Packages-----------------------------------------------------------------
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
               tidyverse
               )



## ----Import_data--------------------------------------------------------------
# Import the clean data set:
copdata <- rio::import(here::here("data",
                                  "backup",
                                  "Spetses_clean1.rds"), trust = TRUE)


## -----------------------------------------------------------------------------

#| echo: false
#| purl: false

# Import outbreak date:
outbreak_dates <- rio::import(here::here(
  "data", 
  "backup", 
  "outbreak_dates.rds"),
  trust = TRUE)

# Set meal date:
mealdate <- paste(outbreak_dates$thisyear, "18:00")



## -----------------------------------------------------------------------------
copdata <- copdata %>% 
  filter(meal == 1)


## -----------------------------------------------------------------------------
copdata <- copdata %>% 
  mutate(gastrosymptoms = case_when(
    # Those had diarrhoea...
    diarrhoea == "1" |
      #or bloody diarrhoea...
    bloody == "1" |
      # or vomiting, are marked as 1 (fell ill after the meal)
    vomiting == "1" ~ 1,
    # The rest are 0 This includes those who ate a meal but had no symptoms (did not fell ill after the meal)
    .default = 0)
    )


## -----------------------------------------------------------------------------
# Start with copdata:
copdata <- copdata %>% 
  # Create new column for meal date and time:
  mutate(meal_datetime = lubridate::ymd_hm(mealdate))


## -----------------------------------------------------------------------------

copdata <- copdata %>% 
  mutate(incubation = onset_datetime - meal_datetime,
         incubation = as.numeric (incubation))


median(as.numeric(copdata$incubation), na.rm = TRUE)



## -----------------------------------------------------------------------------

copdata <- copdata %>% 
  mutate(case = case_when(
    # Those who had symptoms <48h from the meal are cases (1)
    gastrosymptoms == 1 & 
      onset_datetime >= meal_datetime &
      onset_datetime <= (meal_datetime + days(2)) ~ 1,
    # Those who had symptoms >48h from the meal are non-cases (FALSE)
    gastrosymptoms == 1 & 
      onset_datetime > (meal_datetime + days(2)) ~ 0,
    # The rest are considered non-cases. Including, those who had no symptoms at all, who have missing data on the onset_datetime variable, or who had symptoms before eating the meal 
    .default = 0)
  )


## -----------------------------------------------------------------------------
# Tabulate cases:
janitor::tabyl(dat = copdata, case)


## ----overview-----------------------------------------------------------------
copdata %>% 
  summarise(atemeal = sum(meal == 1),
            hadsympt = sum(gastrosymptoms == 1),
            nb_cases = sum(case == 1)
            )


## ----export_clean_data--------------------------------------------------------

rio::export(x = copdata, 
            file = here::here("data", "backup", "Spetses_clean2.rds"))



