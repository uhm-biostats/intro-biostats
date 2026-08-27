library(ggplot2)

# 1. Build intuition for histograms and QQ plots using rnorm()

# a. generate 10 random numbers from a normal distribution (mean = 15, sd = 3)
normal_data <- data.frame(Y = rnorm(n = 10, mean = 15, sd = 3))

# b. histogram (binwidth adjusted since n is small)
ggplot(normal_data, aes(x = Y)) +
    geom_histogram(binwidth = 1)

# c. QQ plot
ggplot(normal_data, aes(sample = Y)) +
    geom_qq() +
    geom_qq_line()

# d. repeat a-c a dozen+ times
# answer: even though every one of these samples truly comes from a normal 
#         distribution, with only 10 points the histograms often look lumpy, 
#         asymmetric, or have gaps, and the QQ plots often wander noticeably 
#         off the straight line (especially at the ends) just due to random 
#         sampling error. This is useful to see because it shows that with 
#         small samples, a histogram/QQ plot that looks "not quite normal" 
#         doesn't necessarily mean the underlying population isn't normal


# 2. Repeat with n = 250

normal_data_250 <- data.frame(Y = rnorm(n = 250, mean = 15, sd = 3))

ggplot(normal_data_250, aes(x = Y)) +
    geom_histogram(binwidth = 1)

ggplot(normal_data_250, aes(sample = Y)) +
    geom_qq() +
    geom_qq_line()

# do the larger samples look more like the normal expectation? 
# answer: yes -- with 250 points the histograms look much more smoothly 
#         bell-shaped and the QQ plots hug the line much more closely, 
#         including at the ends. This is because larger samples have less 
#         sampling error, so a large random sample does a better job of 
#         reflecting the shape of the population it was drawn from


# 3. Mammal body mass (mammals.csv)

mammals <- read.csv("data/mammals.csv")

# a. distribution of body mass
ggplot(mammals, aes(x = body_mass_kg)) +
    geom_histogram()

# describe the shape: strongly right-skewed -- most species have a small 
# body mass, with a long tail of a few very large-bodied species (e.g. 
# elephants). This does not look like a normal distribution

# b. QQ plot of body mass
ggplot(mammals, aes(sample = body_mass_kg)) +
    geom_qq() +
    geom_qq_line()

# does the data fall along the line? No -- the points curve sharply away 
# from the line, especially at the upper end, confirming that body mass is 
# not normally distributed

# b. (continued) log-transform body mass and repeat
mammals$log_body_mass <- log(mammals$body_mass_kg)

ggplot(mammals, aes(x = log_body_mass)) +
    geom_histogram()

ggplot(mammals, aes(sample = log_body_mass)) +
    geom_qq() +
    geom_qq_line()

# does the log-transformation help? Yes -- after log-transforming, the 
# histogram is much more symmetric and bell-shaped, and the QQ plot points 
# fall very close to the line all the way through, so the log-transformation 
# brings the data much closer to normal

# c. mean of log body mass and its 95% CI
mean(mammals$log_body_mass)
## 1.342611

t.test(mammals$log_body_mass)$conf.int
## 95% CI: 0.5529113, 2.1323097
