library(rvest)
library(dplyr)
library(openxlsx)


url <- "https://www.mdpi.com/search?sort=pubdate&page_no=14&page_count=200&year_from=2020&year_to=2020&q=Covid&view=compact"

# get the web content
webpage <- read_html(url)

titles <- webpage %>%
  html_nodes("a.title-link") %>%
  html_text(trim = TRUE)

times <- webpage %>%
  html_nodes("div.color-grey-dark") %>%
  html_text(trim = TRUE)

# 创建一个数据框存储爬取的内容
data <- data.frame(
  title = titles,
  time = times,
  stringsAsFactors = FALSE
)

# 查看数据
print(data)

write.xlsx(data, "mdpi_1.xlsx")


mdpi_9 <- read.xlsx("C:/Users/LIMI/Desktop/Web scraper/mdpi_9.xlsx")
mdpi_9 <- mdpi_9[, -c(1, 2)]
mdpi_9$time <- substr(mdpi_9$time, nchar(mdpi_9$time) - 10, nchar(mdpi_9$time))

mdpi_10 <- read.xlsx("C:/Users/LIMI/Desktop/Web scraper/mdpi_10.xlsx")
mdpi_10 <- mdpi_10[, -c(1, 2)]
mdpi_10$time <- substr(mdpi_10$time, nchar(mdpi_10$time) - 10, nchar(mdpi_10$time))

mdpi_11 <- read.xlsx("C:/Users/LIMI/Desktop/Web scraper/mdpi_11.xlsx")
mdpi_11 <- mdpi_11[, -c(1, 2)]
mdpi_11$time <- substr(mdpi_11$time, nchar(mdpi_11$time) - 10, nchar(mdpi_11$time))

mdpi_12 <- read.xlsx("C:/Users/LIMI/Desktop/Web scraper/mdpi_12.xlsx")
mdpi_12 <- mdpi_12[, -c(1, 2)]
mdpi_12$time <- substr(mdpi_12$time, nchar(mdpi_12$time) - 10, nchar(mdpi_12$time))

mdpi_13 <- read.xlsx("C:/Users/LIMI/Desktop/Web scraper/mdpi_13.xlsx")
mdpi_13 <- mdpi_13[, -c(1, 2)]
mdpi_13$time <- substr(mdpi_13$time, nchar(mdpi_13$time) - 10, nchar(mdpi_13$time))

mdpi_14 <- read.xlsx("C:/Users/LIMI/Desktop/Web scraper/mdpi_14.xlsx")
mdpi_14 <- mdpi_14[, -c(1, 2)]
mdpi_14$time <- substr(mdpi_14$time, nchar(mdpi_14$time) - 10, nchar(mdpi_14$time))

mdpi_15 <- read.xlsx("C:/Users/LIMI/Desktop/Web scraper/mdpi_15.xlsx")
mdpi_15 <- mdpi_15[, -c(1, 2)]
mdpi_15$time <- substr(mdpi_15$time, nchar(mdpi_15$time) - 10, nchar(mdpi_15$time))

mdpi_16 <- read.xlsx("C:/Users/LIMI/Desktop/Web scraper/mdpi_16.xlsx")
mdpi_16 <- mdpi_16[, -c(1, 2)]
mdpi_16$time <- substr(mdpi_16$time, nchar(mdpi_16$time) - 10, nchar(mdpi_16$time))

mdpi_17 <- read.xlsx("C:/Users/LIMI/Desktop/Web scraper/mdpi_17.xlsx")
mdpi_17 <- mdpi_17[, -c(1, 2)]
mdpi_17$time <- substr(mdpi_17$time, nchar(mdpi_17$time) - 10, nchar(mdpi_17$time))

# Combine all the data
combined_data2 <- rbind(mdpi_1, mdpi_2, mdpi_3, mdpi_4, mdpi_5, mdpi_6, mdpi_7, mdpi_8, mdpi_9,mdpi_10, mdpi_11, mdpi_12, mdpi_13, mdpi_14, mdpi_15, mdpi_16, mdpi_17)

# Transform the time format
combined_data2$time <- dmy(combined_data2$time)

# making a decreasing sequence
combined_data2_sorted <- combined_data2[order(combined_data2$time, decreasing = TRUE), ]

# check the whole data
print(combined_data2_sorted)