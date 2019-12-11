#
# 작성자 : 정규진
# 작성일 : 2019.12.11
# 제출일 : 2019.12.11
#

library(wordcloud)
library(wordcloud2)
library(KoNLP)
library(RColorBrewer)

library(dplyr)
library(ggplot2)

useSejongDic()
useNIADic()

#문1)
#20대 국회 개원 여·야 3당 대표 국회연설문에 대해 각각 워드클라우드를 작성하시오.
#예제소스 파일은 ‘ex_10-1.txt’, ‘ex_10-2.txt’, ‘ex_10-3.txt’이다.
#첫번째 연설문
setwd('D:/Rclass')
add1 <- readLines('ex_10-1.txt', encoding = 'UTF-8')
add1_word <- sapply(add1, extractNoun, USE.NAMES = F)
add1_words <- unlist(add1_word)

add_words <- c('민생경제', '컨트롤타워', '비상시국', '위험신호',
               '산업', 'IMF', '외환위기', '더불어민주당',
               '성장전략', '분배', '공정', '가계부채', '소득양극화',
               '소득불평등', '불공정', '법인세', '불공정', '인큐베이팅', '안보')
buildDictionary(user_dic = data.frame(add_words, rep('ncn', length(add_words))),
                replace_usr_dic = T)
get_dictionary('user_dic')

address1_word <- sapply(add1, extractNoun, USE.NAMES = F)
address1_words <- unlist(address1_word)
address1_words2 <- address1_words[nchar(address1_words) >=2 ]
add1_table <- sort(table(address1_words2), decreasing = T)

pal3 <- brewer.pal(9, 'Blues')[5:9]
wordcloud( names(add1_table), freq = add1_table, scale = c(6, 0.7),
           min.freq = 2, random.order = F, rot.per = .1, colors = pal3)


#두번째 연설문
add2 <- readLines('ex_10-2.txt', encoding = 'UTF-8')
add2_word <- sapply(add2, extractNoun, USE.NAMES = F)
add2_words <- unlist(add2_word)
sort(table(add2_words), decreasing = T)

add_words <- c('댓글', '청탁', '김영란법' )
buildDictionary(user_dic = data.frame(add_words, rep('ncn', length(add_words))),
                replace_usr_dic = T)
get_dictionary('user_dic')
add2_word <- sapply(add2, extractNoun, USE.NAMES = F)
add2_words <- unlist(add2_word)
add2_words_trim <- add2_words[ nchar(add2_words) >= 2 ]
add2_table <- sort(table(add2_words_trim), decreasing = T)

wordcloud2(add2_table, fontFamily = '맑은고딕', size = 1.2,
           color = 'random-light', backgroundColor = 'black')

#세번째 연설문
add3 <- readLines('ex_10-3.txt', encoding = 'UTF-8')
add3_word <- sapply(add3, extractNoun, USE.NAMES = F)
add3_words <- unlist(add3_word)

add_words <- c('국민의당', '비례대표',  '민주주의', '사드',
               '전기요금', '한전', '사법개혁')
buildDictionary(user_dic = data.frame(add_words, rep('ncn', length(add_words))),
                replace_usr_dic = T)
get_dictionary('user_dic')

add3_w <- sapply(add3, extractNoun, USE.NAMES = F)
add3_ws <- unlist(add3_w)

add3_ws <- gsub('때문', '', add3_ws)
add3_ws <- gsub('하지', '', add3_ws)
add3_ws <- gsub('하면', '', add3_ws)
add3_ws <- gsub('하자', '', add3_ws)
add3_ws <- gsub('해서', '', add3_ws)

add3_ws <- add3_ws[ nchar(add3_ws) >= 2 ]
add3_tb <- sort(table(add3_ws), decreasing = T)

wordcloud2( add3_tb, minRotation = -pi/6, maxRotation = -pi/6,
            rotateRatio = 1 )


#문2)
#스티브 잡스의 스탠포드 대학 졸업식 연설문에 대해 워드클라우드를 작성하시오.
#Tip. 예제소스 파일은 ‘ex_10-4.txt’이다.

stvjobs_stanford <- readLines( 'ex_10-4.txt', encoding = 'UTF-8' )
stvjobs_stanford
stvjobs_word <- sapply( stvjobs_stanford, extractNoun, USE.NAMES = F )
undata <- unlist(stvjobs_word)
undata2 <- undata[ nchar(undata) >= 2 ]
sort(table(undata2), decreasing = T)
undata2 <- gsub( '하지', '', undata2 )
undata2 <- gsub( '때문', '', undata2 )
undata2 <- gsub( '들이', '', undata2 )
undata2 <- gsub( '가지', '', undata2 )
undata2 <- gsub( '개월', '', undata2 )
wordcount <- table( undata2 )
stvjobs_wordcount <- sort(wordcount, decreasing = T )[1:100]

wordcloud2( stvjobs_wordcount, fontFamily = '맑은고딕',
            size = 1.2, color = 'random-light',
            backgroundColor = 'black')

#문3) 
#오바마 대통령의 데통령 당선 연설문에 대해 워드클라우드를 작성하시오
#Tip. 예제소스 파일은 ‘ex_10-5.txt’이다.

obama <- readLines('ex_10-5.txt', encoding = 'UTF-8')
obama
obama_word <- sapply(obama, extractNoun, USE.NAMES = F)
obama_undata <- unlist(obama_word)
sort(table(obama_undata), decreasing = T)
obama_undata2 <- obama_undata[ nchar(obama_undata) >= 2 ]
sort(table(obama_undata2), decreasing = T)

add_words <- c('캠페인', '민주주의')
buildDictionary( user_dic = data.frame(add_words, rep('ncn', length(add_words))),
                 replace_usr_dic = T )
get_dictionary( 'user_dic' )

obama_undata2 <- gsub( '들이', '', obama_undata2 )
obama_undata2 <- gsub( '때문', '', obama_undata2 )
obama_undata2 <- gsub( '말하', '', obama_undata2 )
obama_undata2 <- gsub( '하지', '', obama_undata2 )

obama_table <- sort(table(obama_undata2), decreasing = T)

wordcloud2( obama_table, minRotation = -pi/6, maxRotation = -pi/6,
            rotateRatio = 1 )
