#
# 10일차
#

install.packages("tidyverse")
library( tidyverse )

# 이 안에 ggplot2, dplyr, tibble 등등이 다 들어있음
# tibble은 data frame을 개선한 거라고

dim( mpg )
str( mpg )
head( mpg )
View( mpg )
ggplot( data = mpg ) +
  geom_point ( mapping = aes( x = displ, y = hwy ) )

ggplot( data = mpg ) +
  geom_point( mapping = aes( x = displ, y = hwy ) )

# data = 시각화할 데이터 지정 @ggplot 함수의 인수로 전달
# geom_point는 실제 그래프를 그리는 함수, ggplot과 + 로 연결되어야 함

month <- c( 1, 2, 3, 4, 5, 6 )
rain <- c(55, 50, 45, 50, 60, 70)
df <- data.frame( month, rain )
df

ggplot( df, aes(x = month, y = rain) ) +
  geom_bar ( stat = "identity",
             width = 0.7,
             fill = "steelblue" )

ggplot( df, aes( x = month, y = rain ) ) +
  geom_bar( stat = "identity",
            width = 0.7,
            fill= "steelblue") + 
  ggtitle("월별 강수량") +
  theme(plot.title = element_text( size = 25, face = "bold",
                                 color = "steelblue")) +
  labs( x = "월", y = "강수량" ) + coord_flip()


ggplot( iris, aes( x = Petal.Length ) ) +
  geom_histogram( binwidth = 0.5 ) #꽃잎의 단위를 0.5 기준으로 카운트해라


ggplot( iris, aes( x = Sepal.Width, fill = Species,
                   color = Species) ) + 
  geom_histogram( binwidth = 0.5, position = "dodge" ) + 
  theme( legend.position = "top" )
#dodge : 품종별로 각각 그리라는 뜻


ggplot( data = mpg ) +
  geom_point( mapping = aes( x = displ, y = hwy ), color="blue" )

# ggplot2 scatter chart
ggplot( data = iris, mapping = aes( x = Petal.Length, y = Petal.Width, color = Species ) ) +
  geom_point()

ggplot( data = iris ) +
  geom_point( mapping = aes ( x = Petal.Length, y = Petal.Width ) )


ggplot( data = iris, mapping = aes( x = Petal.Length, y = Petal.Width,
                                    color = Species ) ) +
  geom_point( size = 3 ) +
  ggtitle("꽃잎의 길이와 폭") +
  theme( plot.title = element_text( size = 25, face = "bold", color = "red" ) )


ggplot( data = iris, mapping = aes( x = Petal.Length, y = Petal.Width,
                                    color = Species ) ) +
  geom_point( size = 3 ) +
  ggtitle("꽃잎의 길이와 폭") +
  theme( plot.title = element_text( size = 25, face = "bold", color = "red" ) )

#ggplot Box plot
ggplot( data = iris, mapping = aes( y = Petal.Length ) ) +
  geom_boxplot( fill = "yellow" )


ggplot(data=iris, mapping=aes(y=Petal.Length, fill=Species))+
  geom_boxplot()

#ggplot line chart ~ 시계열 데이터 시각화에 많이 쓰임
year <- 1937:1960
cnt <- as.vector( airmiles )
df <- data.frame(year, cnt)
head(df)

ggplot( df, aes( x = year, y = cnt ) ) +
  geom_line( col = "red" )

# ggplot 작성 graph 꾸미기 ( 공통 )
str( economics )

# 사선
ggplot( economics, aes( x = date, y = psavert ) ) +
  geom_line() +
  geom_abline( intercept = 12.18671, slope = -0.0005444 )

# 평행선
ggplot( economics, aes( x = date, y = psavert ) ) +
  geom_line() +
  geom_hline( yintercept = mean(economics$psavert))

# 수직선
x_inter <- filter(economics, psavert == min(economics$psavert))$date
ggplot( economics, aes( x = date, y = psavert ) ) +
  geom_line() +
  geom_vline(xintercept = x_inter)

# 텍스트 추가
ggplot( airquality, aes( x = Day, y = Temp ) ) +
  geom_point() +
  geom_text( aes( label = Temp, vjust = 0, hjust = 0 ) )

# 영역 지정 및 화살표 표시
ggplot( mtcars, aes( x = wt, y = mpg ) ) +
  geom_point() +
  annotate( "rect", xmin = 3, xmax = 4, ymin= 12, ymax = 21,
            alpha = 0.5, fill = "skyblue" ) +
#alpha : 0.1~1 (1에 가까울수록 불투명)
#화살표를 그리공
  annotate( "segment", x = 2.5, xend = 3.7,
            y = 10, yend = 17, color = "red",
            arrow = arrow() ) +
#뭐라뭐라 설명을 달아보쟝
  annotate( "text", x = 2.5, y = 10, 
            label = "point " )

#익스포트를 하면 되는 거였숴!

#참고 사이트
#https://ggplot2.tidyverse.org/index.html
#http://www.ggplot2-exts.org/gallery/

#데이터 유형에 따라서 그 데이터를 잘 설명할 수 있는 형태를 찾아서 사용하는 능력이 중요


#트리맵을 배워봅시당
#http://rpubs.com/brandonkopp/creating-a-treemap-in-r
#상자의 크기 = 데이터 크기


#treemap
install.packages("treemap")
library(treemap)

data(GNI2014)
dim(GNI2014)
str(GNI2014)
head(GNI2014)
view(GNI2014)

treemap(GNI2014, index=c("continent", "iso3"), #계층구조
  vSize = "population",                        #타일 크기
  vColor = "GNI",                              #타일 컬러
  type = "value",                              #타일 컬러링 방법
  bg.labels = "yellow",                        #레이블 배경색
  title = "World's GNI" )                      #제목

st <- data.frame(state.x77)
st <- data.frame(st, stname = rownames(st))
treemap(st, index=c("stname"),
        vSize="Area",
        vColor="Income",
        type="value",
        title="미국 주별 수입")

#fashion industry - 도메인별 판매 수량 + 판매액을 요렇게 보면 잘 보일 듯! 오홍

#산점도에 Bubble 추가 ( Bubble chart )
symbols(st$Illiteracy, st$Murder,         #원의 x, y 좌표
        circles = st$Population,          #원의 반지름
        inches = 0.3,                     #원크기 조절값
        fg = "white",                     #원의 테두리색
        bg = "lightgray",                 #원의 바탕색
        lwd = 1.5,                        #원 테두리선 두께
        xlab = "rate of Illiteracy",      
        ylab = "crime (murder) rate",
        main = "Illiteracy and Crime")
text(st$Illiteracy, st$Murder,            #텍스트 출력 x,y 좌표
     rownames( st ),                      #출력할 text
     cex = 0.6,                           #폰트 크기
     col = "brown")                       #폰트 컬러


install.packages("hrbrthemes")
install.packages("viridis")
install.packages("plotly")
install.packages("gapminder")
# Libraries
library(ggplot2)
library(dplyr)
library(plotly)
library(viridis)
library(hrbrthemes)

# The dataset is provided in the gapminder library
library(gapminder)
data <- gapminder %>% filter(year=="2007") %>% dplyr::select(-year)

# Interactive version
p <- data %>%
  mutate(gdpPercap=round(gdpPercap,0)) %>%
  mutate(pop=round(pop/1000000,2)) %>%
  mutate(lifeExp=round(lifeExp,1)) %>%
  
  # Reorder countries to having big bubbles on top
  arrange(desc(pop)) %>%
  mutate(country = factor(country, country)) %>%
  
  # prepare text for tooltip
  mutate(text = paste("Country: ", country, "\nPopulation (M): ", pop, "\nLife Expectancy: ", lifeExp, "\nGdp per capita: ", gdpPercap, sep="")) %>%
  
  # Classic ggplot
  ggplot( aes(x=gdpPercap, y=lifeExp, size = pop, color = continent, text=text)) +
  geom_point(alpha=0.7) +
  scale_size(range = c(1.4, 19), name="Population (M)") +
  scale_color_viridis(discrete=TRUE, guide=FALSE) +
  theme_ipsum() +
  theme(legend.position="none")

pp <- ggplotly(p, tooltip="text")
pp