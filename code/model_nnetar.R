# 작업 디렉토리 설정
setwd("/Users/doyun/mirae_assets/file")

# library
library(tidyverse)
library(forecast)

# 데이터 불러오기
trade <- read.csv("trade_train.csv")
stock <- read.csv("stocks.csv")

trade <- trade[,-1]
stock <- stock[,-1]

# 2020년 06월 데이터만 불러오기
trade_06 <- subset(trade, trade$기준년월 == "202006")

# 형변환
trade_06$종목번호 <- as.character(trade_06$종목번호)

# 그룹에서 종목별 매수고객수 도출
buying <- trade_06 %>%
  group_by(그룹번호, 종목번호) %>%
  summarise(count = sum(매수고객수)) %>%
  arrange(그룹번호, desc(count)) %>%
  group_by(그룹번호) %>%
  dplyr::slice(1:10)

# 그룹별 종목 리스트에 저장
result <- list()
x <- 1
y <- 10
for (i in 1:48){
  result[[i]] <- buying$종목번호[x:y]
  x <- x + 10
  y <- y + 10
}

# top10 종목 번호 리스트
result

## ----------------------------------------------------------------------------------------------------
# 그룹 48개에 대해 top10 종목 모델 테이블 set 생성
trade$그룹번호 <- as.character(trade$그룹번호)
number <- unique(trade$그룹번호)
number <- number[1:48]

# 기준년월 데이터프레임 생성
기준년월 <- unique(trade$기준년월)
기준년월 <- data.frame(기준년월)

## ----------------------------------------------------------------------------------------------------
# loop 1
test2 <- 기준년월
a <- 1
p <- 1
pred_set <- list()
name_col <- c()
for (n in number) { # 그룹번호 > n
  for (m in result[[a]]) { # 종목번호 > m 
    # 기준년월과 매수고객수만 남기고 기준년월에 매칭하여 join
    test <- subset(trade, trade$그룹번호 == n & trade$종목번호 == m)
    buy <- test %>% select(기준년월, 매수고객수)
    test1 <- full_join(기준년월, buy, by = "기준년월")
    test2 <- full_join(test1, test2, by = "기준년월")
    # 종목번호 저장
    name_col <- c(name_col, m)
  }
  # top1 ~ top10 으로 정렬해서 저장
  test3 <- test2[,(11:1)]
  # Column name을 종목번호로 설정
  colnames(test3) <- c(name_col, "기준년월")
  # NA 값을 0으로 대체
  test3[is.na(test3)] <- 0
  # 결과 저장
  pred_set[[p]] <- test3
  
  p <- p + 1
  a <- a + 1
  test2 <- 기준년월
  name_col <- c()
}
# 데이터 손실 방지
pred_set_copy <- pred_set

## ----------------------------------------------------------------------------------------------------
# loop 2
pred <- c()
col_name <- list()
final_set <- list()
for (i in 1:48){
  for (v in 1:10){
    for (z in pred_set[[i]][v]){
      # 그룹별 종목당 nnetar을 이용하여 2020-07 예측
      x = ts(z)
      fit <- nnetar(x)
      fcast <- forecast(fit, h = 1)
      # 예측값의 마지막 값을 pred에 저장
      y <- length(fcast$fitted)
      pred <- c(pred, fcast$fitted[y])
      # 종목번호 리스트에 저장
      col_name[[i]] <- colnames(pred_set[[i]][1:10])
    }
  }
  # 종목번호와 예측값을 데이터프레임으로 구성
  final_set[[i]] <- data.frame(col_name[[i]], pred)
  pred <- c()
}

### ----------------------------------------------------------------------------------------------------
# loop 3
# pred 기준 내림차순 정렬
final_set_arr <- list()
for(i in 1:48){
  a1 <- final_set[[i]] %>%
    arrange(desc(pred))
  final_set_arr[[i]] <- a1
}

# pred 값 top3만 추출 후 형변환 (밑에서 종목번호로 정렬 후 answer sheet 생성 위함)
final_set_arr_top3 <- list()
for(i in 1:48){
  a2 <- final_set_arr[[i]][1:3,] %>%
    arrange(col_name..i..)
  
  final_set_arr_top3[[i]] <- a2
  final_set_arr_top3[[i]]$col_name..i.. <- as.character(final_set_arr_top3[[i]]$col_name..i..)
}

# answer sheet 생성
data_f <- data.frame(1, 1, 1)
for (i in 1:48) {
  data_f <- rbind(data_f, final_set_arr_top3[[i]]$col_name..i..)
}
answer_sheet <- data_f[2:49,]

setwd("/Users/doyun/mirae_assets/code")
