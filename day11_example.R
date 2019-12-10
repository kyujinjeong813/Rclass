#
# 11일차
#

# mosaic plot
# 다중변수 범주형 데이터에 대한 각 변수의 그룹별 비율을 면적으로 표시

str(mtcars)
head(mtcars)
mosaicplot( ~gear + vs, #대상 변수
           data = mtcars, #데이터셋
           color = TRUE, #y축 변수의 그룹별 음영다르게
           main = "Grear and Vs") #제목

mosaicplot( ~gear + vs, data = mtcars,
            color = c("black", "yellow"),
            main = "Gear and Vs")

tbl <- table( mtcars$gear, mtcars$vs )
tbl
mosaicplot( tbl, color = T, main = "Gear and Vs" )

#차원축소 > 데이터 손실이 생길 수 있다
install.packages( "Rtsne" )
library(Rtsne)

ds <- iris[ , -5]
ds

#차원 축소
#중복 데이터 제거
dup = which( duplicated( ds ) )
dup

ds <- ds[-dup,]
ds.y <- iris$Species[ -dup ]

#차원 축소 수행 - t-SNE 실행

tsne <- Rtsne( ds,                #차원 축소 대상 데이터셋
               dim = 2,           #축소할 차원 2 / 3 차원
               perplexity = 10 )  #차원 축소 과정에서 데이터 샘플링을 수행하는데 이 샘플 개수
                                  #(대상데이터수) / 3 보다 작게 지정
tsne <- Rtsne( ds, dim=2, perplexity=15 )
tsne

#차원 축소 결과 시각화
df.tens <- data.frame( tsne$Y )
head(df.tens)

ggplot(df.tens, aes(x = X1, y = X2, color = ds.y)) +
  geom_point(size=2)

#비교~!
ggplot(iris, aes( x = Petal.Width, y = Petal.Length, color=Species))+
  geom_point(size=2)

install.packages( c("rgl", "car") )
library( car )
library( rgl )
library( mgcv )

tsne <- Rtsne( ds, dims = 3, perplecity = 10 )
df.tsne <- data.frame( tsne$Y )
head(df.tsne)

scatter3d( x = df.tsne$X1, y = df.tsne$X2, z = df.tsne$X3)

points <- as.integer( ds.y )
color <- c('red', 'green', 'blue')
scatter3d( x = df.tsne$X1, y = df.tsne$X2, z = df.tsne$X3,
           point.col = color[ points ],
           surface = FALSE )

#
#공간 시각화
#
#구글맵 사용 API key (나중에는 개인 계정에서 받아서 쓰쟝)
#AIzaSyDlmljbgzrqBC-ug1Mr1Q1Y4gvEOkOcR_g

#google map 사용
#절차
#1. R 최신버전 설치 (구글맵이 음청 자주 바뀐다고 한당)
#2. ggplot2 최신버전 설치
#3. ggmap 설치
#4. 구글맵을 사용하기 위한 API key 획득
#5. 구글맵을 이용한 공간 시각화 수행

install.packages("ggmap")
library(ggmap)
register_google( key = 'AIzaSyDlmljbgzrqBC-ug1Mr1Q1Y4gvEOkOcR_g' )

#특정 지점의 경도, 위도를 알아와주는 함수
gc <- geocode( enc2utf8("이도근린공원"))
gc

cen <- as.numeric( gc )
cen

#지도 표시
map <- get_googlemap( center = cen ) #지도 중심점 좌표
ggmap( map )

gc <- geocode( enc2utf8( "한라산" ) )
cen <- as.numeric( gc )
map <- get_googlemap( center = cen,
                      zoom = 10, size = c( 640, 640 ),
                      maptype = "hybrid" )
ggmap( map )

map <- get_googlemap( center = cen, zoom = 10, size = c(640, 640),
                      maptype = "roadmap" )
ggmap(map)

map <- get_googlemap( center = cen, zoom = 10, size = c(640, 640),
                      maptype = "terrain" )
ggmap(map)

cen <- c(126.561099, 33.253077)
map <- get_googlemap(center = cen, zoom=15, maptype="roadmap")
ggmap(map)


#지도 위 마커 표시
#gc <- geocode( enc2native("jeju"))
gc <- geocode( enc2utf8("제주"))
cen <- as.numeric( gc )
cen
map <- get_googlemap( center = cen, maptype = "roadmap",
                      marker = gc )
ggmap( map )

names <- c("용두암","성산일출봉","정방폭포",
           "중문관광단지","한라산1100고지","차귀도")
addr <- c("제주시 용두암길 15", "서귀포시 성산읍 성산리",
          "서귀포시 동홍동 299-3", "서귀포시 중문동 2624-1",
          "서귀포시 색달동 산1-2", "제주시 한경면 고산리 125")
gc <- geocode( enc2utf8( addr ) )
gc

#관광지 명칭과 좌표값으로 Data Frame 생성
df <- data.frame( name = names, lon = gc$lon,
                  lat = gc$lat )
df

cen <- c(mean(df$lon), mean(df$lat) )
map <- get_googlemap( center = cen, 
                      maptype = "roadmap",
                      zoom = 10,
                      size = c( 640, 640 ),
                      marker = gc )
ggmap( map )

#자세한 내용은 여기에서
#https://developers.google.com/maps/documentation/maps-static/dev-guide

#지도에 관광지 이름 추가
gmap <- ggmap( map )
gmap +
  geom_text( data = df,
             aes( x = lon, y = lat ),
             size = 5,
             label = df$name )

#지도에 데이터 표시
dim( wind )
str( wind )

sp <- sample( 1:nrow( wind ), 50 )
df <- wind[ sp, ]
head( df )

cen <- c( mean( df$lon ), mean( df$lat ) )
gc <- data.frame( lon = df$lon, lat = df$lat )
head( gc )

#지도에 마커 표시
map <- get_googlemap( center = cen,
                      maptype = "roadmap",
                      zoom = 6,
                      marker = gc )
ggmap( map )

#지도에 풍속을 원의 크기로 표시
map <- get_googlemap( center = cen,
                      maptype = "roadmap",
                      zoom = 6 )
gmap <- ggmap(map)
gmap +
  geom_point( data = df, aes( x = lon, y = lat, size = spd ),
              alpha = 0.5, col = "blue" ) +
  scale_size_continuous( range = c(1, 14) )

#단계 구분도
install.packages("ggiraphExtra")
library(ggiraphExtra)

dim( USArrests )
str( USArrests )
head( USArrests )

library(tibble)
crime <- rownames_to_column( USArrests, var = "state" )
crime$state <- tolower( crime$state )
str( crime )

library(ggplot2)
install.packages("mapproj")
library(mapproj)

state_map <- map_data("state")
str(state_map)

ggChoropleth(data = crime,
             aes( fill = Murder, map_id = state ),
             map = state_map)
#함수를 찾을 수 없다고 나옴
#패키지 삭제 후 재설치 혹은 R 버젼 문제인 듯!
#https://github.com/youngwoos/Doit_R/issues/7

install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")
devtools::install_github("cardiomoon/moonBook2")

library(kormaps2014)
library(moonBook2)

#설치에 실패했다잉 / 집가서 다시 하던가 해야겠음
#http://rpubs.com/cardiomoon/222145 한국행정지도


theme_set(theme_gray(base_family = "NanumGothic"))
ggplot(korpop1, aes(map_id = code, fill=총인구_명))+
  geom_map(map=kormap1, colour="black", size=0.1)+
  expand_limits(x=kormap1$long, y=kormap1$lat)+
  scale_fill_gradientn(colours=c("white", "orange", "red"))+
  ggtitle("2015년도 시도별 인구분포도")+
  coord_map()

#여기서는 다른 형태의 지도 데이터를 사용하나봄 (shapefile)
#http://www.gisdeveloper.co.kr/?p=2332
#활용법은 아래 글 참고
#https://statkclee.github.io/spatial/geo-info-shapefile.html


