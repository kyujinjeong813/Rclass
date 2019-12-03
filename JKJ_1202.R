#
# 작성일 : 2019.12.2
# 제출일 : 2019.12.2
#

#문제1
#어떤 학급의 성별이 다음과 같을 때 주어진 문제를 해결하기 위한 R 코드를 작성하시오.
# F F F M M F F F M M

#1. 위의 자료를 gender 벡터에 저장하시오.
gender <- c("F", "F", "F", "M", "M","F", "F","F", "M","M")
#2. gender에 있는 값들에 대해 도수분포표를 작성하여 출력하시오.
ds <- table(gender)
ds
#3. gender에 있는 값들에 대해 막대그래프를 작성하여 출력하시오.
barplot(ds, main="성별")
#4. gender에 있는 값들에 대해 원그래프를 작성하여 출력하시오.
pie(ds, main="성별")

#문제2
#좋아하는 계절에 대한 조사 결과가 다음과 같을 때 주어진 문제를 해결하기 위한 R 코드를 작성하시오.
#여름 겨울 봄 가을 여름 가을 겨울 여름 여름 가을

#1. 위의 자료를 season 벡터에 저장하시오.
season <- c("여름", "겨울", "봄", "가을", "여름", "가을", "겨울", "여름", "여름", "가을")
#2. season에 있는 값들에 대해 도수분포표를 작성하여 출력하시오.
dfs <- table(season)
dfs
#3. season에 있는 값들에 대해 막대그래프를 작성하여 출력하시오.
dfs <- dfs[c(3,4,1,2)]
dfs
barplot(dfs, main="좋아하는 계절")
#4. season에 있는 값들에 대해 원그래프를 작성하여 출력하시오.
pie(dfs, main="좋아하는 계절")

#문제3
#학생 A의 과목별 성적이 다음과 같을 때 각 문제를 해결하기 위한 R 코드를 작성하시오.
#KOR ENG ATH HIST SOC MUSIC BIO EARTH PHY ART
#90 	85 	73 	80 	 85  65    78  50    68  96

#1. 위 데이터를 score 벡터에 저장하시오(과목명은 데이터 이름으로 저장).
score <- c(90, 85, 73, 80, 85, 65, 78, 50, 68, 96)
names(score) <- c("KOR", "ENG", "ATH", "HIST", "SOC", "MUSIC", "BIO", "EARTH", "PHY", "ART")
#2. score 벡터의 내용을 출력하시오.
score
#3. 전체 성적의 평균과 중앙값을 각각 구하시오.
mean(score)
median(score)
#4. 전체 성적의 표준편차를 출력하시오.
sd(score)
#5. 가장 성적이 높은 과목의 이름을 출력하시오.
names(score[score == max(score)])   #이거 말고 더 간단한 게 있을 것 같당
#6. 성적에 대한 상자그림을 작성하고, 이상치에 해당하는 과목이 있으면 출력하시오.
boxplot(score, main="과목별 성적분포")
boxplot.stats(score)$out
#7. 다음 조건을 만족하는 위 성적에 대한 히스토그램을 작성하시오.
#(그래프 제목: 학생 성적, 막대의 색: 보라색)
hist(score, main = "학생 성적", col='purple')


#문제3. R에서 제공하는 mtcars 데이터셋에 대해 다음 문제를 해결하기 위한 R코드를 작성하시오.
#1. 중량(wt)의 평균값, 중앙값, 절사평균값(절사범위: 15%), 표준편차를 각각 구하시오.
mean(mtcars$wt)
median(mtcars$wt)
mean(mtcars$wt, trim=0.15)
sd(mtcars$wt)
#2. 중량(wt)에 대해 summary( ) 함수의 적용 결과를 출력하시오.
summary(mtcars$wt)
#3. 실린더수(cyl)에 대해 도수분포표를 출력하시오.
tb.mtcars.cyl <- table(mtcars$cyl)
tb.mtcars.cyl
#4. 앞에서 구한 도수분포표를 막대그래프로 출력하시오.
barplot(tb.mtcars.cyl, main="실린더 수")
#5. 중량(wt)의 히스토그램을 출력하시오.
hist(mtcars$wt, main="차종별 중량")
#6. 중량(wt)에 대해 상자그림을 출력하시오.(단, 상자그림으로부터 관찰할 수 있는정보를 함께 출력하시오.)
boxplot(mtcars$wt, main="차종별 중량")
boxplot.stats(mtcars$wt)
#7. 배기량(disp)에 대한 상자그림을 출력하시오.(단, 상자그림으로부터 관찰할 수 있는 정보를 함께 출력하시오.)
boxplot(mtcars$disp, main="차종별 배기량")
boxplot.stats(mtcars$disp)
#8. 기어수(gear)를 그룹 정보로 하여 연비(mpg) 자료에 대해 상자그림을 작성작성하고,
#각 그룹의 상자그림을 비교하여 관찰할 수 있는 것이 무엇인지 나타내시오.
boxplot(mtcars$mpg~mtcars$gear, mtcars, main="기어수 그룹 별 연비", xlab="기어수", ylab="연비")
#기어가 4일때 연비가 제일 죠음 / 기어가 3이면 전반적으로 연비가 나쁨 / 기어가 5일때때는 편차가 큼
