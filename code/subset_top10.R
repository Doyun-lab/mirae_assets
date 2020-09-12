# 작업 디렉토리 설정
setwd("/Users/doyun/mirae_assets")

# library
library(tidyverse)

# 데이터 불러오기
trade <- read.csv("trade_train.csv")
trade <- trade[,-1]

# 2020년 06월 데이터만 불러오기
trade_06 <- subset(trade, trade$기준년월 == "202006")

# 그룹번호 17 ~ 32만 추출
which(trade_06$그룹번호 == "MAD17")
which(trade_06$그룹번호 == "MAD32")

trade_06 <- trade_06[1557:2876,]

# 형변환
trade_06$종목번호 <- as.character(trade_06$종목번호)

# 그룹에서 종목별 매수고객수 도출
buying <- trade_06 %>%
  group_by(그룹번호, 종목번호) %>%
  summarise(count = sum(매수고객수)) %>%
  arrange(그룹번호, desc(count)) %>%
  group_by(그룹번호) %>%
  slice(1:10)

# 그룹별 종목 리스트에 저장
result <- list()
x <- 1
y <- 10
for (i in 1:16){
  result[[i]] <- buying$종목번호[x:y]
  x <- x + 10
  y <- y + 10
}



