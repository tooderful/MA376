# Requires CEPR_2018_Data.csv

# Include packages
packages <- c('tidyverse', 'table1')
lapply(packages, library, character.only = TRUE)
#-------------------------------------------------------------------------------------------------------------------------------#
dat <- read_csv('C:/Users/annyclaude.joseph/Desktop/MA376/CEPR2018.csv')

wage.dat <- dat %>% filter(Income > 0 & 
                              Income <= 150000 & 
                              Education == 'Bachelors') %>% 
                     select(Income, Sex)
table1(~Income|Sex, data=wage.dat)  

set.seed(356)
female.dat <- wage.dat %>% filter(Sex == 'F') 
female.dat <- sample_n(female.dat, 700)

male.dat <- wage.dat %>% filter(Sex == 'M') 
male.dat <- sample_n(male.dat, 700)

wage.dat2 <- rbind(male.dat, female.dat)


table1(~Income|Sex, data=wage.dat2)   # Means are similar


write.csv(wage.dat2, 'C:/Users/annyclaude.joseph/Desktop/MA376/CEPR2018_2.csv')
#### End
#-------------------------------------------------------------------------------------------------------------------------------#


 