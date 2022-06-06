################################################################################
#Day 3 - GSheet and DPLYR
################################################################################

################################################################################
#Review
#-------------------------------------------------------------------------------

#Librarys
library(dplyr)
library(gsheet)
library(readr)
library(ggplot2)

#Assign data to variable
people <- read_csv('http://datatrain.global/data/survey.csv')

#See names of columns
names(people)

#just peak at top of data
head(people)

#look at bottom of data
tail(people)

#what is the avg happiness level of lovers of dinos vs lovers of whales
#someone forgot to give whale happiness so results inconclusive
people %>% 
  group_by(dinosaures_or_whales) %>% 
  summarise(avg_hap = mean(happiness))

#how to group and remove the NA
people %>% 
  group_by(dinosaures_or_whales) %>% 
  summarise(avg_hap = mean(happiness, na.rm = TRUE))

#are women happier then men
people %>% group_by(gender) %>% 
  summarise(avg_hap = mean(happiness, na.rm = TRUE))

#avg shoe size in class
people %>% 
  summarise(avg_shoe = mean(shoe_size, na.rm = TRUE), 
            avg_hap = mean(happiness, na.rm = TRUE), avg_he = mean(height, na.rm = TRUE))

#Most common major with case altering 
people %>% mutate(major = toupper(major)) %>% 
  group_by(major) %>% 
  summarise(num_of_people = n()) %>% 
  arrange(desc(num_of_people))

################################################################################
################################################################################
################################################################################

#-------------------------------------------------------------------------------
#Histograms - shows frequency of data
#-------------------------------------------------------------------------------

#Make a histogram of happiness

#create plot and assign data
ggplot(data = people) +
  labs(title = 'My first plot', 
       subtitle = 'June 2 2022', 
       caption = 'Copyright Jenna') +
  geom_histogram(aes(x = happiness), 
                 fill = 'red')
#NOTE: must sorround inside of geom with aes() for it to work

#histogram of sex
ggplot(data = people) + geom_histogram(aes(x = shoe_size), fill = 'blue')

#box plot of height (data looks weird because data is bad)
ggplot(data = people) + geom_boxplot(aes(x = height))

#since data is wrong, remove mistakes via making new data set clean_people
clean_people <- people %>% filter(height <= 250 & height >= 100)

#new plot without outliers
ggplot(data = clean_people) + geom_boxplot(aes(x = height))

#density chart of brithweight ie. simular to histogram (once again poor data)
ggplot(data = people) + geom_density(aes(x = weight))

#make data frame with weights in grams
gpeople <- people %>% filter(weight >= 1000)

#remake plot
ggplot(data = gpeople) + geom_density(aes(x = weight, color = gender))

#get avergae birthweight by gender
gpeople %>% group_by(gender) %>% summarise(avg_weight = mean(weight))

#correlation shoe size and height
ggplot(data = clean_people) + geom_point(aes(x = shoe_size, y = height, color = gender, size = happiness, 
                                             alpha = 0.7, pch = dinosaures_or_whales)) +
  geom_smooth(aes(x = shoe_size, y = height, method = 'lm')) +
  scale_color_manual(name = 'Sex', 
                     values = c('lightblue', 'darkorange'))

#Association between whale liking and male gender
wd <- people %>% group_by(gender, dinosaures_or_whales) %>% summarise(whale_dino_count = n()) %>% 
  ungroup %>% 
  group_by(gender) %>% 
  mutate(total_gender = sum(whale_dino_count)) %>% 
  mutate(precent = (whale_dino_count/total_gender)*100)

#Make point plot of the above data
ggplot(data = wd) + geom_point(aes(x = gender, y = precent, color = dinosaures_or_whales))

#Make Bar Chart
ggplot(data = wd) + geom_bar(aes(x = gender, y = precent, fill = dinosaures_or_whales), 
                             stat = 'identity', alpha = 0.5, color = 'black') + 
  scale_fill_manual(name = 'perfered animal', 
                     values = c('darkgreen', 'darkblue')) +
  labs(x = 'Sex', y = '%', title = 'Girls like Whales', subtitle = 'Very science', caption = 'good chart')


################################################################################
################################################################################
################################################################################

See babyNames.R file








  










