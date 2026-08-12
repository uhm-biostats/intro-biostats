library(googlesheets4)
library(tidyr)
library(ggplot2) 
library(cowplot)

uhu <- read_sheet("1MkztBRbNc5fGjWO-lDNrndii2KkyLF4YUkeJ7YGzvJo") |> 
    as.data.frame()


for(i in 5:ncol(uhu)) {
    print("###")
    print(i)
    x <- gsub("[^0-9.-]", "", uhu[, i])
    x <- as.numeric(x)
    uhu[, i] <- x
}

uhu <- pivot_longer(uhu, cols = contains("measurement"))


names(uhu)[4:6] <- c("Section", "rep", "length_cm")
uhu$Section <- gsub("Section ", "", uhu$Section)

ggplot(uhu, aes(x = Section, y = length_cm, color = Section)) +
    geom_jitter(width = 0.1) +
    theme_cowplot() +
    theme(legend.position = "none") +
    scale_color_viridis_d()

write.csv(uhu[, c("Section", "length_cm")], "data/section_sample_uhu.csv", row.names = FALSE)
