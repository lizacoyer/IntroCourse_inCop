# Check if the 'pacman' package is installed, if not install it:
if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")

# Load the required libraries into the current R session:
pacman::p_load(rio, 
               here, 
               tidyverse, 
               skimr,
               plyr,
               janitor,
               lubridate,
               gtsummary, 
               flextable,
               officer,
               epikit, 
               apyramid, 
               scales)


# Import the raw data set:
copdata <- rio::import(here::here("data", "spetses_school.csv"))
# Create cross-tab with the group variable:  
janitor::tabyl(dat = copdata, 
               var1 = age, 
               var2 = group)

# Convert group to a factor and label 0 as teacher, 1 as student:
copdata <- copdata %>% 
  mutate(group = factor(group, 
                        labels = c("teacher", "student")))

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
#| label: check_dose_cols
#| tbl-cap: no caption

# Create summary table for dose response columns: 
drtable <- copdata %>%       
  # Select all the columns with column names that end in upper case 'D':   
  select(ends_with("D", ignore.case = FALSE)) %>%       
  # Create the summary table, excluding missing values:   
  gtsummary::tbl_summary(missing = "no") 

# Print the summary table: 
drtable

