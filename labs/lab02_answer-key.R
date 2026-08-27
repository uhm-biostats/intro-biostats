# 1. Use the data from countries.csv to practice making some graphs.

# a. read in the data
countries <- read.csv("data/countries.csv")

# b. load ggplot2

library(ggplot2)

# why is this necessary? -- ggplot(), geom_histogram(), geom_bar(), etc. are 
# all functions that live inside the ggplot2 package; they are not part of 
# base R, so the package has to be loaded with library() before we can use 
# those functions

# c. histogram of measles_immunization_oneyearolds
ggplot(countries, aes(x = measles_immunization_oneyearolds)) +
    geom_histogram()

# describe the pattern: the distribution is strongly left-skewed -- most 
# countries vaccinate a high percentage (mostly in the 90s) of one-year-olds 
# against measles, with a long tail of countries that have much lower 
# vaccination rates

# d. bar graph of the number of countries per continent
ggplot(countries, aes(x = continent)) +
    geom_bar(stat = "count")

table(countries$continent)
## Africa has the most countries (54) and South America the fewest (12)

# e. scatterplot of male vs. female life expectancy
ggplot(countries, aes(x = life_expectancy_at_birth_male, 
                      y = life_expectancy_at_birth_female)) +
    geom_point()

# these two variables have a very strong, positive, and close to linear 
# relationship (r = 0.97): countries with higher male life expectancy also 
# tend to have higher female life expectancy


# 2. Ecological footprint in 2000 vs. 2012

# a. plot the relationship, with a one-to-one line added
ggplot(countries, aes(x = ecological_footprint_2000, y = ecological_footprint_2012)) +
    geom_point() +
    geom_abline(intercept = 0, slope = 1)

# b. describe the relationship: there is a strong, positive relationship 
# (r = 0.91) between a country's ecological footprint in 2000 and its 
# footprint in 2012 -- countries with a high footprint in 2000 tended to 
# still have a high footprint in 2012

# c. does footprint tend to go up or down between 2000 and 2012?

mean(countries$ecological_footprint_2012 - countries$ecological_footprint_2000, 
    na.rm = TRUE)
## -0.417, so on average footprint went down slightly

# which countries changed the most? countries that started with a *high* 
# ecological footprint in 2000 (points that fall well below the 1:1 line) 
# tended to decrease the most, while countries with a low footprint in 2000 
# changed very little (points fall right along the 1:1 line)


# 3. Continent vs. female life expectancy

ggplot(countries, aes(x = continent, y = life_expectancy_at_birth_female)) +
    geom_boxplot()

# describe the pattern: female life expectancy differs a lot by continent. 
# Africa has by far the lowest median life expectancy (~63 years) and also 
# the widest spread, while Europe has the highest median (~82 years) and a 
# relatively narrow spread. Asia, Oceania, North America, and South America 
# fall in between, with North and South America and Europe overlapping quite 
# a bit


# 4. Bat tongue and palate length (Muchala 2006)

# a. import and inspect the data
bat_tongues <- read.csv("data/BatTongues.csv")
summary(bat_tongues)

# b. scatterplot with tongue length as the response variable
ggplot(bat_tongues, aes(x = palate_length, y = tongue_length)) +
    geom_point()

# describe the association: overall the association looks weak and positive 
# (r = 0.23) when all the data are included, but that is almost entirely 
# because of one extreme point -- without that point the relationship is 
# fairly strong and positive (r = 0.81)

# c. what can we conclude from the outlier, given the data are verified?
# Because the data point has been double-checked, this is not a measurement 
# error -- it represents a real, biologically extreme species. This tells us 
# that at least one bat species has evolved a tongue that is disproportionately 
# long relative to its palate (and thus its head/body size)

# d. use subset() to find the outlier species
subset(bat_tongues, tongue_length > 80)
## Anoura fistulata


# 5. Improve your figure!

# answers will vary -- possible improvements include: adding clear axis 
# labels with units (using xlab()/ylab()), removing the default grey 
# background (theme_minimal() or theme_bw()), using a colorblind-friendly 
# palette (scale_color_viridis_d()/scale_fill_viridis_d()) if color is used, 
# and/or adjusting binwidth on a histogram so the shape of the distribution 
# is easier to see
