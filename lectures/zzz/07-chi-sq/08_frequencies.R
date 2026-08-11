library(googlesheets4)
library(ggplot2)
library(scales)
library(cowplot)

# M&M null hypothesis----

mm_hyp <- read_sheet("1Fk2YnBYIHDhIBdX7URmzwUNkpJNEhNCHF-I2VJuWqH0")


ggplot(data.frame(Answer = mm_hyp[, 4]), aes(y = Answer)) +
    geom_bar() + 
    scale_y_discrete(labels = label_wrap(width = 20)) + 
    ggtitle(names(mm_hyp)[4] |> 
                strwrap(width = 38) |> 
                paste(collapse = "\n"))

