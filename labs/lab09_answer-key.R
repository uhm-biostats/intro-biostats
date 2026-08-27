library(ggplot2)

# 1. Telomere length and aging (telomere-inheritance.csv)

telomeres <- read.csv("data/telomere-inheritance.csv")

# a. scatterplot of father vs. offspring telomere length
ggplot(telomeres, aes(x = father_telomere_length, y = offspring_telomere_length)) +
    geom_point()

# b. do the data need a transformation before correlation?
# answer: no -- both variables look reasonably normally distributed 
#         (Shapiro-Wilk gives P = 0.17 for fathers and P = 0.24 for 
#         offspring, so we fail to reject normality for either), and the 
#         scatterplot looks like a roughly elliptical cloud of points, so no 
#         transformation is needed

# c. product-moment correlation
cor.test(telomeres$father_telomere_length, telomeres$offspring_telomere_length)

## r = 0.579, t = 4.44, df = 39, P = 7.29e-05

# H0: the population correlation coefficient between father and offspring 
#     telomere length is 0 (i.e. no association)

# Since P < 0.05, we reject the null hypothesis: father and offspring 
# telomere length are significantly, positively correlated, consistent with 
# telomere length being at least partly heritable


# 2. Brain-body mass allometry in mammals (mammals.csv)

mammals <- read.csv("data/mammals.csv")

# a. plot brain size against body size
ggplot(mammals, aes(x = body_mass_kg, y = brain_mass_g)) +
    geom_point()

# is the relationship linear? No -- a few very large-bodied species (like 
# elephants) are so much bigger than the rest that nearly all the other 
# points are squished together near the origin, making the relationship 
# look strongly curved rather than a straight line

# b. transform the variables to make the relationship linear
mammals$log_body_mass <- log(mammals$body_mass_kg)
mammals$log_brain_mass <- log(mammals$brain_mass_g)

ggplot(mammals, aes(x = log_body_mass, y = log_brain_mass)) +
    geom_point()

# log-transforming both body mass and brain mass makes the relationship 
# look linear

# c. is there statistical evidence that brain size is correlated with body size?
cor.test(mammals$log_body_mass, mammals$log_brain_mass)

## r = 0.959, t = 26.22, df = 60, P < 2.2e-16

# Yes -- there is very strong statistical evidence of a positive correlation 
# between (log) brain size and (log) body size across these 62 species
