library(googlesheets4)
library(ggplot2)

ciQ <- read_sheet("1jscYLBjulm2IsyIMlPJAdQREjFSIFel6HcP9voS6J6U")

tt <- names(ciQ)[4] |> 
    strwrap(42) |> 
    paste(collapse = "\n")

names(ciQ)[4] <- "Response"

ggplot(ciQ, aes(x = Response)) +
    geom_bar() +
    ggtitle(tt)


