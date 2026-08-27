library(ggplot2)

# 1. Cuckoo egg length by host species (cuckooeggs.csv)

cuckoo <- read.csv("data/cuckooeggs.csv")

# a. multiple histogram of egg length by host species
ggplot(cuckoo, aes(x = egg_length)) +
    geom_histogram() +
    facet_wrap(~ host_species, ncol = 1)

# c. would ANOVA be a valid method here?
# answer: yes, reasonably. Each host species' eggs look roughly symmetric 
#         and unimodal (not strongly skewed), and the standard deviations 
#         are similar across groups (ranging from about 0.68 to 1.07 mm, 
#         less than a 2-fold difference), so the equal-variance assumption 
#         of ANOVA is reasonably well met. Sample sizes differ quite a bit 
#         (14 to 45 eggs per species), but with reasonably normal-looking 
#         data within each group that isn't a problem for ANOVA

# d. one-way ANOVA
cuckoo_anova <- lm(egg_length ~ host_species, data = cuckoo)
anova(cuckoo_anova)

## F(5, 114) = 10.39, P = 3.15e-08

# Conclusion: we reject the null hypothesis that mean cuckoo egg length is 
# the same in the nests of all host species -- egg length differs 
# significantly depending on which species' nest the eggs were laid in

# e. Tukey-Kramer test
TukeyHSD(aov(cuckoo_anova))

# Conclusion: cuckoo eggs found in Wren nests are significantly smaller than 
# eggs found in every other host species' nest (all P < 0.001). Hedge 
# Sparrow vs. Meadow Pipit (P = 0.043) and Meadow Pipit vs. Tree Pipit 
# (P = 0.047) are also significantly different, though only marginally so. 
# All of the remaining pairs of host species are not significantly 
# different from one another. This pattern is consistent with cuckoos 
# matching (or failing to match) egg size to what a given host species can 
# accommodate, with Wrens -- the smallest host species used here -- 
# receiving the smallest cuckoo eggs


# 2. Circadian mutants and disease survival (circadian mutant health.csv)

circadian <- read.csv("data/circadian mutant health.csv")

# a. histogram of each group
ggplot(circadian, aes(x = days_to_death)) +
    geom_histogram() +
    facet_wrap(~ genotype, ncol = 1)

# do these data match the assumptions of ANOVA?
# answer: no. All three groups are strongly skewed rather than 
#         approximately normal (Shapiro-Wilk P < 0.001 for every group), 
#         and the wild-type flies in particular pile up at the maximum 
#         number of days the flies were followed (many flies were still 
#         alive/censored at day 20). This clearly violates the normality 
#         assumption of ANOVA, so a non-parametric test is more appropriate

# b. Kruskal-Wallis test
kruskal.test(days_to_death ~ genotype, data = circadian)

## chi-squared = 41.74, df = 2, P = 8.65e-10

# Conclusion: we reject the null hypothesis that survival time after 
# infection is the same across the three genotypes. tim01 mutants die the 
# fastest (mean ~3.5 days), wild-type flies survive the longest (mean ~13.1 
# days), and the rescued tim01 flies are intermediate (mean ~9.7 days). This 
# supports the idea that the circadian timing mechanism itself affects how 
# well flies survive this bacterial infection
