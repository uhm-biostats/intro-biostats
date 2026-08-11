library(googlesheets4)
library(ggplot2)
library(scales)
library(cowplot)

# 1 in 3 orange M&M ----

one_in_three <- read_sheet("1YwHc9HVHrwZwP_wnVGrjF0A6TPa7kGlt2iYUM4KdQMc", 
                           col_types = "Tcnc")




ggplot(data.frame(Answer = one_in_three[, 4, drop = TRUE]), aes(x = Answer)) +
    geom_bar() +
    ggtitle(names(one_in_three)[4] |> 
                strwrap(width = 46) |> 
                paste(collapse = "\n"))
        

# pulelehua feeding trial hypotheses ----

feeding_hyp <- read_sheet("1Y9ySIriJd6ZLuVj9j5ROOXySpk5yp5dGSiGDCj3evVk")


h0 <- ggplot(data.frame(Answer = feeding_hyp[, 4, drop = TRUE]), aes(y = Answer)) +
    geom_bar() + 
    scale_y_discrete(labels = label_wrap(width = 20)) + 
    ggtitle(names(feeding_hyp)[4] |> 
                strwrap(width = 38) |> 
                paste(collapse = "\n"))

hA <- ggplot(data.frame(Answer = feeding_hyp[, 5, drop = TRUE]), aes(y = Answer)) +
    geom_bar() + 
    scale_y_discrete(labels = label_wrap(width = 20)) + 
    ggtitle(names(feeding_hyp)[5] |> 
                strwrap(width = 38) |> 
                paste(collapse = "\n"))


plot_grid(h0, hA)
