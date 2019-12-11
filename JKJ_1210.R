#
# 작성자 : 정규진
# 작성일 : 2019.12.10
# 제출일 : 2019.12.11
#

#문1)
#R에서 제공하는 state.x77 데이터셋을 차원 축소하여 2차원 산점도와 3차원 산점도를 작성하시오.
#(state.x77은 매트릭스 타입이기 때문에 데이터프레임으로 변환하여 실습한다.)

df <- data.frame(state.x77)
str(df)

library(Rtsne)
library(ggplot2)
dup = which(duplicated(df))
dup
tsne <- Rtsne( df, dim = 2, perplexity = 8 )
tsne
df.tsne <- data.frame(tsne$Y)
head(df.tsne)

ggplot(df.tsne, aes(x = X1, y = X2)) +
  geom_point(size=2)

#install.packages('rgl')
library( car )
library( rgl )
library( mgcv )
#맥에서는 rgl 받으려면 Xquartz가 깔려있어야 한다고

tsne3 <- Rtsne( df, dim =3, perplexity = 10)
df.tsne3 <- data.frame(tsne3$Y)

scatter3d( x = df.tsne3$X1, y = df.tsne3$X2, z = df.tsne3$X3)


#문2)
#R에서 제공하는 swiss 데이터셋을 차원 축소하여 2차원 산점도와 3차원 산점도를 작성하시오.

str(swiss)
dup = which(duplicated(swiss))
dup
tsne <- Rtsne( swiss, dim=2, perplexity=10 )
tsne
df.tsne <- data.frame(tsne$Y)
ggplot(df.tsne, aes(x=X1, y=X2)) +
  geom_point(size=2)

tsne3 <- Rtsne( swiss, dim=3, perplexity=10 )
df.tsne3 <- data.frame(tsne3$Y)

scatter3d( x=df.tsne3$X1, y=df.tsne3$X2, z=df.tsne3$X3)


#문3) 
#R을 이용하여 지도를 출력하시오.
#(1) 서울시청을 중심으로 지도 크기는 600x600, 지도 유형은 roadmap인 지도를 출력하시오.

library(ggmap)
register_google( key = 'AIzaSyDlmljbgzrqBC-ug1Mr1Q1Y4gvEOkOcR_g' )

gc <- geocode( enc2utf8( "서울시청" ) )
cen <- as.numeric( gc )
cen
map <- get_googlemap( center = cen,
                      zoom = 14, size = c( 600, 600 ),
                      maptype = "roadmap" )
ggmap(map)


#(2) 금강산 지역을 근방으로 지도 크기는 500x500, 지도 유형은 hybrid, zoom은 8인 지도를 출력하시오.

gc <- geocode( enc2utf8("금강산") )
cen <- as.numeric(gc)
map <- get_googlemap( center = cen,
                      zoom = 8, size = c(500, 500),
                      maptype = "hybrid" )
ggmap(map)


#(3) 강남역 근방으로 지도 크기는 640x640, 지도 유형은 roadmap, zoom은 16인 지도를 출력하시오.
gc <- geocode( enc2utf8("강남역"))
cen <- as.numeric(gc)
map <- get_googlemap( center = cen,
                      zoom = 16,
                      size = c(640, 640),
                      maptype = "roadmap")
ggmap(map)


#(4) 지도 유형은 roadmap, zoom은 9인 경도 127.397692, 위도 36.337058 지역의 지도를 출력하시오.
map <- get_googlemap( c(127.397692, 36.337058),
                      zoom = 9,
                      maptype = "roadmap")
ggmap(map)

#(5) 지도 유형은 roadmap, zoom은 10인 경도 135.502330, 위도 34.693594 지역의 지도를 출력하시오.
cen <- c(135.502330, 34.693594)
map <- get_googlemap( cen,
                      zoom = 10,
                      maptype = "roadmap" )
ggmap(map)


#문4)
#R을 이용하여 서울시 한강 이남의 구청들의 위치에 마커와 구청 이름을 지도 위에 표시하시오.
#위도latitude가 남북..인뎅.. 이남이면 한강 기준으로 더 작아야하는거
hanriver <- geocode(enc2utf8("한강"))
point <- as.numeric(hanriver)


names <- c("강동구청", "송파구청", "강남구청", "서초구청", "관악구청","동작구청",
           "영등포구청","금천구청","구로구청","양천구청", "강서구청", "용산구청",
           "마포구청", "광진구청")

gc <- geocode(enc2utf8(names))
#hall <- data.frame(geo_code)
#rownames(hall) <- names
#south_hall <- subset( hall, hall$lat < point[2] )
#south_hall

df <- data.frame( name = names, lon = gc$lon,
                  lat = gc$lat )
df

cen <- c(mean(df$lon), mean(df$lat) )
map <- get_googlemap( center = cen, 
                      maptype = "roadmap",
                      zoom = 10,
                      size = c( 640, 640 ),
                      marker = gc )

gmap <- ggmap( map )
gmap +
  geom_text( data = df,
             aes( x = lon, y = lat ),
             size = 5,
             label = df$name )

#문5)
#R을 이용하여 대한민국의 광역시를 지도 위에 출력하시오. 단, 마커와 광역시 이름을 함께 표시하시오.
names = c("부산광역시", "대구광역시", "인천광역시","광주광역시", "대전광역시", "울산광역시")
gc <-  geocode(enc2utf8(names))
gc

df <- data.frame( name = names, lon = gc$lon, lat = gc$lat )
cen <- c( mean(df$lon), mean(df$lat) )
map <- get_googlemap( center = cen, maptype = "roadmap", zoom = 6, marker = gc )
gmap <- ggmap( map )
gmap +
  geom_text( data=df, aes(x=lon, y=lat), size=5, label=df$name)


#문6)
#R을 이용하여 서울, 경기, 강원 지역의 국립공원 위치를 지도 상에 마커로 표시하되 국립공원의 이름을 함께 표시하시오.
names = c("북한산국립공원", "설악산국립공원","오대산국립공원","치악산국립공원",
          "태백산국립공원")
gc <-  geocode(enc2utf8(names))
df <- data.frame( name=names, lon=gc$lon, lat=gc$lat )
cen <- c(mean(df$lon), mean(df$lat))
map <- get_googlemap( center = cen, maptype = "roadmap", zoom=8, marker = gc )
gmap <- ggmap( map )
gmap +
  geom_text( data=df, aes(x=lon, y=lat), size=5, label=df$name)

#문7) 
#‘2018년도 시군구별 월별 교통사고 자료’로부터 서울시의 각 구별 1년 교통사고 발생건수를 지도상에 원의 크기로 나타내시오.

setwd("D:/Rclass")
#t_acc <- read.csv("report.csv", header = F, skip=2, stringsAsFactors = F)
#str(t_acc)
#setwd("/Users/jeong-kyujin/Desktop/workR")
car_acc_2018 <- read.csv("도로교통공단_시도_시군구별_월별_교통사고(2018).csv",
                         header=TRUE, sep=',', stringsAsFactors=FALSE)
#fileEncoding = "CP949", encoding = "UTF-8",
car_acc_2018 <- car_acc_2018[,1:4]
str(car_acc_2018)

library(dplyr)
seoul_acc_2018 <- car_acc_2018 %>% 
  filter( 시도 == "서울") %>%
  select( 시군구, 발생건수) %>%
  group_by( 시군구 ) %>%
  summarise( sum = sum(발생건수))

str(seoul_acc_2018)
names <- as.vector(t(seoul_acc_2018[1]))
str(names)
seoul_acc <- as.vector(t(seoul_acc_2018[2]))
str(seoul_acc)
sgc <- geocode(enc2utf8(names))
sgc
df <- data.frame(name=names, lon=sgc$lon, lat=sgc$lat)
df$acc <- seoul_acc
df

cen <- c(mean(df$lon), mean(df$lat))
map <- get_googlemap(center = cen, maptype = "roadmap", zoom=10)
gmap <- ggmap(map)
gmap +
  geom_point( data = df, aes( x = lon, y = lat, size = acc ),
              alpha = 0.5, col = "blue" ) +
  scale_size_continuous( range = c(1, 14) )


#문8)
#7번과 동일한 자료를 이용하여 제주시 1년 교통사고 발생건수를 지도상에 원의 크기로 나타내시오.
jeju_acc <- car_acc_2018 %>%
  filter(시군구 == '제주시' ) %>%
  select(시군구, 발생건수) %>%
  group_by(시군구) %>%
  summarise( sum = sum(발생건수))

jeju_acc_cnt <- as.numeric(jeju_acc[2])
jeju_acc_cnt

gc <- geocode(enc2utf8('제주시'))
jeju_df <- data.frame( lon = gc$lon, lat = gc$lat )

map <- get_googlemap(center = c(gc$lon, gc$lat), maptype = "roadmap", zoom=14)
gmap <- ggmap(map)
gmap +
  geom_point( data = jeju_df, aes( x = lon, y = lat, size = jeju_acc_cnt ),
              alpha = 0.5, col = "blue" ) +
  scale_size_continuous( range = c(1, 5) )
