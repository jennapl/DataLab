#Day 2 DataLab

############################################

#Review - Maps

#Calling libraries
library(leaflet)
library(gsheet)
library(dplyr)
library(readr)

# %>% means THEN

#Make map of world
leaflet() %>% addTiles()

#Practice

whales <- read_csv('https://raw.githubusercontent.com/ericmkeen/capstone/master/fin_whales.csv')

#view data set in table
whales %>% View

#make map of markers
leaflet() %>% 
  addProviderTiles(providers$Esri.WorldGrayCanvas) %>% 
  addCircleMarkers( data = whales , 
                    radius = 1, 
                    color = "red")
#Scale points
leaflet() %>% 
  addProviderTiles(providers$Esri.WorldGrayCanvas) %>% 
  addCircleMarkers( data = whales , 
                    #scale point radius by group size
                    radius = whales$size, 
                    color = "red")

#adding mouse over feature
leaflet() %>% 
  addProviderTiles(providers$Esri.WorldGrayCanvas) %>% 
  addCircleMarkers( data = whales , 
                    radius = whales$size, 
                    color = "red",
                    #gets label
                    label = whales$date)

#Add cluster option to the sightings
leaflet() %>% 
  addProviderTiles(providers$Esri.WorldGrayCanvas) %>% 
  addCircleMarkers( data = whales , 
                    radius = whales$size, 
                    color = "red",
                    label = whales$date,
                    #gets clusters
                    clusterOptions = markerClusterOptions())

#Save this map as an object (nothing happens so call m to show map)
m <- leaflet() %>% 
  addProviderTiles(providers$Esri.WorldGrayCanvas) %>% 
  addCircleMarkers( data = whales , 
                    radius = whales$size, 
                    color = "red",
                    label = whales$date,
                    clusterOptions = markerClusterOptions())

#show map
m

#install.packages("leaflet.extras")
library(leaflet.extras)

#Take measurements on map (can track measurements)
m %>% addDrawToolbar()

###############################################################################

#Review - Vectors

#Vector - set of stores values

#A character Vector
teachers <- c('eric', 'joe', 'matthew')

#A numeric vector
teachers_Heights <- c(202, 180, 178)

#can make vectors as another vector (num become strings in this case)
c(teachers, teachers_Heights)

#Second way to make a vector, : colon (can be done mostly for numbers)
1:10
10:1

#Third way
#seq: makes an evenly spaced sequence of numbers between a min and a max
seq(1,       100, length = 25)
    #start   #end  #how many values

seq(1, 100, by = 10)

#Fourth way
#rep: makes value of length times
#char and num
rep(1, times= 100)

rep("oh heyyyyyy", times = 5)

#repeat this vector from 1-2 and repeat it 5 times
rep(1:2, each = 5)

rep(teachers, each = 5)

#rnorm - randomly drown vector of values (from a bell curve)
rnorm(10)

#runif - (from a uniform random distribution, double)
runif(10)

###############################################################################

#Pracice w/ vector
x <- 0:100
y <- 5:105

#you can add vectors together if have same num of values
x + y
x - y
x / y
x * y

#Working with vectors of different lengths
xx <- runif(100, min = 0, max = 1000)

#add 5 to each num (can do other math on vector like such)
xx + 5

#How long is x?
xx %>% length
xx %>% min #min of vector
xx %>% max #max
  
#Sort vector by value
xx %>% sort

#first few values
xx %>% head

#last few values
xx %>%  tail

#sort by descending value
xx %>% sort %>% rev #rev means reverse

#Coin Toss
runif(1) <= 0.5

#pick randomly num 1-10
runif(1, min = 0, max = 10) %>%  round

#for picking subsections to randomly take test vectors, you can do the following
#random set of lat of 50 locations
latitude <- runif(50, min = 35.19, max = 35.21)

#random set of long of 50 locations
#() on outside assigns and shows the values picked, non () does now show
(longitude <- runif(50, min = -85.93, max = -85.91))

#put values in dataframe (table with variable names as "labels")
df <- data.frame(latitude, longitude)

#now make a map of data
treeMap <- leaflet() %>% addProviderTiles(providers$OpenStreetMap) %>% 
  addCircleMarkers(
    data = df, 
    radius = 1, 
    color = "red")

###############################################################################
###############################################################################
###############################################################################


#Into to Data Visualization - Joe Lecture

# Words are NOT enough
# Tables present data without needing words
# However, still ineffective
# Data Scientists often computer to audiences as if they were computers
# People see more visually!
# If you do not speak the language of the listener, you are the problem
# Present data from general to specific
# Research papers show important info but no one reads because it is not visual
# Engage audiences by using flashy visuals that make people look for LONG
# BEAUTY MATTERS in data visualization
# Monkey brains = likes shinny object
# Never use pie charts because humans are bad at seeing area

#-------------------------------------------------------------------------------
# Tips and notes regarding data visualization
#-------------------------------------------------------------------------------
# visual > words 
# Try not to use 3D models 
# Watch ink to info ratio
# Make sure beatuty does not sacrifice content
# Make it pretty
# Less is more
# Straight forward
# Contrasting colors 
# Titles and labels with measurements
# Meet people where they are at
# Be mindful of audiences perceptions (ie. pink = breast cancer)

################################################################################


#Intro to plots
#-------------------------------------------------------------------------------

#Vocab:
# Verbs with plots
# filter(keep_condition) - get rid of stuff 
# arrange() - put in order (default, small to big, a to z)
# mutate(name of value and what it will do) - change or create a variable
# summarise() - find one value for all the values (avg, min, max)
# select() - keep only these columns
# rename() - rename the variable
# distinct() - keep only one of each type

#Practice
#-------------------------------------------------------------------------------

#Library
library(dplyr)
library(gsheet)
library(readr)

#Assign people with data
people <- read_csv('http://datatrain.global/data/survey.csv')

#view data
people %>% View
people %>% 
  group_by(dinosaures_or_whales) %>% 
  summarise(avge_shoe = mean(shoe_size),
            avge_he = mean(height))

########################################################################
########################################################################
########################################################################

#AI Presentation - Elena

# "AI is more importanty than fire or electricity" - google ceo

# Narrow AI - limited to a single or limited number of tasks
# Cannot answer questions

# General AI - intellkigence in a wider range of enviroments and tasks

# Weak AI - stimulated thinking (they only act like they are thinking)
# Strong AI - actual thinking (conscious mind like humans)

# Black Box with AI - see what AI is looking at (boats identitified via reflection
#                                                means would not be identified on land)

# AI if future of business, how to build AI to work with people and apply human knowledge to scale









