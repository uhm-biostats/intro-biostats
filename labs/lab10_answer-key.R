library(ggplot2)

# 1. Numerical estimation in grade schoolers (numberline.csv)

numberline <- read.csv("data/numberline.csv")

# a. plot fourth graders' guesses against the true value
ggplot(numberline, aes(x = true_value, y = fourth_graders_guess)) +
    geom_point()

# is this relationship linear? Yes -- the fourth graders' guesses fall 
# along a fairly straight line, so no transformation is needed

fourth_regression <- lm(fourth_graders_guess ~ true_value, data = numberline)
summary(fourth_regression)

## slope = 0.859, intercept = 70.61, P < 0.0001, so:
## fourth_graders_guess = 0.859 * true_value + 70.61


# b. plot second graders' guesses against the true value
ggplot(numberline, aes(x = true_value, y = second_graders_guess)) +
    geom_point()

# is this relationship linear? No -- the second graders' guesses rise very 
# quickly for small true values and then level off, which looks like a 
# logarithmic curve rather than a straight line

# fit the untransformed (linear) model for comparison
second_regression_untransformed <- lm(second_graders_guess ~ true_value, 
                                      data = numberline)

# transform true_value with a log and re-fit
numberline$log_true_value <- log(numberline$true_value)

second_regression_log <- lm(second_graders_guess ~ log_true_value, 
                            data = numberline)
summary(second_regression_log)

## untransformed: R^2 = 0.82, P < 0.0001
## log-transformed: R^2 = 0.95, P < 0.0001 -- a much better fit

# residual plots for both models
numberline$resid_untransformed <- residuals(second_regression_untransformed)
numberline$resid_log <- residuals(second_regression_log)

ggplot(numberline, aes(x = true_value, y = resid_untransformed)) +
    geom_point() +
    geom_hline(yintercept = 0)

ggplot(numberline, aes(x = log_true_value, y = resid_log)) +
    geom_point() +
    geom_hline(yintercept = 0)

# the untransformed residual plot shows an obvious pattern: residuals are 
# very negative for small true values, become positive in the middle, and 
# dip negative again for large true values -- a clear violation of the 
# linearity assumption. After the log-transformation, the residuals scatter 
# much more randomly around zero, so the log-transformed model is a much 
# better fit to the assumptions of linear regression

# c. what does this imply about how 2nd vs. 4th graders perceive numbers?
# answer: fourth graders' guesses increase linearly with the true value, 
#         meaning they treat equal differences in magnitude (e.g., 100 vs. 
#         200, or 800 vs. 900) as equally far apart on the number line. 
#         Second graders' guesses instead fit a logarithmic relationship, 
#         meaning they treat equal *ratios* as equally far apart (they 
#         compress large numbers together relative to small numbers). This 
#         is consistent with the idea that children's mental representation 
#         of number starts out logarithmic and becomes more linear as they 
#         get older and gain more experience/schooling with numbers


# 2. Brain-body mass allometry in mammals (mammals.csv)

mammals <- read.csv("data/mammals.csv")

# a. plot transformed brain size against transformed body size
mammals$log_body_mass <- log(mammals$body_mass_kg)
mammals$log_brain_mass <- log(mammals$brain_mass_g)

ggplot(mammals, aes(x = log_body_mass, y = log_brain_mass)) +
    geom_point()

# b. fit the regression line
mammal_regression <- lm(log_brain_mass ~ log_body_mass, data = mammals)
summary(mammal_regression)

## slope = 0.755, intercept = 2.127, so:
## log(brain_mass_g) = 0.755 * log(body_mass_kg) + 2.127

# c. residual plot
mammals$resid <- residuals(mammal_regression)

ggplot(mammals, aes(x = log_body_mass, y = resid)) +
    geom_point() +
    geom_hline(yintercept = 0)

# do the data match the assumptions of linear regression? Mostly yes -- the 
# residuals are scattered fairly evenly above and below zero across the 
# range of (log) body mass, without an obvious funnel shape or curve, so the 
# assumptions of linear regression look reasonably well met, though there is 
# some scatter (a couple of species -- like humans -- fall a bit further 
# from the line than the rest)
