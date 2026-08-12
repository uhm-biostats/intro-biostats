library(googlesheets4)

m <- read_sheet("1Rd1jDav4ZDJ5iA40dF1Jd2NQx5x9FAgD0tGnMGAfABA") |> 
    as.data.frame()


for(i in 4:ncol(m)) {
    print("###")
    print(i)
    x <- gsub("[^0-9.-]", "", m[, i])
    x <- as.numeric(x)
    m[, i] <- x
}


m$`What is n?`
m$`What is sum of Y_i?`
m$`What is Y bar?`

# calculate mean
y <- c(10.8, 9.2, 12.0, 11.4, 12.1, 10.6, 10.6, 11.6)
n <- length(y)
n

ysum <- sum(y)
ysum

ybar <- ysum / n
ybar

