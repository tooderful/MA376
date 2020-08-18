
# Data Source: CEPR 2018 
# https://ceprdata.org/cps-uniform-data-extracts/cps-outgoing-rotation-group/cps-org-data/
# Accessed: 8/13/2020

# Include packages
packages <- c('haven', 'broom', 'tidyverse', 'table1')
lapply(packages, library, character.only = TRUE)

raw.dat <- read_dta('C:/Users/annyclaude.joseph/Documents/Joseph_Teaching/AY21-1/MA376/Lectures/CEPR/cepr_march_2018.dta')
# names(raw.dat)
#-------------------------------------------------------------------------------------------------------------------------------#
# Prepare data
dat <- raw.dat %>% select(educ92, occly2d_03, female, incp_wag, age, marstat, empl, wbhao, perhh)
# names(dat)


dat$Income <- dat$incp_wag                            # Rename variable (Income from wage and salary)
dat$Age <- dat$age
dat <- dat %>% filter(Age >= 18)                      # Restrict age to 18+

# Sex: dat$female
dat <- dat %>% filter(female %in% c(0,1)) %>% 
               mutate(Sex = case_when(female == 1 ~ 'F',
                                      female == 0 ~ 'M'),
                      Sex = factor(Sex, levels = c('F','M')))

# Race: dat$wbhao
dat <- dat %>% filter(wbhao %in% c(1:5)) %>% 
               mutate(Race = case_when(wbhao == 1 ~'White',
                                       wbhao == 2 ~'Black',
                                       wbhao == 3 ~'Hispanic',
                                       wbhao == 4 ~'Asian',
                                       wbhao == 5 ~'Other'),
                      Race = factor(Race, levels = c('White', 'Black',
                                                     'Hispanic', 'Asian','Other')))

# Education level: dat$educ92
dat <- dat %>% filter(educ92 %in% c(1:16)) %>% 
                mutate(Education = case_when(educ92 <=  8 ~ 'Less than HS',
                                            educ92 == 9 ~ 'HS Graduate',
                                            educ92 %in% c(10,11,12) ~ 'Some College/Associates',
                                            educ92 == 13 ~ 'Bachelors',
                                            educ92 == 14 ~ 'Masters',
                                            educ92 %in% c(15,16) ~ 'PhD/MD/JD'),
                      Education = factor(Education, levels = c('Less than HS',
                                           'HS Graduate', 'Some College/Associates', 
                                           'Bachelors', 'Masters', 'PhD/MD/JD')))

# Marital Status: dat$marstat
dat <- dat %>% filter(marstat %in% c(1:5)) %>% 
                mutate(MaritalStatus = case_when(marstat == 1 ~ 'Married',
                                                marstat == 2 ~ 'Widowed', 
                                                marstat == 3 ~ 'Divorced', 
                                                marstat == 4 ~ 'Separated',
                                                marstat == 5 ~ 'Never Married'),
MaritalStatus = factor(MaritalStatus, levels = c('Never Married', 
                                                 'Married', 
                                                 'Separated', 
                                                 'Divorced', 
                                                 'Widowed')))

# Employed: dat$empl
dat <- dat %>% filter(empl %in% c(0:1)) %>% 
           mutate(Employed = case_when(empl == 1 ~ 'Yes',
                                      empl == 0 ~ 'No'),
                      Employed = factor(Employed, levels = c('Yes','No')))


write.csv(dat[,c(10:16)], 'C:/Users/annyclaude.joseph/Documents/Joseph_Teaching/AY21-1/MA376/Lectures/CEPR/CEPR2018.csv')
#### End
#-------------------------------------------------------------------------------------------------------------------------------#

