# #What is ggplot?
# gg - grammer of graphics
# Every graph consists of data within a coordinate system with data being represented 
# by geographic objects (geom) such as points, bars, etc

#Libraries ------
library(readr)
library(dplyr)
library(gapminder)

#Assign Data ------
gm <- gapminder

#Exercises------

# 1. How many rows are in the dataset?

nrow(gm)
 
#   2. How many columns are in the dataset?

ncol(gm)

#   3. What are the names of the columns?

names( gm )
gm %>% View
   
#   4. What is the oldest year in the dataset?

max(gm$year) #dataframe$column
min(gm$year)

#   5. What is the country/year with the greatest population in the dataset?

gm %>% filter(pop == max(pop)) %>% group_by(year, country) 


# 6. Get the average GDP per capita for each continent in 1952.

gm %>% 
  filter( year == 1952 ) %>% 
  group_by(continent) %>% 
  summarize(avg_gdp = mean(gdpPercap))

# 7. Get the average GDP per capita for each continent for the most recent year in the dataset.

gm %>% filter(year == max(year)) %>% group_by(continent) %>% summarize(avg_gdp = mean(gdpPercap))

#Bonus: Special Bonus question
gm %>% filter( year == max(year)) %>% summarize(avg_gdp = mean(gdpPercap))

#weighted gdp per capita
gm %>% filter( year == max(year)) %>% 
  summarize(wm = weighted.mean(gdpPercap, w = pop))

# 8. Average GDP is a bit misleading, since it does not take into account the relative size 
#(in population) of the different countries (ie, China is a lot bigger than Cambodia). 
#Look up the function weighted.mean. Use it to get the average life expectancy by 
#continent for the most recent year in the dataset, weighted by population.

life <- gm %>% filter( year == max(year)) %>% group_by(continent) %>% 
  summarize(wm = weighted.mean(lifeExp, w = pop))


# 9. Make a barplot of the above table (ie, average life expectancy by continent, weighted by population).

ggplot( data = life, aes( x = continent, y = wm)) + geom_col()

# # 10. Make a point plot in which the x-axis is country, 
# and the y-axis is GDP. Add the line theme(axis.text.x = element_text(angle = 90)) 
# in order to make the x-axis text vertically aligned. What’s the problem with this plot? 
#   How many points are there per country?

ggplot( data = gm, aes(x = country, y = gdpPercap)) + 
  geom_point() + 
  theme(axis.text.x = element_text(angle = 90))

# 11. Make a new version of the above, but filter down to just the earliest year in the dataset.

min_year <- gm %>% filter(year == min(year))

ggplot( data = min_year, aes(x = country, y = gdpPercap)) + 
  geom_point() + 
  theme(axis.text.x = element_text(angle = 90))

#12. Make a scatterplot of life expectancy and GDP per capita, just for 1972.

year_a <- gm %>% filter(year == 1972)

ggplot( data = year_a, aes(x = country, y = gdpPercap, color = lifeExp)) + geom_point()


# 13. Make the same plot as above, but for the most recent year in the data.

year_a <- gm %>% filter(year == max(year))

ggplot( data = year_a, aes(x = country, y = gdpPercap, color = lifeExp)) + geom_point()

# 14. Make the same plot as the above, but have the size of the points reflect the population.

year_a <- gm %>% filter(year == 1972)

ggplot( data = year_a, aes(x = country, y = gdpPercap, color = lifeExp, size = pop)) + geom_point()

# 15. Make the same plot as the above, but have the color of the points reflect the continent.

year_a <- gm %>% filter(year == 1972)

ggplot( data = year_a, aes(x = lifeExp, y = gdpPercap, size = pop, color = continent)) + geom_point()
 
# 16. Filter the data down to just the most recent year in the data, 
#and make a histogram (geom_histogram) showing the distribution of GDP per capita.

max_year <- gm %>% filter(year == max(year))
ggplot( data = max_year) + geom_histogram(aes(x = gdpPercap))

# 17. Get the average GDP per capita for each continent/year, weighted by the population of each country.

avg_gdp <- gm %>% group_by(continent, year) %>% 
  summarize(wm = weighted.mean(gdpPercap, w = pop))


# 18. Using the data created above, make a plot in which the x-axis is year, the y-axis is (weighted) average GDP per capita, and the color of the lines reflects the content.

avg_gdp <- gm %>% group_by(continent, year) %>% 
  summarize(wm = weighted.mean(gdpPercap, w = pop))

ggplot( data = avg_gdp, aes(x = year, y = wm, color = continent)) + geom_line()
# 19. Make the same plot as the above, but facet the plot by continent.

ggplot( data = avg_gdp, aes(x = year, y = wm, color = continent)) + geom_line() + facet_wrap(~continent)

#20. Make the same plot as the above, but remove the coloring by continent.

ggplot( data = avg_gdp, aes(x = year, y = wm)) + geom_line() + facet_wrap(~continent)

# 21. Make a plot showing France’s population over time.

france_pop <- gm %>% filter(country == "France")

ggplot( data = france_pop, aes(x = year, y = pop)) + geom_line()

# 22. Make a plot showing all European countries’ population over time, with color reflecting the name of the country.

europ_counrty <- gm %>% filter(continent == "Europe")

ggplot( data = europ_counrty, aes(x = year, y = pop, color = country)) + geom_line()

# 23. Create a variable called status. If GDP per capita is over 20,000, this should be “rich”; if between 5,000 and 20,000, this should be “middle”; if this is less than 5,000, this should be “poor”.

newgm <- gm %>% mutate(status = ifelse(gdpPercap > 20000, "rich", 
  ifelse(gdpPercap <= 20000 & gdpPercap >= 5000, "middle", "poor"))) %>% group_by(country)

# 24. Create an object with the number of rich countries per year.

count <- newgm %>% filter(status == "rich") %>% group_by(year) %>% summarize(count_rich = n())

# 25. Create an object with the percentage of countries that were rich each year.

precent_rich <- newgm %>% mutate(precent = count_rich/sum(country))

# 26. Create a plot showing the percentage of countries which were rich each year.
# 
# 27. Create an object with the number of people living in poor countries each year.
# 
# 28. Create a chart showing the number of people living in rich, medium, and poor countries per year (line chart, coloring by status).
# 
# 29. Create a chart showing the life expectancy in Somalia over time.
# 
# 30. Create a chart showing GDP per capita in Somalia over time.
# 
# 
# 
# 31. Create a histogram of life expectancy for the most recent year in the data. Facet this chart by continent.
# 
# 32. Create a barchart showing average continent-level GDP over time, weighted for population, with one bar for each year, stacked bars with the color of the bars indicating continent (geom_bar(position = 'stack')).
# 
# 33. Create the same chart as above, but with bars side-by-side (geom_bar(position = 'dodge'))
# 
# 34. Generate 3-5 more charts / tables that show interesting things about the data.
# 
# 35. Make the above charts as aesthetically pleasing as possible.

#ourworld





