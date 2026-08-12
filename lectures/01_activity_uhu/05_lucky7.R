library(tm)
library(googlesheets4)
library(grid)
library(cowplot)
library(ggwordcloud)


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

# lucky number 7 word cloud
l7 <- read_sheet("1Sgc4qrqrVGrjhVeHIRPZeKtXXXj_nh3pYIMp14S1SOs")

wcloud(l7, 4)


mean(grepl("dice|die|side|6|sum", l7[[4]]))


