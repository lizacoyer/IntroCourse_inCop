## ----Packages-----------------------------------------------------------------
# Check if the 'pacman' package is installed, if not install it:
if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")

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
# Import the raw data set:
copdata <- import(here::here("data", "raw", "spetses_school.csv"))


## ----Explore_data-------------------------------------------------------------
head(copdata)
dim(copdata)
str(copdata)
skim(copdata)
names(copdata)



## ----age_exploration----------------------------------------------------------
# Have a look at the histogram  
hist(copdata$age)   
# Create cross-tab with the group variable:  
tabyl(dat = copdata, 
               var1 = age, 
               var2 = group)


## ----recode_group-------------------------------------------------------------
# Convert group to a factor and label 0 as teacher, 1 as student:
copdata <- copdata %>% 
  mutate(group = factor(group, 
                        labels = c("teacher", "student")))



## ----cross-tab_age_group------------------------------------------------------

tabyl(dat = copdata, 
               var1 = age, 
               var2 = group) 


## ----age_cleaning-------------------------------------------------------------

# Update incorrect ages to the correct values with case_when:  
copdata <- copdata %>%       
  mutate(age =                         
           case_when(                            
             # Where respondent is 16 and a teacher, change age to 61:
             age == 16 & group == "teacher" ~ 61,              
             # where respondent is 8 or 180 and a student, change age to 18:
             age == 8 & group == "student" ~ 18,              
             age == 180 & group == "student" ~ 18,              
             # Keep remaining values as is:              
             .default = as.numeric(age)   
             # if .default is not working, try:
             # TRUE ~ age
             )                    
         ) 


## -----------------------------------------------------------------------------

#| label: check_dose_cols
#| tbl-cap: no caption

# Create summary table for dose response columns: 
drtable <- copdata %>%       
  # Select all the columns with column names that end in upper case 'D':   
  select(ends_with("D", ignore.case = FALSE)) %>%       
  # Create the summary table, excluding missing values:   
  tbl_summary(missing = "no") 

  # Print the summary table: 
drtable


## ----mutate_simple------------------------------------------------------------
copdata <- copdata %>% 
  mutate(
    sex = as.factor(sex),
    class = as.factor(class),
    ill = as.factor(ill))
 


## ----mutate_cs----------------------------------------------------------------
copdata <- copdata %>% 
  mutate(
    # clinical symptoms
    across(.cols = c(diarrhoea, bloody, vomiting,
             abdo, nausea, fever,headache, jointpain), 
           .fns = ~ as.factor(.)
           )
    )


## ----mutate_food--------------------------------------------------------------
# Create a vector with all the food variables representing the amount of specific foods items eaten (those finishing with a capital "D")
# One way of doing it:
food_dose <- copdata %>% 
    select(
      ends_with("D", ignore.case = FALSE)) %>% 
    names()

# Another way of doing it:
# food_dose <- c("fetaD", "sardinesD", "eggplantD", "pastaD", 
#                 "vealD", "greeksalD", "dessertD", "breadD", 
#                 "champagneD", "beerD", "redwineD", "whitewineD")


copdata <- copdata %>% 
  mutate(
    # food dose variables
    across(.cols = all_of(food_dose), 
           .fns = ~as.factor(.))) 
  


## ----correct_date_format------------------------------------------------------
# Have a look at how the data is stored
head(copdata$dayonset)
class(copdata$dayonset)

# Update copdata:
copdata <- copdata %>% 
  # Change column to date class:
  mutate(
    dayonset = lubridate::dmy(dayonset))

# Check class of updated column:
class(copdata$dayonset)
# Have a look at your data now:
head(copdata$dayonset)


## ----crosstab_dayonset_starthour----------------------------------------------
# Cross-tabulate dayonset with starthour:
tabyl(dat = copdata, 
               var1 = starthour, 
               var2 = dayonset)


## ----combine_date_time--------------------------------------------------------
copdata <- copdata %>% 
  # Combine dayonset and starthour in a new date time variable:
  mutate(onset_datetime = 
           ymd_h(
             str_glue("{dayonset}, {starthour}", .na = ""), 
                                           # Deal with missing starthour:
                                           truncated = 2))


## ----check_onset_datetime-----------------------------------------------------

head(copdata$dayonset)
head(copdata$starthour)
head(copdata$onset_datetime)


## ----export_clean_data--------------------------------------------------------

export(x = copdata, 
            file = here::here("data", "backup", "Spetses_clean1.rds"))


