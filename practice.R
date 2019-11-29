#
#개인공부
#R 반복 연산 프로그래밍
#

#for문 연습
for ( x in 1:10 ) {
  y <- 10 + 5 * x
  print( y )
}

#for문 연습 + expression
y <- 0
for ( x in 1:10 ) {
  y <- y + x
  cat( "cummulative summation from 0 to ", x, " is ", y, "\n" )
}

#while문 연습
i <- 1
sum <- 0
while ( i <= 10 ) {
  sum <- sum + i
  cat( "cummulative summation from 0 to ", i, " is ", sum, "\n" )
  i <- i + 1
}

#while(condition) => stop
i <- 1
while( i <= 5 ) {
  i <- i + 3
}
i

#while(T/F) { if () break } => stop
j <- 1
while(TRUE) {
  j <- j + 3
  if ( j > 10 ) break
}

#repeat { if () break } => stop
j <- 1
repeat { j <- j + 3
         if ( j > 5 ) break
}
j


#repeat 연습
i <- 1
fac <- 0
repeat {
  fac <- factorial(i)
  cat("factorial(",i,") : ", fac, "\n" )
  i <- i + 1
    if ( fac > 10^12) break
}

#repeat 연습2
i <- 1
repeat {
  fac <- factorial(i)
  cat( "factorial(", i, ") = ", fac, "\n" )
  if ( fac > 1e+100 ) break
  i <- i + 1
  
}

#
#R 조건 연산 프로그래밍
#

#1. 하나의 논리값에 대한 판단 if()
x1 <- c(4)
if ( x1 %% 2 == 0 ) {
  y1 <- c("Even Number")
  print(y1)
} else {
  y1 <- c("Odd Number")
  print(y1)
}

x2 <- c(5)
if ( x2 %% 2 == 0 ) {
  y2 = "Even Number"
  print(y2)
} else {
  y2 = "Odd Number"
  print(y2)
}

#2. 두 개 이상의 논리값 벡터에 대한 판단 ifelse()
##vector에 대한 판단
##홀수/짝수 여부 판단 : ifelse( condition, expression, expression2 )

x <- c(1, 2, 3, 4, 5)
z <- ifelse( x%%2 == 0, "Even Number", "Odd Number" )
xz <- data.frame( x, z )
xz

##양수, 0, 음수 여부 판단하는 프로세스
x <- c(1, 2, 3, 0, -4, -1)
z <- ifelse( x > 0, "Positive", ifelse( x == 0 , "0", "Negative"))
xz <- data.frame(x,z)
xz

#와플차트 그리기! https://kuduz.tistory.com/1144
install.packages('waffle')
install.packages('ggplot2')

w <- c(43, 11, 46)
waffle(w)
