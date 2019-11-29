#
# R 프로그래밍 1일차
#
# first.R
#
# 작성자 : Chloe
#
# 최초작성일 : 2019. 11. 26
#
#
print("hello world!!!")

#쓰기기능
number <- 10
number2 = 100
number3 <- number

numberValue <- 1
str_value <- "R Language"
booleanvalue <- TRUE

numberValue <- "R script"
#R은 동적 자료형을 사용하기 때문에 가능, 그러나 연산오류 가능성이 있다


numberValue <- 1
print( numberValue )
print( str_value )
print( booleanvalue )

cat("Numeric number : ", numberValue, "\n")
cat("string : ", str_value, "\n")
cat("Boolean Value : ", booleanvalue, "\n")

numberValue <- scan()
cat("Numeric number : ", numberValue, "\n")

number1 <- 10
number2 <- 20
resultAdd <- number1 + number2
resultSub <- number1 - number2
resultMul <- number1 * number2
resultDiv <- number1 / number2
resultRem <- number2 %% number1
resultSec <- number2 ** 5

print( resultAdd )
print( resultSub )
print( resultMul )
print( resultDiv )
print( resultRem )
print( resultSec )

number1 <- 0
number1 <- number1 + 10
#연산 우선순위 : 치환 연산자 기준으로 R value 먼저 계산, 그다음 L value
number1 <- number1 + 10
number1 <- number1 + 10 #누적
number1

number2 <- 100
number1 <- number2 + 10 #치환
number1
number2
# 누적의 형태나, 치환의 형태냐 잘 구분해야 함!

print(number1 + 10 * number2 / 2)
#연산 결합 방향 : 동순위의 연산자가 오면 결합 방향은 일반적으로 왼->오

number300 <- number300 +10
number300
#런타임에러
#누적의 주의점 : 꼭 초기값을 설정해줘야함

#올바른 코드
number300 <- 10
number300 <- number300 +10
number300

number301 <- number300 * 2
number301

#관계연산으로 넘어가 봅시다
number1 <- 10.5
number2 <- 10
print(number1 > number2)
print(number1 >= number2)
print(number1 < number2)
print(number1 <= number2)
print(number1 == number2)
print(number1 != number2)

#논리연산
print(number1 > 10 & number2 > 10) # AND
print(number1 > 10 | number2 > 10) # OR
print(!(number1 > 10)) # NOT

#숫자문자 연산은 불가능, 같은 자료형끼리만 연산
number <- 100
str <- "R Language"
result = number + str
print(result)

#R에서는 숫자끼리 연산만 가능 (다른 언어에서는 되기도 함)
number <- "100"
str <- "R Language"
result = number + str
print(result)


#제어구조 - 선택구조
#양자택일(선택구조 중 가장 기본)
job.type <- 'A'
if (job.type == 'B'){
  bonus <- 200 #참일때
} else {
  bonus <- 100 #거짓일때
}
cat("job type : ", job.type, "\t\tbonus : ", bonus)

#단순 선택구조
job.type <- 'B'
if (job.type == 'A') {
  bonus <- 200
}
cat("job type : ", job.type, "\t\tbonus : ", bonus)

#다중 선택구조 (조건문의 순서가 중요!)
score <- 85

if ( score >= 90 ) {
  grade <- 'A'
} else if ( score >= 80 ) {
  grade <- 'B'
} else if ( score >= 70 ) {
 grade <- 'C'
} else if ( score >= 60 ) {
  grade <- 'D'
} else {
  grade <- 'F'
}
cat( "score : ", score, "\t\tgrade : ", grade)

#문제문제 연습문제 타임
# output : number : 15는 홀수이다
# 예외의 경우를 생각해야 함, 정수가 아닌 실수(특히 0)

number <- 10

if (number %% 2 == 1) {
  oddeven <- '홀수'
} else {oddeven <- '짝수'
}

cat("number : ", number, "는", oddeven, "이다")


'==========================='

number <- 0
#remainder <- number %% 2 이렇게 해도 됨

print(number != 0)
if (number == 0) {
  oddeven <- '0'
} else if (number %% 2 == 1) {
  oddeven <- '홀수'
} else if (number %% 2 == 0) {
  oddeven <- '짝수'
} else { oddeven <-'자연수,0이 아닙니다'}

cat("number : ", number, "는", oddeven, "이다")


#논리연산자를 활용한 조건문
a <- 5
b <- 20
if ( a > 5 & b >5 ){
  cat ( a, " > 5 and ", b, " > 5 " )
} else {
  cat ( a, " < = 5 or ", b, " <= 5 " )
}



a <- 10
b <- 20

if ( a > b ) {
  c <- a
} else {
  c <- b
}
cat( "a = ", a, "\tb = ", b, "\tc = ", c )

#위에껄 간결하게 쓰는 방법!
c <- ifelse( a > b, a, b )
cat("a = ", a, "\tb = ", b, "\tc = ", c)

x <- c(6:-4)
sqrt(x)  #- gives warning
sqrt(ifelse(x >= 0, x, NA))  # no warning

## Note: the following also gives the warning !
ifelse(x >= 0, sqrt(x), NA)

#문제 : a,b,c중 가장 큰 수를 max에 저장 후 max를 출력
#나의 풀이
a <- 10
b <- 5
c <- 8

max <- ifelse( a > b , a , b )
max <- ifelse ( max > c , max, c)
cat ( "a = ", a, "b = " , b, "c = ", c, "max = ", max)


#쌤의 풀이
a <- 10
b <- 5
c <- 8

max <- a
if ( b > max ) {
  max = b
}
if ( c  > max ){
  max = c
}
cat ( "a = ", a, "b = " , b, "c = ", c, "max = ", max)

#반복구조1
#for문
for ( i in 1:10 ) {
  print ( i )
}

multiple = 2
for ( i in 2:9 ) {
  cat(multiple, ' X ', i, " = ", multiple * i, '\n')
}

#while문
i <- 1
while ( i < 9 ) {
  print( i )
  i <- i + 1
}

multiple <- 2
i <- 2
while ( i <= 9 ) {
  cat(multiple, " X ", i, " = ", multiple * i, "\n")
  i <- i + 1
}

#1~100까지 한 줄에 10개씩 출력 (for문 사용)

#나의 풀이 (이자 쌤의 두번째 풀이)
for(i in 1:100) {
  cat(i, " ")
  if( i %% 10 == 0 ){
    print('\n')
  }
}

#쌤의 풀이
linecount <- 1
for( i in 1:100 ) {
  cat( i, " " )
  linecount <- linecount + 1
  if ( linecount > 10 ) {
    print ("\n")
    linecount <- 1 #초기화
  }
}

#20191127 숙제
#일단 답은 나오는 코드 / 근데 별로 맘에 안들옹ㅠㅠ
#아맞다 출력된 숫자 개수도 !!
count <- 0
for ( i in 1:1000 ) {
  if ( i %% 3 == 0 ) {
    cat( i, " " );
    count <- count + 1;
    if ( count %% 10 == 0 ){
      print( "\n" )
    }
  } else if ( i %% 5 == 0 ) {
    cat( i, " " );
    count <- count + 1;
    if ( count %% 10 == 0 ){
      print( "\n" )
    }
  }
}
cat( count )
    
#좀 더 간단하게 간당!
count <- 0
for ( i in 1:1000 ) {
  if ( i %% 3 == 0 | i %% 5 == 0 ) {
    cat( i, " ");
    count <- count + 1;
    if ( count %% 10 == 0 ) {
      cat( "\n" )
    }
  }
}
cat( count )


