#
# 정규진
# 작성일 : 2019.11.29
# 제출일 : 2019.11.29
#

#문제1
#1.1
m <- c( 10, 40, 60, 20 )
f <- c( 21, 60, 70, 30 )
score <- cbind( m, f )
score

#1.2
colnames(score) <- c( "male", "female" )
score

#1.3
score[ 2, ]

#1.4
score[ , "female" ]

#1.5
score[ 3, 2 ]


#문제2
#2.1
st <- as.data.frame(state.x77)
#2.2
st
#2.3
colnames(st)
#2.4
rownames(st)
#2.5
dim(st)
#2.6
str(st)
#2.7
apply( st, 1, sum )
apply( st, 1, mean )
#2.8
apply( st, 2, sum )
apply( st, 2, mean )
#2.9
st[ "Florida" , ]
#2.10
st[ , "Income"]
#2.11
st[ "Texas", "Area"]
#2.12
st[ "Ohio", c( "Population", "Income") ]
#2.13
subset( st, Population >= 5000 )
#2.14
subset( st, Income >= 4500 )[ , c("Population", "Income", "Area" ) ]
#2.15 
dim(unique( subset( st, Income >= 4500 ) ) )[1]
nrow(subset( st, Income >= 4500 ))
#2.16
subset( st, ( Area >= 100000 & Frost >= 120 ) )
#2.17
subset( st, ( Population < 2000 & Murder < 12 ) )
#2.18 : 다른 방법도 생각해보자!
mean(subset( st, Illiteracy >= 2.0 )$Income)
#2.19
high <- mean(subset( st, Illiteracy >= 2.0 )$Income)
low <- mean(subset( st, Illiteracy < 2.0 )$Income)
low - high
#2.20 기대수명이 가장 높은 주는 어디인지 출력 (띄어쓰기때문에 안되는건가...?)
st[order(-Income),] #이렇게 정렬이 되어서 첫번째 꺼를 출력하면 되나..?
#주 명이 안나옴. 이름을 어떻게 꺼냐징?!
rownames(st)[1]

#2.21
rownames(subset( st, Income> st["Pennsylvania","Income"]))

#문제3
#3.1
str(mtcars)
#3.2
dim(mtcars)
#3.3 열들의 자료형 출력  mtcars.. 몰랑

#3.4
attach(mtcars)
rownames(mtcars[order(-mpg),])[1]
#3.5
mtcars_sub <- subset( mtcars, gear == 4 ) #gear가 4인 자동차들은 일단 골라냄
 #이걸 연비가 낮은 순으로 정렬
 #정렬이./... 정려ㅑㄹ이..

#3.6
head(mtcars)
