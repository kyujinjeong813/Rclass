# 함수 반환값(return값)이 여러 개일 때의 처리

myfunc <- function( x, y ) {
  val.sum <- x + y
  val.mul <- x * y
  
  return ( list ( sum = val.sum, mul = val.mul ) )
}

result <- myfunc( 5, 8 )
s <- result$sum
m <- result$mul
cat( ' 5 + 8 = ', s, '\n' )
cat( ' 5 * 8 = ', m, '\n' )

#
#Matrix 생성 - 열 우선방식(default)
# 행/관측치
z <- matrix( 1:20, nrow = 4 )
z
#열/변수
z <- matrix( 1:20, ncol = 4 )
z

z <- matrix( 1:20, nrow = 4, ncol = 5 )
z

z <- matrix( 1:20, nrow = 4, ncol = 5, byrow = T )
z

x <- 1:4
x
y <- 5:8
y
z <- matrix( 1:20, nrow = 4, ncol = 5 )
z

m1 <- cbind( x, y )
m1
m2 <- rbind( x, y )
m2
m3 <- rbind( m2, x)
m3
m4 <- cbind( z, x )
m4


#Matrix에서 cell의 값 추출
z[ 2, 3 ]
z[ 1, 4 ]
z[ 2, ] #행 전체
z[ ,4 ] #열 전체

z[ 2, 1:3 ]
z[ 1, c( 1, 2, 4 ) ]
z[ 1:2, ]
z[ , c( 1, 4 ) ]


#Matrix에서 행/열에 이름 지정
score <- matrix( c( 90, 85, 69, 78, 
                    85, 96, 49, 95,
                    90, 80, 70, 70),
                 nrow = 4, ncol = 3 )
score
#과목이 변수, 학생이 관측치
rownames( score ) <- c( "Hong", "Kim", "Lee", "Yoo" )
colnames( score ) <- c( "English", "Math", "Science" )
score

#인덱스보다 이름을 부여하니 cell에 접근하는 게 더 명확해짐
score[ 'Hong', 'Math' ]
score[ 'Kim', c( 'Math', 'Science' ) ]
score[ "Lee", ]
score[ , "English" ]
rownames( score )
colnames( score )
colnames( score )[2]

#Data Frame 생성
city <- c( "Seoul" , "Tokyo", "Washington" )
rank <- c( 1, 3, 2 )
city.info <- data.frame( city, rank )
city.info

name <- c( "Hong", "Kim", "Lee" )
age <- c( 22, 20, 25 )
gender = factor( c("M", "F", "M" ) )
blood.type = factor( c("A", "O", "B" ) )
person.info <- data.frame( name, age, gender, blood.type )
person.info

person2.info <- data.frame(name = c( "Hong", "Kim", "Lee" ),
                           age = c( 22, 20, 25 ),
                           gender = factor(c("M", "F", "M" )),
                           blood.type = factor(c("A", "O", "B" )) )
person2.info

#Data Frame 데이터 접근
city.info
city.info[ 1, 1 ]
city.info[ 1, ]
city.info[ ,1 ]
city.info[ ,"rank" ]
city.info[ city.info$city, ] #이거 쫌 헷갈...?

person.info
person.info$name
person.info[ person.info$name == "Hong", ]
person.info[ person.info$name == "Hong", c("name", "age")]

data()
iris
dim(iris)
iris[ , c(1:2) ]
iris[ , c(1, 3, 5)]
iris[ , c("Sepal.Length", "Species")]
iris[ 1:5, ]
iris[ 1:5, c( 1,3 )]
rownames(iris)
colnames(iris)
head(iris)
tail(iris)

#R에서 많이 쓰는 datasets : mtcars, ...
head(mtcars)
head(state.x77)

#Matrix 와 Data Frame 에서 사용하는 함수
dim( person.info ) #관측치의 수, 변수의 수
dim( iris )
nrow( person.info )
nrow( m3 )
ncol( m3 )
ncol( person.info)
head( iris ) #보통 1% -> 10% -> 50% 정도로 살펴봄
tail( iris ) #
str( iris ) #
str( person.info )
str( city.info )
unique( iris )
unique( iris[,"Species"] )
table( iris[, "Species" ] ) # 이거는 처음보는거다!_! #많이쓴다
table( person.info[,"blood.type"]) #종류별 카운트 #데이터 구조 파악할 때 죠음

#Matrix/Data Frame 사용 함수
#행별/열별 합계와 평균 계산
colSums(iris[,-5]) #정형함수
apply( iris[ , 1:4], 2, sum ) #동작을 지정할 수 있음
colMeans(iris[,-5])
apply(iris[ , 1:4], 2, mean )
rowSums(iris[,-5])
apply(iris[ , 1:4], 1, sum )
rowMeans(iris[,-5])
apply( iris[ , 1:4], 1, mean )
apply( iris[ , 1:4], 2, median )
apply( iris[ , 1:4], 2, mean )
apply( iris[ , 1:4], 2, max )
apply( iris[ , 1:4], 2, min )
apply( iris[ , 1:4], 2, sd )

#행/열 방향 전환
z <- matrix( 1:20, nrow = 4, ncol = 5 )
z
t(z) #전치행렬

#조건에 맞는 행과 열의 값 추출 (Data Frame 만 가능)
IR.1 <- subset(iris, Species == 'setosa')
IR.2 <- subset(iris, Sepal.Length > 5.0 & Sepal.Width > 4.0 )
IR.2
IR.2[ , c( 2, 4 ) ]


#Matrix/Data Frame 산술연산
a <- matrix( 1:20, 4, 5 )
a
b <- matrix( 21:40, 4, 5 )
b

2 * a
b - 5 
2 * a + 3 * b
a + b
b - a
b / a
a * b

#Matrix/Data Frame 자료구조 확인/변환
class(iris)
str(iris)
class(state.x77)
str(state.x77)
is.matrix(iris)
is.data.frame(iris)
is.data.frame(state.x77)
is.matrix(state.x77)


st <- data.frame(state.x77)
str(st)
head(st)
class(st)
dim(st)

iris.m <- as.matrix(iris[ , 1:4])
head(iris.m)
class(iris.m)
str(iris.m)

head(st)
Population #에러남
attach(st) #변수 이름을 직접적으로 쓰길 원할 때 쓰면 됨!
Population #이제 괜찮음 (변수 하나는 벡터)
detach(st)
Population

#csv file 내용 읽기
setwd("D:/workR") #경로변경 (현재 디렉토리면 안해도 되지만 확실히 하기 위해서)
air <- read.csv("airquality.csv", header=T) #header : 첫 줄에 이름이 있냐없냥
class(air)
str(air)
dim(air)
head(air)
tail(air)

person.info
setwd("D:/workR")
write.csv( person.info, "person_info.csv", row.names=F)
