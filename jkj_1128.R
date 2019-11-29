#
# 정규진
# 작성일 : 2019.11.28
# 제출일 : 2019.11.28
#

#문제1

d1 <- 1:50
d2 <- 51:100

#1 
d1
d2

#2 
length( d2 )

#3
d1 + d2
d2 - d1
d1 * d2
d2 / d1

#4 
sum( d1 )
sum( d2 )

#5 
sum( d1 + d2 )

#6 
max( d2 )
min( d2 )

#7 
mean( d2 )
mean( d1 )
d2 - mean( d2 )
d1 - mean( d1 )

#8 
sort( d1, decreasing = TRUE )

#9 
ad1 <- sort( d1, decreasing = FALSE )
ad2 <- sort( d2, decreasing = FALSE )

d3 <- c( ad1[ 1 : 10 ], ad2[ 1 : 10 ] )
d3
#head를 쓰면 훨씬 간단
#변수 생성 안하고 더 간단하게 한방에
d3 <- c( sort(d1, decreasing = FALSE)[1:10], sort(d2, decreasing = FALSE)[1:10] )

#문제2
v1 <- 51 : 90
v1

#1 
v1[ v1 < 60 ]

#2 
sum( v1 < 70 )
length( v1[ v1 < 70 ] )

#3 
sum( v1[ v1 > 65 ] )

#4 
v1[ ( v1 > 60 & v1 < 73 ) ]

#5 
v1[ ( v1 < 65 | v1 > 80 ) ]

#6 
v1[ ( v1 %% 7 == 3 ) ]

#7 
v1[ ( v1 %% 7 == 0 ) ] <- 0
v1

#8 
sum( v1[ ( v1 %% 2 == 0 ) ] )

#9 
v1[ ( v1 %% 2 == 1 | v1 > 80 ) ]

#10 
v1[ ( v1 %% 3 == 0 & v1 %% 5 == 0 & v1 != 0 ) ]

#11 
v1[ ( v1 %% 2 == 0 ) ] <- v1[ ( v1 %% 2 == 0 ) ]* 2
v1

#12 
v1[ ( v1 %% 7 != 0 ) ]
# 0은 7의 배수가 아니라서 0 고려해서 다시 품
setdiff( v1, v1[ ( v1 %% 7 == 0 ) & ( v1 != 0 ) ] )
# 이런 방법도!!
v1[-c(v1%%7==0)]

#치환이 필요했엉! 변경하라고 했엉!
v1 <- 50:90
v1 <- v1[ (v1 %% 7 != 0 ) ]
v1