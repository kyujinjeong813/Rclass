#
# 
# 작성일 : 2019.11.29
# 제출일 : 2019.11.29
#

#문제1 (앞으로는 문제를 스크립트에 같이 적자!)
#1.1
m <- c( 10, 40, 60, 20 )
f <- c( 21, 60, 70, 30 )
score <- cbind( m, f )
score
class(score)
score <- data.frame( m, f )
score
class(score)
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
st <- as.data.frame(state.x77) #as 쓸 필요 없음
st <- data.frame(state.x77)
#2.2
st
#2.3
colnames(st)
names(st)
#2.4
rownames(st)
#2.5
dim(st)
nrow(st)
ncol(st)
#2.6
str(st)
#2.7
apply( st, 1, sum ) ; rowSums( st )
apply( st, 1, mean ) ; rowMeans( st )
#2.8
apply( st, 2, sum ) ; colSums( st )
apply( st, 2, mean ) ; colMeans( st )
#2.9
st[ "Florida" , ]
#2.10
st[ , "Income" ]
#2.11
st[ "Texas", "Area"]
#2.12
st[ "Ohio", c( "Population", "Income") ]
#2.13
subset( st, Population >= 5000 )
#2.14
subset( st, Income >= 4500 )[ , c("Population", "Income", "Area" ) ]
subset( st, Income >= 4500, select = c( "Population", "Income", "Area" ) )
#2.15 
nrow(subset( st, Income >= 4500 ))
dim(unique( subset( st, Income >= 4500 ) ) )[1]
#2.16
subset( st, ( Area >= 100000 & Frost >= 120 ) ) #괄호는 생략 가능
#2.17
subset( st, ( Population < 2000 & Murder < 12 ) ) #괄호는 생략 가능
#2.18
mean( subset( st, Illiteracy >= 2.0 )$Income ) #첫번째
mean( subset( st, Illiteracy >= 2.0 )[ , "Income" ]) #두번째
mean( st[ st$Illiteracy >= 2.0, ]$Income ) #세번째
#2.19 (1)
high <- mean(subset( st, Illiteracy >= 2.0 )$Income)
low <- mean(subset( st, Illiteracy < 2.0 )$Income)
low - high
#2.19 (2)
abs( mean ( subset( st, Illiteracy >= 2.0 )$Income ) - mean( subset( st, Illiteracy < 2.0 )$Income ) )
#2.19 (3)
mean( st [ st$Illiteracy < 2.0, ]$Income ) - mean( st[ st$Illiteracy >= 2.0, ]$Income )
#2.20
row.names( st [ st$"Life Exp" == max ( st$"Life Exp" ), ] ) #첫번째
row.names( st [ order ( st$"Life Exp" ), ][ 50, ] ) #두번째
row.names( st [ order (-st$"Life Exp" ), ] ) [ 1 ] #세번째

max.life <- max( st$Life.Exp )
rownames( subset( st, Life.Exp == max.life ) )

#2.21
row.names( subset( st, Income > st[ "Pennsylvania", "Income" ] ) ) #첫번째
row.names( st[ st$Income > st[ "Pennsylvania", "Income" ] , ] ) #두번째

pen.income <- st[ 'Pennsylvania','Income' ]
rownames( subset( st, Income > pen.income ) )

#문제3
#3.1
class(mtcars)
#3.2
dim(mtcars)
#3.3
str(mtcars)
#3.4
attach(mtcars)
row.names(mtcars[order(-mpg),])[1]

max.mpg <- max( mtcars$mpg )
rownames( mtcars[ mtcars$mpg == max.mpg, ] ) # 방법 1
rownames( subset( mtcars, mpg == max.mpg ) ) # 방법 2

#3.5
mtcars4 <- subset( mtcars, gear == 4) # 또는 mtcars[ gear == 4, ]
row.names( mtcars4 [ mtcars4$mpg == min(mtcars4$mpg), ] ) # 첫번째
row.names( mtcars4[ order( mtcars4$mpg ), ] ) [ 1 ] # 두번째

min.mpg <- min( mtcars[ mtcars$gear == 4, 'mpg' ] )
rownames( mtcars[ mtcars$mpg == min.mpg, ] ) # 방법 1
rownames( subset( mtcars, mpg == min.mpg ) ) # 방법 2

#3.6
mtcars [ row.names( mtcars ) == "Honda Civic", c( "mpg", "gear" ) ] # 첫번째
mtcars [ row.names( mtcars ) == "Honda Civic",][ , c( "mpg", "gear" ) ] # 두번째

mtcars[ 'Honda Civic','mpg' ]

#3.7
pmpg <- mtcars [row.names( mtcars ) == "Pontiac Firebird" , "mpg" ]
row.names( mtcars [ mtcars$mpg > pmpg , ] )

pon.mpg <- mtcars[ 'Pontiac Firebird','mpg' ]
rownames( mtcars[ mtcars$mpg > pon.mpg, ] ) # 방법 1
rownames( subset( mtcars, mpg > pon.mpg ) ) # 방법 2

#3.8
mean( mtcars$mpg ) # 첫번째
mean( mtcars[ , "mpg" ] ) # 두번쨰
colMeans( mtcars )[ "mpg" ] # 세번째
#3.9
unique( mtcars $ gear ) # 첫번째
levels( factor ( mtcars $ gear ) ) # 두번째

#문제4
#4.1
str( airquality )

class( airquality )

#4.2
head( airquality )
#4.3
airquality [ airquality $ Temp == max( airquality $ Temp ) , c( "Month", "Day" ) ]

max.temp <- max( airquality$Temp )
airquality[ airquality$Temp == max.temp, c( 'Month','Day' ) ]       # 방법 1
subset( airquality, Temp == max.temp, select = c( 'Month','Day' ) ) # 방법 2

#4.4
max( airquality [ airquality $ Month == 6 , ] $ Wind )

max( airquality[ airquality$Month == 6, 'Wind' ] )

#4.5
mean( airquality [airquality $ Month == 7 , ] $ Temp )

mean( airquality[ airquality$Month == 7, 'Temp' ] )

#4.6
nrow( subset( airquality, Ozone > 100 ) )
nrow(na.omit(airquality [ airquality$Ozone > 100 , ]))

#문제5
#5.1
df <- as.data.frame(state.x77)
df
df2 <- df[ df$Income >= 5000 , ][ c( "Income" , "Population", "Area" ) ]
df2
setwd("D:/workR")
write.csv( df2, "rich_state.csv", row.names = F )
#5.2
ds <- read.csv("rich_state.csv", header = T )
ds



