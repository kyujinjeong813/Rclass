#
# 5일차
#
setwd("D:/Rclass")
df <- read.table( file = "airquality.txt", header = T) #sep = "/" 등 
df

class(df)
dim(df)
str(df)
head(df,3)
tail(df,3)

#필요한 패키지에 대한 기록을 남겨놔야 나중에 다른 환경에서 스크립트 실행할 때 문제가 없음
install.packages('rJava') 
install.packages('xlsx')

library( rJava )
library( xlsx )

df.xlsx <- read.xlsx( file = "airquality.xlsx", sheetIndex = 1, encoding = "UTF-8" )
df.xlsx
class( df.xlsx )
str( df.xlsx )
head( df.xlsx, 3 )
tail( df.xlsx, 3 )

df <- read.csv( file = "airquality.csv", header=T)
str(df)

score <- c( 76, 84, 69, 50, 95, 6, 85, 71, 88, 84 )
which( score == 69)
which( score >= 85)
max( score )
which.max( score )

idx <- which( score >= 60 )
score[ idx ] <- 61
score

idx <- which( iris[, 1:4] > 5.0, arr.ind = TRUE )
idx

#
# 단일변수(일변량) 범주형 자료 탐색

favorate <- c( 'WINTER','SUMMER','SPRING','SUMMER','SUMMER',
               'FALL', 'FALL', 'SUMMER', 'SPRING', 'SPRING' )
favorate
class(favorate)
table(favorate) #도수분포표
table(favorate) / length(favorate) #비율
ds <- table( favorate )
ds
barplot(ds, main = 'favorate season') #막대그래프 그리기

ds.new <- ds[ c( 2, 3, 1, 4 ) ] # 보기 편하게!
ds.new
barplot( ds.new, main='favorate season')

pie( ds, main = 'favorate season')
pie( ds.new, main = 'favorate season' )

favorite.color <- c( 2, 3, 2, 1, 1, 2, 2,
                     1, 3, 2, 1, 3, 2, 1, 2 )
#범주형이 숫자로 되어 있당
ds <- table(favorite.color)
ds

barplot(ds, main="favorite color")
colors <- c( 'green', 'red', 'blue' )
names(ds) <- colors
ds
barplot(ds, main="favorite color", col = colors )
pie(ds, main = "favorite color", col = colors)

colors <- c('gray', 'black', 'white')
names(ds) <- colors
ds
barplot(ds, main='favorite color', col=colors) #col : 색상 부여하는 인수
pie(ds, main = 'favorite color', col= colors)
#시각화~~~~~~~~다양한 시각화 도구를 이용하자

#
# 단일변수(일변량) 연속형 자료 탐색
#
weight <- c( 60, 62, 64, 65, 68, 69 )
weight
weight.heavy <- c( weight, 120 ) 
weight.heavy
# 평균
mean(weight)
mean(weight.heavy) #평균의 단점 - 데이터 분포에 따라 왜곡이 생기기 쉽다
#중앙값
median(weight)
median(weight.heavy)
#절사평균
mean(weight, trim=0.2) #위아래 잘라내고 평균냄 (위아래 20%씩 잘라내겠다는 뜻)
mean(weight.heavy, trim=0.2)
#사분위수
quantile( weight.heavy )
quantile( weight.heavy, (0:10)/10 )

summary( weight.heavy )

#산포 (distribution)
#분산
var( weight )
#표준편차
sd( weight )
#값의 범위 (최소값과 최대값)
range( weight )
#최대값과 최소값의 차이
diff( range( weight ) )

#Histogram
str(cars)
dist <- cars[, 2]
dist
hist( dist, main='Histogram for 제동거리', xlab= "제동거리", ylab="빈도수", border='blue', col='green',
      las=2, breaks=5)

#상자그림 (boxplot, 상자수염그림)
# 사분위수를 시각화하여 그래프 형태로 표시
# 상자그림은 하나의 그래프로 데이터의 분포 형태를 포함한 다양한 정보를 전달

boxplot (dist, main="자동차 제동거리")

boxplot.stats(dist)
boxplot.stats(dist)$stats #정상범위 사분위수
boxplot.stats(dist)$n #관측치 개수
boxplot.stats(dist)$conf #중앙값 신뢰구간
boxplot.stats(dist)$out #이상치(특이값) 목록

#일변량 중 그룹으로 구성된 자료의 상자그림
boxplot( Petal.Length~Species, data = iris, main = '품종별 꽃잎의 길이')
boxplot( iris$Petal.Length~iris$Species, main = '품종별 꽃잎의 길이')

#한 화면에 여러 그래프 작성
par( mfrow = c( 1, 3 ) ) #1 x 3 가상화면 분할
barplot( table( mtcars$carb ), main = "C", xlab = "carburetors", ylab = "freq",
         col = "blue" )
barplot( table( mtcars$cyl ), main = "cyl", xlab = "cyl", ylab = "freq",
         col = "red" )
barplot( table( mtcars$gear ), main = "gear", xlab = "gear", ylab = "freq",
         col = "green" )
par( mfrow = c ( 1, 1) ) #가상화면 분할 해제 (꼭 시켜줘야 함!)

