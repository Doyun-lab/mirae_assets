# 작업 디렉토리 설정
setwd("/Users/doyun/Downloads")

# library
library(tidyverse)

# 데이터 불러오기
trade <- read.csv("trade_train.csv")
stock <- read.csv("stocks.csv")

trade <- trade[,-1]
stock <- stock[,-1]

# 데이터 칼럼 생성
stock$기준년월 <- substr(stock$기준일자, 1, 6)

# ------------------------------------------------------------------------------------------------------

# 상관성 확인 (A005930)
tr_A <- subset(trade, trade$종목번호 == "A005930")
st_A <- subset(stock, stock$종목번호 == "A005930")

cor1 <- st_A %>%
  group_by(기준년월) %>%
  summarise(avg = mean(거래량))
cor1 <- cor1[1:12,]

cor1_1 <- st_A %>%
  group_by(기준년월) %>%
  summarise(avg = mean(종목종가))
cor1_1 <- cor1_1[1:12,]

cor2 <- tr_A %>%
  group_by(기준년월) %>%
  summarise(avg = mean(매수고객수))

cor(cor1$avg, cor2$avg) # 0.9578
cor(cor1_1$avg, cor2$avg) # 0.2049

# ------------------------------------------------------------------------------------------------------

# 상관성 확인 (A096770)
tr_A <- subset(trade, trade$종목번호 == "A096770")
st_A <- subset(stock, stock$종목번호 == "A096770")

cor1 <- st_A %>%
  group_by(기준년월) %>%
  summarise(avg = mean(거래량))
cor1 <- cor1[1:12,]

cor1_1 <- st_A %>%
  group_by(기준년월) %>%
  summarise(avg = mean(종목종가))
cor1_1 <- cor1_1[1:12,]

cor2 <- tr_A %>%
  group_by(기준년월) %>%
  summarise(avg = mean(매수고객수))

cor(cor1$avg, cor2$avg) # 0.6341
cor(cor1_1$avg, cor2$avg) # -0.5699

# ------------------------------------------------------------------------------------------------------

# 상관성 확인 (A005380)
tr_A <- subset(trade, trade$종목번호 == "A005380")
st_A <- subset(stock, stock$종목번호 == "A005380")

cor1 <- st_A %>%
  group_by(기준년월) %>%
  summarise(avg = mean(거래량))
cor1 <- cor1[1:12,]

cor1_1 <- st_A %>%
  group_by(기준년월) %>%
  summarise(avg = mean(종목종가))
cor1_1 <- cor1_1[1:12,]

cor2 <- tr_A %>%
  group_by(기준년월) %>%
  summarise(avg = mean(매수고객수))

cor(cor1$avg, cor2$avg) # 0.8575
cor(cor1_1$avg, cor2$avg) # -0.8862

# 저장
setwd("/Users/doyun/mirae_assets")







