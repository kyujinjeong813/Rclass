#
# 작성자 : 정규진
# 작성일 : 2019.12.3
# 제출일 : 2019.12.3
#


#문1)
#다음은 직장인 10명의 수입과 교육받은 기간을 조사한 자료이다. 산점도와 상관계수를 구하고, 
#수입과 교육기간 사이에 어떤 상관관계가 있는지 설명하시오.

#수입 	 121 99 41 35 40 29 35 24 50 60
#교육기간 19  20 16 16 18 12 14 12 16 17

income <- c(121, 99, 41, 35, 40, 29, 35, 24, 50, 60)
period <- c(19, 20, 16, 16, 18, 12, 14, 12, 16, 17)

tbl <- data.frame(income, period)
plot(income~period, data=tbl)
res <- lm(income~period, data=tbl)
abline(res)

cor(income, period)
#교육기간과 수입은 비교적 강한 양의 상관관계가 있다.(교육 기간이 긴 사람일수록 수입이 높은 경향이 크다)


#문2)
#다음은 대학생 10명의 성적과 주당 TV 시청시간을 조사한 자료이다. 산점도와 상관계수를 구하고, 
#성적과 TV 시청시간 사이에 어떤 상관관계가 있는지 설명하시오.

#성적 	 77.5 60 50 95 55 85 72.5 80 92.5 87.5
#시청시간 14   10 20  7 25  9 15   13  4   21

score <- c(77.5, 60, 50, 95, 55, 85, 72.5, 80, 92.5, 87.5)
tv <- c(14, 10, 20,  7, 25,  9, 15, 13,  4, 21)

tbl <- data.frame(score, tv)
plot(score~tv, data=tbl,main="TV시청시간과 성적", xlab="TV시청시간", ylab="성적", pch=19, col="red" )
res <- lm(score~tv, data=tbl)
abline(res)

cor(score, tv)

#음의 상관관계가 있다 (TV 시청시간이 길수록 성적이 낮은 경향이 있다)


#문3) 
#R에서 제공하는 mtcars 데이터셋에서 mpg와 다른 변수들 간의 상관계수를
#구하시오. 어느 변수가 mpg와 가장 상관성이 높은지 산점도와 함께 설명하시오.			

colnames(mtcars)
str(mtcars)
var <- c("mpg","cyl", "disp", "hp", "drat", "wt", "qsec")
target <- mtcars[,var]
target
pairs(target)
cor(target[,1:7])
# 무게와 가장 상관성이 높다. (음의 상관관계)

cor(mtcars)
cor(mtcars)[1,]

#다른 방법
cor.result <- c()

for (i in 1:length(var)) {
  cor.result[i] <- cor(target[,c(1,i)])[1,2]
}
cor.result
names(cor.result) <- var

for (i in 2:length(var)) {
  cat("mpg와 ", var[i], "와의 상관계수는 ", cor.result[i], "입니다.\n")
}


#문4)
#다음은 2015년부터 2026년도까지의 예상 인구수 추계자료이다. 연도를 x 축으로 하여 선그래프를 작성하시오.

#연도		총인구 (천명)		연도		총인구 (천명)
#2015		51014				2021		52123
#2016		51245				2022		52261
#2017		51446				2023		52388
#2018		51635				2024		52504
#2019		51811				2025		52609
#2020		51973				2026		52704

year <- c(2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025, 2026)
population <- c(51014, 51245,51446, 51635, 51811, 51973, 52123, 52261, 52388, 52504, 52609, 52704)

plot(year, population, main="연도별 인구수(예상)", type='l', lty=1, lwd=1, xlab='연도', ylab='인구수(천명)')


#문5)
#R에서 제공하는 trees 데이터셋에 대해 다음 문제를 해결하기 위한 R 코드를 작성하시오.

#(1) 나무의 지름(Girth)과 높이(Height)에 대해 산점도와 상관계수를 보이시오.
class(trees)
str(trees)
head(trees)

plot(trees$Girth, trees$Height, pch=25, col='blue')
attach(trees)
plot(Girth, Height, pch=19, col='yellow')
plot(trees[,1:2], pch=1, col='red')
cor(trees$Girth, trees$Height)
cor(trees[,1:2])

tbl <- data.frame(trees$Girth, trees$Height)
tbl
plot(trees$Girth, trees$Height)
plot(tbl[,2]~tbl[,1], col='red')
res <- lm(trees.Height~trees.Girth, data=tbl) #이걸 너무 안써봤군!!
res
abline(res)

cor(trees$Girth, trees$Height)

#(2) trees 데이터셋에 존재하는 3개 변수 간의 산점도와 상관계수를 보이시오.

plot(trees)
cor(trees)
pairs(trees, main="Tree")
# 나무의 지름과 부피는 강한 양의 상관관계를 갖는다


#추가 문제 : 나무 높이를 상/중/하 그룹으로 나누고 그룹 상관 분석

hist(trees$Girth)
hist(trees$Height)
summary(trees$Height)

h.group <- c()

for ( i in 1:nrow(trees) ) {
  if (trees$Height[i] >= 80) {
    h.group[i] <- "H"
  } else if (trees$Height[i] <= 72) {
    h.group[i] <- "L"
  } else h.group[i] <- "M"
}

tbl <- data.frame(trees, h.group)
point <- as.numeric(tbl$h.group)
color <- c("yellow", "khaki", "darkgreen")
pairs(tbl, pch=point, col=color[point])

