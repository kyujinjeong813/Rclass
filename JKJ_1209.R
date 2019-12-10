#
# 작성자 : 정규진
# 작성일 : 2019.12.9
# 제출일 : 2019.12.9
#

library(dplyr)
library(ggplot2)
#문1)
#R에서 제공하는 mtcars 데이터셋에서 gear(기어의 수)에 대해 ggplot으로
#막대그래프를 작성하시오. 단, 제목과 x축 레이블은 ‘기어의 수’, y축 레이블
#은 ‘빈도수’로 나타내시오.
str(mtcars)

ggplot( data = mtcars, aes( mtcars$gear ) ) +
  geom_bar() +
  labs( x = "기어의 수", y = "빈도수")

#문2)
#R에서 제공하는 mtcars 데이터셋에서 cyl(실린더의 수)에 대해 막대 색이
#초록색인 막대그래프를 ggplot으로 작성하시오.

ggplot( data=mtcars, aes( cyl ) ) +
  geom_bar( fill = "green" )


#문3) 
#R에서 제공하는 mtcars 데이터셋에서 mpg(연비)에 대해 구간 간격이 5.0
#인 히스토그램을 ggplot으로 작성하시오.

ggplot( data = mtcars, aes( mtcars$mpg ) ) +
  geom_histogram( binwidth = 5.0 )

#문4)
#R에서 제공하는 trees 데이터셋의 Girth(나무 둘레)에 대해 ggplot으로
#히스토그램을 작성하시오. 여기에서는 히스토그램의 제목, x축 레이블, y축
#레이블을 한글로 표시하시오. (구간 간격은 3.0, 막대의 색은 steelblue로 한다.)

ggplot( data = trees, mapping = aes( x = trees$Girth ) ) +
  geom_histogram( binwidth = 3.0, fill="steelblue" ) +
  labs( x = "나무 둘레", y = "빈도수") +
  ggtitle("나무 둘레") +
  theme( plot.title = element_text( size = 25, face="bold", color="steelblue" ))

#문5)
#R에서 제공하는 mtcars 데이터셋에서 mpg(연비)를 x축으로 하고, wt(중량)를 y축으로 하는
#산점도를 ggplot으로 작성하시오. (단, 점의 색은 gear의 수에 따라 다르게 표시한다.)

ggplot( data = mtcars, aes( x = mpg, y = wt, color= gear )) +
  geom_point( size = 3 )


#문6)
#R에서 제공하는 mtcars 데이터셋에서 mpg(연비)에 대해 ggplot으로 상자그림을 작성하되,
#cyl(실린더 수)에 따라 그룹을 나누어 작성하시오.

ggplot( data = mtcars, aes( y = mpg, group= cyl )) +
  geom_boxplot()


#문7) 
#다음은 2015년부터 2026년도까지의 예상 인구수 추계 자료이다. 연도를
#x축으로 하여 ggplot으로 선그래프를 작성하시오.

#연도		총인구 (천명)		연도		총인구 (천명)
#2015		51014				2021		52123
#2016		51245				2022		52261
#2017		51446				2023		52388
#2018		51635				2024		52504
#2019		51811				2025		52609
#2020		51973				2026		52704	

year <- c(2015:2026)
population <- c(51014, 51245, 51446, 51635, 51811, 51973,
                52123, 52261, 52388, 52504, 52609, 52704)
df <- data.frame(year, population)

ggplot( data = df, aes( x = year, y = population ) ) +
  geom_line()


#문8)
#다음과 같이 데이터셋 us를 생성한 후 물음에 답하시오. 여기서 state.x77은
#미국 50개 주의 통계정보가, state.division은 미국 50개 주의 지역 구분
#(예: 북부, 중부, 남부……) 정보가 저장된 데이터셋이다.

us <- data.frame(state.x77, state.division)
str(us)

#(1) 미국 50개 주에 대해 각각의 주들이 지역구분별로 묶인 트리맵을 작성하시오.
#또한, 타일의 면적은 Population(인구수), 타일의 색은 Income(소득)으로 나타내고,
#각각의 타일에는 주의 이름을 표시하시오. 마지막으로 이 트리맵에서 관찰할 수 있
#는 것이 무엇인지 설명하시오

library(treemap)

us2 <- data.frame(us, stnames = rownames(us))
head(us2)
treemap(us2, index=c("state.division", "stnames"),
        vSize="Population",
        vColor="Income",
        type="value")
#인구는 East North Central, Middle Atlantic 지역에 가장 많고,
#Alaska는 인구는 적으나 소득은 가장 높다


#(2) 미국 50개 주에 대해 각각의 주들이 지역구분별로 묶인 트리맵을 작성하시오.
#또한, 타일의 면적은 HS.Grad(고등학교 졸업률), 타일의 색은 Murder(범죄률)로 나타
#내고, 각각의 타일에는 주의 이름을 표시하시오. 마지막으로 이 트리맵에서 관찰할
#수 있는 것이 무엇인지 설명하시오.

treemap(us2, index=c("state.division", "stnames"),
        vSize = "HS.Grad",
        vColor = "Murder",
        type = "value",
        title = "미국 주별 고등학교 졸업률과 범죄율")
#고등학교 졸업률이 낮은 주일수록 범죄율이 높은 경향이 있다


#(3) us 데이터셋에 대해 x축은 Income(소득), y축은 Illiteracy(문맹률), 원의 크기는
#Population(인구수), 원의 색은 green(초록색), 원 내부에는 주의 이름을 표시한 버
#블차트를 작성하시오. 또한 이 버블차트에서 관찰할 수 있는 것이 무엇인지 설명하시오.

symbols(us$Income, us$Illiteracy,
        circles=us2$Population,
        inches = 0.8,
        fg = "white",
        bg = "green",
        lwd = 1.5,
        xlab = "Income",
        ylab = "Illiteracy",
        main = "Income and Illiteracy")
text(us$Income, us$Illiteracy,
     rownames(us),
     cex = 0.6,
     col = "black")

ggplot( data = us, aes( x = Income, y = Illiteracy, size = Population ) ) +
  geom_point(alpha = 0.5, shape = 21, color = "green", fill = "green" ) +
  scale_size(range = c(.1, 20)) +
  geom_text(label = rownames(us), color= "grey40", size=3 ) +
  ggtitle("문맹률과 소득") +
  theme( plot.title = element_text( size = 25, face="bold", color="grey40" ))

#문맹률이 높을수록 소득이 낮다 (문맹률과 소득은 음의 상관관계가 있다.)


#(4) us 데이터셋에 대해 x축은 Illiteracy(문맹률), y축은 Murder(범죄률), 원의 크기
#는 Area(면적), 원의 색은 green(초록색), 원 내부에는 주의 이름을 표시한 버블차트
#를 작성하시오. 또한 이 버블차트에서 관찰할 수 있는 것이 무엇인지 설명하시오.

symbols(us$Illiteracy, us$Murder,
        circles = us$Area,
        inches = 1.,
        fg = "white",
        bg = "green",
        lwd = 1.5,
        xlab = "Illiteracy",
        ylab = "Murder",
        main = "Illiteracy and Murder")
text(us$Illiteracy, us$Murder,
     rownames(us),
     cex = 0.6,
     col = "red")

ggplot( data = us, aes( x = Illiteracy, y = Murder, size = Area ) ) +
  geom_point(alpha = 0.5, shape = 21, color = "green", fill = "green" ) +
  scale_size(range = c(.1, 24)) +
  geom_text(label = rownames(us), color= "grey40", size=3 ) +
  ggtitle("문맹률과 범죄율") +
  theme( plot.title = element_text( size = 25, face = "bold", color = "grey40" ))

#문맹률과 범죄율은 양의 상관관계를 가진다
#알래스카의 면적이 넓당....
