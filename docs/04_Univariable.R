## -----------------------------------------------------------------------------
# Load the required libraries into the current R session:
pacman::p_load(rio, 
               here, 
               skimr,
               janitor,
               gtsummary, 
               flextable,
               officer,
               apyramid, 
               scales,
               epikit,
               EpiStats,
               epitools,
               broom,
               tidyverse
               )



## ----Import_data--------------------------------------------------------------
# Import the raw data set:
copdata <- rio::import(here::here(
  "data",
  "backup",
  "Spetses_clean2.rds"), trust = T)


## -----------------------------------------------------------------------------
# Check if age overall follows a normal distribution:
shapiro.test(copdata$age)
# Can simply have a look at
hist(copdata$age)

# Looking only at the students:
students <- copdata %>% 
  filter(group == "student")
hist(students$age)


## -----------------------------------------------------------------------------
# Perform Wilcoxon rank sum test on age and sex:
wilcox.test(age ~ case, 
            data = copdata)


## -----------------------------------------------------------------------------
copdata %>% 
  select(sex, case) %>% 
  tbl_summary(by = case) %>% 
  add_p()



## -----------------------------------------------------------------------------
copdata %>% 
  select(class, case) %>% 
  tbl_summary(by = case) %>% 
  add_p()



## -----------------------------------------------------------------------------
copdata %>% 
  select(group, case) %>% 
  tbl_summary(by = case) %>% 
  add_p()


## -----------------------------------------------------------------------------

copdata %>% 
  select(sex, class, group, case) %>% 
  tbl_summary(by = case) %>% 
  add_p()



## -----------------------------------------------------------------------------
# You could use the EpiStats package for each food item
CS(copdata, "case", "feta")
CS(copdata, "case", "sardines")
CS(copdata, "case", "eggplant")
CS(copdata, "case", "pasta")


## -----------------------------------------------------------------------------
# You can save time (and probably typos!) by creating a vector for food variables...
food_vars <- c("feta", "sardines", "eggplant", "pasta", 
               "veal", "tomsal", "dessert", "bread",  
               "champagne", "beer", "redwine", "whitewine")

# ...and using EpiStats::CSTable() to run all variables together!
CSTable(copdata, "case", food_vars)


## -----------------------------------------------------------------------------
rr_tbl <- CSTable(copdata, "case", food_vars) %>% 
  as.data.frame() %>% 
  rownames_to_column() %>% 
  flextable() %>% 
   set_header_labels(
     values = c("Food Item",
                "Total exposed",     
               "Cases exposed", 
               "AR among exposed",    
               "Total unexposed",
               "Cases unexposed",
               "AR among unexposed",
               "RR",         
               "95% lower CI",             
               "95% upper CI",
               "p-value"))


## -----------------------------------------------------------------------------
epitools::riskratio(copdata$pastaD,                     
                    copdata$case,                     
                    conf.level = 0.95)


## -----------------------------------------------------------------------------

# Let's get the results directly exponentiated
binom_pastaD_exp <- glm(case ~ pastaD, data = copdata, 
                       family = binomial(link = "log")) %>% 
  tidy(exponentiate = TRUE, 
       conf.int = TRUE)

binom_pastaD_exp


## -----------------------------------------------------------------------------
epitools::riskratio(copdata$vealD,
                    copdata$case,
                    conf.level = 0.95)


## -----------------------------------------------------------------------------
# Binomial regression for RRs. 
# The outcome needs to be exponentiated so we can interpret it properly!
binom_vealD <- glm(case ~ vealD, data = copdata, 
             family = binomial(link = "log"))

# To get exponentiated:
binom_vealD_exp <- glm(case ~ vealD, data = copdata, 
                       family = binomial(link = "log")) %>% 
  tidy(exponentiate = TRUE, 
       conf.int = TRUE)

binom_vealD_exp


## -----------------------------------------------------------------------------
epitools::riskratio(copdata$champagneD,                     
                    copdata$case,                     
                    conf.level = 0.95)


## -----------------------------------------------------------------------------
# Let's get the results directly exponentiated
binom_champagneD_exp <- glm(case ~ champagneD, data = copdata, 
                       family = binomial(link = "log")) %>% 
  tidy(exponentiate = TRUE, 
       conf.int = TRUE)

binom_champagneD_exp

