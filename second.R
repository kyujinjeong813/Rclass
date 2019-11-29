#
# break / next
# 알아는 두기 / 많이 쓰면 안좋다
#
sum <- 0
for ( i in 1:10 ) {
  sum <- sum + i
  if ( i >= 5 ) {
    break
  }
}
sum


sum <- 0
for ( i in 1:10 ) {
  if ( i %% 2 ) {
    next
  }
  sum <- sum + i
}
sum

#
#산술 내장 함수
#
log( 10 ) + 5 #로그함수
log( 10, base = 2 )
sqrt( 25 ) #제곱근
max( 5, 3, 2 ) #가장 큰 수
min( 3, 9, 5 ) #가장 작은 수
abs( -10 ) #절대값
factorial( 5 ) #팩토리얼
sin ( pi / 2 ) #삼각함수

#
#사용자 정의 함수
#
mymax <- function( x, y ) { # 함수 정의
  num.max <- x
  if ( y > num.max ) {
    num.max <- y
  }
  return ( num.max )
}
mymax( 10, 15 ) # 함수 호출
a <- 10
b <- 5
c <- 8
max <- mymax( a, b )
max <- mymax( max, c )
max

#사용자 정의 함수 매개변수 초기값 설정
mydiv <- function( x, y=2 ) { # 디폴트값
  result <- x / y
  return ( result )
}

mydiv( x = 10, y = 3 )
mydiv( 10,3 )
mydiv(10)


#외부파일에 있는 함수 호출
setwd( "D:/workR" )     # 경로 지정
source( "mylib.R" )     # Lib 파일 지정

#함수 호출
my_max( 10, 5 )
my_div( 10, 2 )



#
# vector 도입
#
#scalar형 변수 사용
a <- 10
b <- 5
c <- 8
max <- a
if ( b > max ) { max <- b }
if ( c > max ) { max <- c }
max

# vector 사용
v <- c( 10, 5, 8, 21, 106, 98, 72, 16, 48, 91 )
max <- v[ 1 ]
for ( i in 2:length( v ) ) {
  if ( v[ i ] > max ) {
    max <- v[ i ]
  }
}
max

#vector 생성
x <- c( 1, 2, 3 )
y <- c( "a", "b", "c" )
z <- c( TRUE, TRUE, FALSE, FALSE )
x; y; z

class(x)
class(y)
class(z)

#벡터는 반드시 동일 자료형 집합이어야 한다
w <- c( 1, 2, 3, "a", "b", "c" )
w
class(w)

#R이 알아서 정수/실수 구분을 한다 (내부적으로만 사용)
v1 <- 50:90
v1
class(v1)
v2 <- c( 1, 2, 3, 50:90 );
v2
class(v2)

#바뀌긴 하는데 바람직한 건 아니얌
v3 <- c( 1, 2, 3, TRUE, FALSE )
v3
class(v3)

v3 <- seq( 1, 101, 3)
v3
v4 <- seq( 0.1, 1.0, 0.1 )
v4
v5 <- rep( 1, times=5 )
v5
v6 <- rep( 1:5, times=3 )
v6
v7 <- rep( c( 1, 5, 9 ), times = 3 )
v7

#벡터 원소값에 이름 지정
score <- c( 90, 85, 70 )
score
names( score ) # 이름을 지정할 때 사용하는 함수
names( score ) <- c( "Hong", "Kim", "Lee" ) # 개수가 반드시 일치해야 함
names( score )
score

#벡터 원소 접근
score[ 1 ]
score[ 2 ]
score[ 3 ]
score[ "Hong" ]
score[ "Kim" ]
score[ "Lee" ]

d <- c( 1, 4, 3, 7, 8 )
d[ 1 ]
d[ 2 ]
d[ 3 ]
d[ 4 ]
d[ 5 ]
d[ 6 ] #다른 언어에서는 오류나는데 여기서는 NA
       #NA : 결측치 (missing value)
# NULL은 아무것도 없다 / NA는 읽을 수 없다 -> 메모리 관점에서 어떻게 이해?
# NAN 은 계산할 수 없다
# inf 무한대

for ( i in 1:length( score ) ) {
  print( score[ i ] )
}

score_names <- c( "Hong", "Kim", "Lee" )
for( i in 1:length( score ) ) {
  print( score[ score_names[ i ] ] )
}


#벡터에서 여러 개의 값을 한번에 추출
d <- c( 1, 4, 3, 7, 8 )
d[ c( 1, 3, 5 ) ]
d[ 1:3 ]
d[ seq( 1, 5, 2 ) ]
d[ -2 ]
d[ -c(3:5) ]

GNP <- c( 2090, 2450, 960 )
GNP

names( GNP ) <- c( "Korea", "Japan", "Nepal" )
GNP

GNP[ 1 ]
GNP[ "Korea" ]
GNP[ c( "Korea", "Nepal" ) ]
GNP[ names(GNP) ]

#벡터 요소값 변경
v1 <- c( 1, 5, 7, 8, 9 )
v1
v1[ 2 ] <- 3
v1
v1[ c( 1, 5 )] <- c( 10, 20 )
v1

#벡터 간 연산 : 두 벡터의 요소 길이가 같아야 함
x <- c( 1, 2, 3 )
y <- c( 4, 5, 6 )
x + y
x * y
z <- x + y
z

x <- c( 1, 2, 6, 8 )
w <- c(1, 3)
x+w

#벡터에 적용가능한 함수
d <- c( 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 )
sum( d ) #합계
sum( 2 * d ) 
length( d ) #벡터의 요소 개수 (길이)
mean( d[1:5] ) #평균
mean( d )
median( d ) #중앙값
max( d ) #최대값
min( d ) #최소값
sort( d ) #정렬
sort( d, decreasing = FALSE )
sort( d, decreasing = TRUE )
range( d ) #값의 범위 (최소값~최대값)
var( d ) #분산
sd( d ) #표준편차

d <- c( 4, 7, 1, 34, 78, 3, 0 )
rank( d ) 
order( d )
summary( c )
table( d )

#벡터에 논리연산 적용
d >= 5
d[ d>5 ]
sum( d > 5 ) #조건을 만족하는 요소의 개수 구함
sum( d[ d > 5 ] ) #조건을 만족하는 요소들의 합
d == 5 #5와 같은 것의 위치 파악 (이걸 인덱스로 활용 가능)

cond <- d > 5 & d < 8
cond
d[ cond ]

all( d > 5 )
any( d > 5 )

head( d )
tail( d )
head( d, 3 )
tail( d, 3 )

x <- c( 1, 2, 3 )
y <- c( 3, 4, 5 )
z <- c( 3, 1, 2 )

w <- c( x, y )
w
union( x, y ) #합집합
intersect( x, y ) #교집합
setdiff( x, y ) #차집합
setequal( x, y ) #x,y에 동일한 요소가 있는지 확인
setequal( x, z )


#List
ds <- c( 90, 85, 70, 84 )
my.info <- list( name = 'Hong', age = 30, status = TRUE, score = ds )
#score의 value는 벡터 타입
my.info
my.info[1]
my.info[[1]] #실제 값에 접근하려면 대괄호 2개여야 행
my.info$name
my.info[[4]]
my.info[[4]][1]
my.info$score[2]
#헷갈리지마! 리스트는 1차원이다. 2차원 아니얌얌

#factor형
bt <- c( 'A', 'B', 'B', 'O', 'AB', 'A' ) #문자열 벡터
bt.new <- factor( bt ) #팩터형 벡터
bt
bt.new
bt[ 5 ]
bt.new[ 5 ]
levels( bt.new ) #레벨 범위값을 확인할 때 사용하는 함수
as.integer( bt.new ) #범주형은 산술연산이 안되니까 이걸로 바꾸는 고
bt.new[ 7 ] <- 'B'
bt.new[ 8 ] <- 'C' #levels에 포함되지 않는 값이니까 에러에러
bt.new
#외부 데이터 읽어올 때 팩터로 읽어오는 케이스가 있음!
bt.old <- as.integer(bt.new)
bt.old
class(bt.old)

