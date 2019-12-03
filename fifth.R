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
