# Data Source: American Trends Panel Wave 49
# https://www.pewresearch.org/internet/dataset/american-trends-panel-wave-49/
# Accessed: 8/12/2020

# Include packages
packages <- c('tidyverse', 'haven','ggmosaic', 'table1')
lapply(packages, library, character.only = TRUE)

raw.dat = read_sav('C:/Users/annyclaude.joseph/Documents/Joseph_Teaching/AY21-1/MA376/Lectures/American Trends Panel/W49_Jun19/ATP W49.sav')
# names(raw.dat)
#-------------------------------------------------------------------------------------------------------------------------------#
# Prepare data
dat <- raw.dat[,109:142]

#Trust Advertisers: dat$FACE3a_W49      
dat <- dat %>% filter(FACE3a_W49 %in% c(1,2,3,4)) %>% 
  mutate(TrustAdvertisers = case_when(FACE3a_W49 %in% c(1,2)~ 'Yes/Somewhat',
                                      FACE3a_W49 %in% c(3,4)~ 'Not too much/No'))
# table(dat$FACE3a_W49); table(dat$TrustAdvertisers)

#Trust Technology companies: dat$FACE3b_W49      
dat <- dat %>% filter(FACE3b_W49 %in% c(1,2,3,4)) %>% 
  mutate(TrustTechCompany = case_when(FACE3b_W49 %in% c(1,2)~ 'Yes/Somewhat',
                                      FACE3b_W49 %in% c(3,4)~ 'Not too much/No'))
# table(dat$FACE3b_W49); table(dat$TrustTechCompany)

#Trust Law Enforcement: dat$FACE3c_W49      
dat <- dat %>% filter(FACE3c_W49 %in% c(1,2,3,4)) %>% 
  mutate(TrustPolice = case_when(FACE3c_W49 %in% c(1,2)~ 'Yes/Somewhat',
                                 FACE3c_W49 %in% c(3,4)~ 'Not too much/No'))
# table(dat$FACE3c_W49); table(dat$TrustPolice)
 
# Education status:  dat$F_EDUCCAT
dat <- dat %>% filter(F_EDUCCAT %in% c(1,2,3)) %>% 
               mutate(Education = case_when(F_EDUCCAT == 1~ 'College',
                                            F_EDUCCAT !=1~ 'No College'))
# table(dat$F_EDUCCAT); table(dat$College)

# Race: dat$F_RACECMB  
dat <- dat %>% filter(F_RACECMB %in% c(1,2))%>% 
               mutate(Race = case_when(F_RACECMB == 1~ 'White',
                             F_RACECMB !=1~ 'Black'))
# table(dat$F_RACECMB); table(dat$Race)

write.csv(dat[,c(35:39)], 'C:/Users/annyclaude.joseph/Documents/Joseph_Teaching/AY21-1/MA376/Lectures/American Trends Panel/W49_Jun19/Wave49.csv')

#### End
#-------------------------------------------------------------------------------------------------------------------------------#

