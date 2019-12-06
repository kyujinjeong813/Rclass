#
# 6일차
# 
# 다중변수 자료 탐색
# 두 변수 사이의 산점도
# 산점도 (scatter plot) - 2변수로 구성된 자료의 분포를 알아보는 그래프 관측값들의 분포를 통해 2변수 사이의 관계 파악
#
#

mtcars
wt <- mtcars$wt
mpg <- mtcars$mpg
plot( wt, mpg, main = "중량-연비 그래프", xlab = "중량", ylab = "연비", col = "yellowgreen", pch = '*' )

plot( mtcars$wt, mtcars$mpg, main = "중량-연비 그래프",
      xlab = "중량", ylab = "연비", col = "black", pch = 19 )

plot( mtcars[, c("wt", "mpg")], main = "중량-연비 그래프",
      xlab = "중량", ylab = "연비", col = "yellowgreen", pch = 18 )

plot( mpg~wt, main = "중량-연비 그래프",
      xlab = "중량", ylab = "연비", col = "red", pch = 20 )

# 여러 변수들간의 산점도
vars <- c("mpg", "disp", "drat", "wt")
target <- mtcars[, vars]
head(target)
pairs( target, main="multiplots")

# 그룹정보가 있는 두 변수의 산점도
iris.2 <- iris[, 3:4]
point <- as.numeric( iris$Species )
point
color <- c("red", "green", "blue")
plot(iris.2, main="Iris Plot", pch = c(point), col = color[point] )

iris.2 <- iris[, 3:4]
point <- as.numeric(iris$Species)
color <- c("khaki", "yellowgreen", "yellow")
plot(iris.2, main='iris plot', pch=c(point), col=color[point])


# 상관분석 - 회귀선을 찾아보쟈
beers <- c( 5, 2, 9, 8, 3, 7, 3, 5, 3, 5 )
bal <- c(0.1, 0.03, 0.19, 0.12, 0.04, 0.0095, 0.07, 0.06, 0.02, 0.05 )
tbl <- data.frame( beers, bal)
tbl
plot(beers, bal, main='맥주 섭취량에 따른 혈중 알코올 농도')
plot(bal~beers, data=tbl, main='맥주 섭취량에 따른 혈중 알코올 농도')
res <- lm(bal~beers, data=tbl )
res
abline(res)
cor( tbl[,1:2] )
cor( iris[, 1:4] )

#
# 시계열 Data - 선그래프
month <- 1:12
late <- c(5,8,7,9,4,6,12,13,8,6,6,4)
plot(month, late, main='지각생통계', type="l", lty=1, lwd=1, xlab="Month", ylab="late cnt")
plot(month, late, main='지각생통계', type="b", lty=4, lwd=1, xlab="Month", ylab="late cnt")
plot(month, late, main='지각생통계', type="o", lty=1, lwd=1, xlab="Month", ylab="late cnt")
plot(month, late, main='지각생통계', type="s", lty=1, lwd=1, xlab="Month", ylab="late cnt")

# 복수의 선 그래프
late1 <- c( 5,8,7,9,4,6,12,13,8,6,6,4 )
late2 <- c( 4,6,5,8,7,8,10,11,6,5,7,3 )



plot( month, late1, main="지각생통계", type="b", lty=1, col="red",
      xlab="Month", ylab="late cnt", ylim=c(1,15))
lines(month, late2, type="b", col="blue")


# 자료 탐색 실습 - 탐색적 데이터 분석
# 0 단계 : 문제 정의
# 1 단계 : 분석 대상 데이터셋 준비 - BostonHousing 데이터셋 (mlbench pac.)
#
install.packages("mlbench")
library(mlbench)
data( "BostonHousing" )
dim(BostonHousing)
colnames(BostonHousing)
str(BostonHousing)
# crim : 1인당 범죄율, rm : 주택 1가구당 방 수, dis : 보스턴 5개 지역센터까지의 거리, tax : 재산세율, medv : 주택가격
myds <- BostonHousing[ , c("crim", "rm", "dis", "tax", "medv")]

dim(myds)
str(myds)
head(myds)
tail(myds)

# 난중에 데이터 읽어왔을 때, 이게 factor여야 하는지 아닌지 따져보고 필요 시 변환해야 함

# 2단계 : 파생변수 추가 (grp 변수 추가 (주택가격상중하))

summary(myds$medv)

grp <- c()
for (i in 1:nrow(myds)) {
  if (myds$medv[i] >= 25.0 ) {
    grp[ i ] <- 'H'
  } else if (myds$medv[i] <= 17.0) {
    grp[i] <- 'L'
  } else {
    grp[i] <- 'M'
  }
} # 이걸 한 문장으로 할 수 있는 방법이 있음, 내일 배울 예정!
grp <- factor(grp)
grp <- factor(grp, levels = c("H", "M", "L")) # 내가 원하는 레벨 순서를 정해준 거임
myds <- data.frame(myds, grp)
head(myds)

# 3단계 : 데이터셋의 형태와 기본적인 내용 파악
str(myds)
head(myds)
table(myds$grp)

# 4단계 : 히스토그램에 의한 관측값의 분포 확인
par( mfrow = c(2,3) ) # 가상화면 만드는 함수   par~~
for (i in 1:5) {
  hist( myds[ , i],
        main = colnames(myds)[i],
        col = "yellow" , xlab=colnames(myds)[i])
}
par(mfrow = c(1,1))

# 5단계 : 상자그림에 의한 관측값의 분포 확인 (분포 + 이상치 확인 가능)
par( mfrow = c(2,3) ) # 가상화면 만드는 함수   par~~
for (i in 1:5) {
  boxplot( myds[ , i],
        main = colnames(myds)[i])
}
par(mfrow = c(1,1))

# 6단계 : 그룹별 관측값 분포 확인
boxplot(myds$crim~myds$grp, main="1인당 범죄율", xlab="주택가격 상중하", ylab="범죄율")
boxplot(myds$rm~myds$grp, main="방의 개수", xlab="주택가격 상중하", ylab="방의 개수")

# 7단계 : 다중 산점도를 통한 변수 간 상관관계 확인
pairs(myds[,-6])

# 8단계 : 그룹 정보를 포함한 변수 간 상관관계 확인
point <- as.integer(myds$grp)
color <- c("red", "green", "blue")
pairs(myds[,-6], pch=point, col=color[point])

# 9단계 : 변수 간 상관계수 확인
cor( myds[, -6])


#
#
# 7일차
# 결측치 처리
#
# vector 의 결측치 처리
z <- c( 1, 2, 3, NA, 5, NA, 8 )
sum( z )
is.na( z ) #자동반복 기능이 있는 게 R 함수의 장점 (iterator)
sum( is.na(z) )
sum( z, na.rm = TRUE )
mean( z, na.rm = TRUE )

# 결측치 대체 및 제거
z1 <- z
z2 <- c( 5, 8, 1, NA, 3, NA, 7 )
z1[ is.na( z1 ) ] <- 0 # 단순대입법
z1
# 대괄호, 괄호는 동순위 (우선순위가 같음) _ 결합성 기준으로 판단 및 수행
# 대괄호는 벡터, 매트릭스, 데이터프레임의 요소에 접근할 때 사용
# 괄호는 1.연산 우선순위 지정 2.함수의 인수 입력 에 사용

#listwise deletion
z3 <- as.vector( na.omit( z2 ) ) # 결측치가 포함된 데이터를 삭제
z3

# Matrix / Data Frame 결측치 처리

x <- iris
x[ 1, 2 ] <- NA
x[ 1, 3 ] <- NA
x[ 2, 3 ] <- NA
x[ 3, 4 ] <- NA
head(x)

names(iris)

# Matrix / Data Frame 결측치 확인
# for문 이용
for ( i in 1:ncol(x) ) {
  this.na <- is.na(x [ , i] )
  cat( colnames(x)[i],
       '\t', sum(this.na),
       '\n')
}


# apply() 이용 -> iterator
col_na <- function(y) {
  return ( sum( is.na(y) ) )
}
na_count <- apply( x, 2, col_na )
na_count

na_count <- apply( x, 2, function(y) sum(is.na(y))) # 익명함수
na_count

barplot( na_count [ na_count > 0 ] )
install.packages("VIM")
require( VIM )

#결측치 자료 조합 확인용 시각화 도구
aggr( x, prop = FALSE, number = TRUE )

#두 개의 변수간의 결측치 관계 확인 시각화 도구
marginplot( x[c("Sepal.Width", "Sepal.Length")],
            pch = 20, col=c("darkgray", "red", "blue"))

#Matrix / Data Frame의 행 (data)별 결측치 확인
rowSums( is.na( x ) ) #행은 컬럼의 집합!
sum( rowSums( is.na( x ) ) > 0 )

sum( is.na(x) )

# 결측치를 제외한 새로운 데이터셋 생성
head(x)
x[ !complete.cases( x ), ] # NA가 포함되어 행출력
y <- x[ complete.cases( x ), ] # 결측치가 포함된 행을 제외시켜줌
head( y )

# 특이값, 이상치 ( outlier )
st <- data.frame( state.x77 )
summary( st$Income )
boxplot( st$Income )
boxplot.stats( st$Income)$out

# 특이값 처리 : NA로 변환 후 처리
out.val <- boxplot.stats( st$Income )$out
st$Income[ st$Income %in% out.val ] <- NA
head( st )
newdata <- st[ complete.cases( st ), ]
head( newdata )


#
# 데이터 가공
#
# 데이터 정렬
# vector 정렬
v1 <- c( 1, 7, 6, 8, 4, 2, 3)
order( v1 ) # 그 데이터가 전체 몇번째인지 나타내는 거
v1 <- sort( v1 ) # 정렬
v1
v2 <- sort( v1, decreasing = T ) #내림차순
v2

# Matrix / Data Frame 정렬
head( iris ) # 왼쪽의 1,2,3,4... -> 입력된 순서값을 의미
order( iris$Sepal.Length )
iris[ order( iris$Sepal.Length) , ] #Ascending
iris[ order( iris$Sepal.Length, decreasing = T) , ] #Descending
iris.new <- iris[ order( iris$Sepal.Length) , ]
head( iris.new )
iris[ order( iris$Species, decreasing = T,
             iris$Sepal.Length) , ] # 정렬 기준을 2개 설정



head(iris[ order(iris$Sepal.Length, decreasing = T ) , ])

# 데이터 분리
sp <- split( iris, iris$Species )
sp # 리스트 (키-밸루)로 분리됨
summary( sp )
summary( sp$setosa )
sp$setosa


# 데이터 선택
subset( iris, Species == "setosa" )
subset( iris, Sepal.Length > 7.5 )
subset( iris, Sepal.Length > 5.1 & Sepal.Width > 3.9 )
subset( iris, Sepal.Length > 7.6, select = c( Petal.Length, Petal.Width ) )

# 데이터 Sampling
# 숫자를 임의로 추출 (vector)
x <- 1:100
y <- sample( x, size = 10, replace = FALSE ) #비복원 추출
y

# 행을 임의로 추출
idx <- sample( 1:nrow( iris ), size = 50, replace = FALSE )
iris.50 <- iris[ idx, ]
dim( iris.50 )

sample( 1:20, size  = 5 ) # 샘플함수를 사용할 때마다 추출값이 매번 다른 문제가 있쥐~
set.seed( 100 ) # 그래서 set.seed가 등장~~
sample( 1:20, size  = 5 )
set.seed( 100 )
sample( 1:20, size  = 5 )


# 데이터 조합
combn( 1:5, 3 ) # 조합할 수의 범위, 조합할 수의 개수 (변수 하나가 하나의 조합이 됨)

x = c("red", "green", "blue", "black", "white" )
com <- combn( x, 2 )
com

for ( i in 1:ncol( com ) ) {
  cat ( com[ , i ], "\n" )
}

# 데이터 집계
agg <- aggregate( iris[ , -5 ],
                  by = list( iris$Species ),
                  FUN = mean )
agg

agg <- aggregate( iris[ , -5 ],
                  by = list( iris$Species ),
                  FUN = sd )
agg

agg <- aggregate( mtcars,
                  by = list( cyl = mtcars$cyl, vs = mtcars$vs ),
                  FUN = max )
agg


# 데이터 병합
x <- data.frame( name = c("a", "b", "c" ),
                math = c( 90, 80, 40 ))
y <- data.frame( name = c("a", "b", "d") ,
                 korean = c(75, 60, 90 ) )
z <- merge( x, y, by = c("name") )
z

merge( x, y )
merge( x, y, all.x = T ) # x를 기준으로
merge( x, y, all.y = T ) # y를 기준으로
merge( x, y, all = T ) # 단순 병합 (변수 + 데이터 추가)

x <- data.frame( name = c("a", "b", "c" ),
                 math = c( 90, 80, 40 ))
y <- data.frame( sname = c("a", "b", "d") ,
                 korean = c(75, 60, 90 ) )
merge( x, y, by.x = c("name"), by.y = c("sname") )

#
# dpylr package
#
install.packages("dplyr")
library(dplyr)

# %>% : pipe 연산자 (단축키; 왼쪽 ctrl + 왼쪽 shift + M)

df <- data.frame( var1 = c( 1,2,1),
                  var2 = c(2,3,2))
df

# rename() 이름변경
df <- rename ( df, v1 = var1, v2 = var2 )
df 

# 파생변수 추가 
df$sum <- df$v1 + df$v2
df


df [ 2, 1 ] <- 5
df

df <- data.frame( id = c( 1, 2, 3, 4, 5, 6 ),
                  class = c(1, 1, 1, 1, 2, 2),
                  math = c(50, 60, 45, 30, 25, 50),
                  english = c(98, 97, 86, 98, 80, 89),
                  science = c(50, 60, 78, 58, 65, 98) )
df


# filter() : 행 추출, 인수로 조건식만 주면 된다!
df %>% filter(class == 1)
df %>% filter(class == 2)
df %>% filter(class != 1)
df %>% filter(class != 2)

# 파이프 연산자 앞이 입력, 뒤가 출력, 연속적으로 파이프 연산자 사용 가능

df %>% filter( science > 70 )
df %>% filter( math < 50 )

df %>% filter( class ==1 & math >= 50 )
df %>% filter( math >= 50 | english >= 90 )
df %>% filter( class %in% c(1, 3, 5) )

df

class1 <- df %>% filter( class == 1 )
class2 <- df %>% filter( class == 2 )
class1
class2
# split()은 리스트형식으로만 나오는데, 요렇게하면 별도 데이터프레임 생성이 가능함


# select() : 변수 추출
df %>% select( math )
df %>% select( science )

df %>% select( class, math, science )
df %>% select( -math)

# dplyr 함수 조합
df %>% 
  filter( class == 1 ) %>%
  select( science )

df %>% 
  select( id, science ) %>% 
  head

df %>% 
  select( id, science ) %>% 
  sum

df %>% 
  select( id, science ) %>% 
  max

# arrange() : 정렬
df %>%arrange ( science )
df %>%arrange ( desc(science) )

# mutate() : 파생변수 추가
df %>%
  mutate( total = math + english + science ) %>% 
  head

df %>% 
  mutate( total = math + english + science, average = (math + english + science)/3 ) %>% 
  head

df %>% 
  mutate( grade = ifelse( science >= 60, 'pass', 'fail')) %>% 
  head


df %>% 
  mutate( total = math + english + science, average = (math + english + science)/3 ) %>% 
  mutate( grade = ifelse( science >= 90, 'pass', ifelse( average < 60, 'fail', 'normal'))) %>% 
  head

df.sort <- df %>% 
  mutate( total = math + english + science, average = (math + english + science)/3 ) %>% 
  arrange( desc( average ))

head(df.sort)
head(df)
# sorting 한 결과가 필요하다면 별도 변수 지정해서 넣어줘야 입력순서를 잃지 않을 수 있음

# summarise() : 집단별 요약
# group_by() : 집단별 나누기

df %>% summarise( mean_math = mean( math ) )

df %>% 
  group_by( class ) %>%
  summarise( mean_math = mean( math ),
             mean_english = mean( english ),
             mean_science = mean( science ),
             n = n() )
# n() : 빈도수를 계산해주는 함수~~



install.packages("ggplot2")
 
str( ggplot2::mpg ) ## :: scope 누가 가지고 있는 (library, require 안쓰고 쓸 수 있는 방법)
mpg <- data.frame( ggplot2::mpg )
dim( mpg )
str( mpg )
head( mpg )
View( mpg )

mpg %>% 
  group_by( manufacturer, drv ) %>% 
  summarise( mean_cty = mean( cty ) ) %>% 
  head( 10 )

mpg %>% 
  group_by( manufacturer ) %>% 
  filter( class == 'suv' ) %>% 
  mutate( tot = (cty + hwy) / 2 ) %>% 
  summarise( mean_tot = mean(tot) ) %>% 
  arrange( desc( mean_tot) ) %>% 
  head(5)

# 데이터 합치기
# left_join() : 가로로 합치기 (변수 추가)
# inner_join() : 가로로 합치기 (변수 추가)
# full_join() : 가로로 합치기 (변수 추가)
# bind_rows() : 세로로 합치기 (data 추가)


df1 <- data.frame( id = c(1, 2, 3, 4, 5),
                   midterm = c(60, 80, 70, 90, 85) )
df2 <- data.frame( id = c(1, 2, 3, 4, 5),
                   final = c(60, 80, 70, 90, 85) )
total <- left_join( df1, df2, by="id" )
total

df1 <- data.frame( id = c(1,2,3),
                   address = c("서울", "부산","제주"),
                   stringsAsFactors = F )
df2 <- data.frame( id = c(1,2,4),
                   gender = c("남","여","남") )

df_left <- left_join( df1, df2, by='id' )
df_left
df_inner <- inner_join( df1, df2, by='id' )
df_inner
df_full <- full_join( df1, df2, by='id' )
df_full

df1 <- data.frame( id = c(1,2,3,4,5),
                   test = c(60, 80, 70, 90, 85))
df2 <- data.frame( id = c(1,2,3,4,5),
                   test = c(60, 80, 70, 90, 85) )

df_all <- bind_rows(df1, df2)
df_all


install.packages("psych")
library(psych)

summary(mtcars)
describe(mtcars)

install.packages("descr")
require(descr)

df <- data.frame( id = c( 1, 2, 4 ),
                  gender = c("남", "여", "남"))
table(df$gender)
freq(df$gender)
freq(df$gender, plot=F)







