library(tm)
library(googlesheets4)
library(grid)
library(cowplot)


wcloud <- function(d, i) {
    lab <- names(d)[i]
    w <- d[, i]
    
    w <- w[!is.na(w)]
    w <- w[w != ""]
    w <- Corpus(VectorSource(w))
    
    w <- tm_map(w, removePunctuation)
    w <- tm_map(w, function(x) removeWords(x, stopwords()))
    
    tdm <- TermDocumentMatrix(w)
    m <- as.matrix(tdm)
    v <- sort(rowSums(m), decreasing = TRUE)
    d <- data.frame(word = names(v), freq=v)
    
    
    ggplot(d, aes(label = word, size = freq, color = freq)) +
        geom_text_wordcloud() +
        theme_minimal() +
        scale_color_viridis_c() +
        ggtitle(paste(strwrap(lab, width = 36), collapse = "\n")) +
        theme(plot.title = element_text(size = 8))
}

# pop v sample
ps <- read_sheet("1ryMv1mAzHX46_Y7IeOiGAwfRwe1Q-LA5v6ynIut2BeU")

pop <- wcloud(ps, 4)
smp <- wcloud(ps, 5)

plot_grid(pop, smp)

# param v estimate
pe <- read_sheet("1Bo9iIASKWctDR3ymf3SDO_WFYIe_xi0OxNF6VJM3kI4")

pe[, 4] <- gsub("parameter|estimate|uhu", "", pe[, 4], ignore.case = TRUE)
pe[, 5] <- gsub("parameter|estimate|uhu", "", pe[, 5], ignore.case = TRUE)

parm <- wcloud(pe, 4)
est <- wcloud(pe, 5)

plot_grid(parm, est)
