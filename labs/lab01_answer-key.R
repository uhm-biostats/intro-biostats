# 1. When you ran all the Learning the Tools commands in R, did you get the
# same answers as shown in the text?

# answer: yes, running the code exactly as written reproduces the same
#         output shown in the text


# 2. Come up with an appropriate R variable name for each of the following:

# Body temperature in Celsius                               -> temp_C
# How much aspirin is given per dose for a patient          -> aspirin_dose_mg
# Number of televisions per person                          -> tvs_per_person
# Height (including neck and extended legs) of giraffes     -> giraffe_height_m


# 3. Use R to calculate:

# a. 15 x 17
15 * 17
## 255

# b. 13^3
13^3
## 2197

# c. log_e(14) (natural log)
log(14)
## 2.639057

# d. log_10(100) (base 10 log)
log(100, base = 10)
## 2

# e. sqrt(81)
sqrt(81)
## 9


# 4. Weddell seal metabolic costs of feeding vs. non-feeding dives

# a. make a vector for each list of oxygen consumption values
feeding_dive <- c(71.0, 77.3, 82.6, 96.1, 106.6, 112.8, 121.2, 126.4, 127.5, 143.1)
nonfeeding_dive <- c(42.2, 51.7, 59.8, 66.5, 81.9, 82.0, 81.3, 81.3, 96.0, 104.1)

# b. confirm both vectors have the same number of individuals
length(feeding_dive)
length(nonfeeding_dive)
## both vectors have 10 elements

# c. difference in oxygen consumption between feeding and nonfeeding dives
metabolism_difference <- feeding_dive - nonfeeding_dive
metabolism_difference

# d. average difference between feeding and nonfeeding dives
mean(metabolism_difference)
## 31.78

# e. calculate the mean using sum() and length()
sum(metabolism_difference) / length(metabolism_difference)
## 31.78 -- yes, this is the same answer as mean()

# e. (continued) ratio of feeding to nonfeeding oxygen consumption
metabolism_ratio <- feeding_dive / nonfeeding_dive
metabolism_ratio

# f. log of the ratio, and its mean
metabolism_log_ratio <- log(metabolism_ratio)
metabolism_log_ratio

mean(metabolism_log_ratio)
## 0.3638730


# 5. countries.csv

# a. read in the data
countries <- read.csv("data/countries.csv")

# b. get a quick description of the data set
summary(countries)

## the first three variables are: country, total_population_in_thousands_2015,
## and gross_national_income_per_capita_2013

# c. how many countries are from Africa?
table(countries$continent)
## Africa has 54 countries

# d. what kind of variables are these (categorical or numerical)?

# continent                                          -> categorical
# cell_phone_subscriptions_per_100_people_2012       -> numerical
# total_population_in_thousands_2015                 -> numerical
# fines_for_tobacco_advertising_2014                 -> categorical (Yes/No)

# e. add a column with the difference in ecological footprint (2012 - 2000)
countries$ecological_footprint_change <- countries$ecological_footprint_2012 -
    countries$ecological_footprint_2000

mean(countries$ecological_footprint_change, na.rm = TRUE)
## -0.4169565


# 6. Using the countries data again, subset to just African countries and
# find the total 2015 population

africa_data <- subset(countries, continent == "Africa")

sum(africa_data$total_population_in_thousands_2015)
## 1184501
