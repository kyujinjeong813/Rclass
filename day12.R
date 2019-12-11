#
# 워드 클라우드 
#
# 한글 워드클라우드 절차
# 1. Java 실행환경 구축
# 2. 자료 수집( Text 자료 )
#  2.1 text file 형태로 수집
#  2.2 web scraping을 이용하여 수집
# 3. 명사 추출

# 자바 실행환경 위치 결정
Sts.setenv( JAVA_HOME = 'C:/Program Files/Java/jre1.8.0_231' )

install.packages("wordcloud")        #word cloud
install.packages("wordcloud2")       #word cloud
install.packages("KoNLP")            #한국어 처리
install.packages("RColorBrewer")     #색상 선택

library(wordcloud)
library(wordcloud2)
library(KoNLP) #checking user defined dictionary(사전 설정에 따라 단어 수가 다름, 이따 다룸)
library(RColorBrewer)

library(dplyr)
library(ggplot2)

setwd('D:/Rclass')
text <- readLines( 'mis_document.txt', encoding = 'UTF-8' )
text
# 팁 ) 텍스트파일의 맨 아랫줄에는 공백줄이 있어야 오류가 덜 난다
#      만들때 항상 마지막 빈 줄을 추가해라

# '우리말씀' 한글사전 로딩
buildDictionary( ext_dic = 'woorimalsam' )
pal2 <- brewer.pal( 8, 'Dark2' ) # 색상 팔레트 생성
noun <- sapply( text, extractNoun, USE.NAMES = F ) #명사 추출
noun

# 추출된 단어 ( 주로 명사 )에 대한 빈도수 계산 및 시각화
noun2 <- unlist( noun ) # list -> vector로 변환
wordcount <- table( noun2 )
sort.noun <- sort( wordcount, decreasing = T )[ 1:10 ]
sort.noun
sort.noun <- sort.noun[ -1 ]
barplot( sort.noun, names.arg = names( sort.noun ),
         col = 'steelblue', main = '빈도수 높은 단어',
         ylab = '단어 빈도수' )

df <- as.data.frame( sort.noun )
df
ggplot( df, aes( x = df$noun2, y = df$Freq) ) +
  geom_bar( stat = 'identity', width = 0.7, fill = 'steelblue' ) +
  ggtitle( '빈도수 높은 단어' ) +
  theme( plot.title = element_text( size = 25, face = 'bold', colour = 'steelblue',
                                    hjust = 0, vjust = 1 ) ) +
  labs( x = '명사', y = '단어빈도수' ) +
  geom_text( aes( label = df$Freq ), hjust = -0.3 ) +
  coord_flip()

# 5. word cloud 작성
# 인수 순서대로 단어 / 단어빈도 / 단어 폰트 크기 (최대, 최소)
# 단어최소빈도 / 단어출력위치 / 90도 회전단어 비율 / 단어 색
pal3 <- brewer.pal( 9, 'Blues' )[5:9]
wordcloud( names( wordcount ), freq = wordcount, scale = c( 4, 0.7),
           min.freq = 3, random.order = F, rot.per = .1, colors = pal3 )

# 처리 과정을 거치지 않았더니 불필요한 단어가 포함 / 본문에 있으나 제거된 것들도 존재

# 6. 전처리 과정 수행 (아주 일부만 설명한 고)
#    6.1 불필요한 단어 삭제
#    6.2 생략된 단어를 사전에 등재

# 생략된 단어를 사전에 등재 (ncn은 명사를 뜻하는 품사 코드)
buildDictionary( ext_dic = 'woorimalsam', user_dic = data.frame( '정치', 'ncn' ),
                 replace_user_dic = T )

noun <- sapply( text, extractNoun, USE.NAMES = F )
noun2 <- unlist( noun )
noun2

# 불필요한 단어 삭제
noun2 <- noun2[ nchar( noun2 ) > 1 ]
noun2 <- gsub( '하지', '', noun2 )
noun2 <- gsub( '때문', '', noun2 )
wordcount <- table( noun2 )
# 최종적인 명사 집합 생성

# 7. word cloud 작성
wordcloud( names( wordcount ), freq = wordcount, scale = c(4, 0.7),
           min.freq = 3, random.order = F, rot.per = .1, colors = pal3 )


#
# 애국가 형태소 분석
#
library( KoNLP )
useSystemDic()
useSystemdic()
useNIADic()

#
# 애국가 가사 다운받기
# 
# 1. 사전 설정
useSejongDic()

# 2. 텍스트 데이터 가져오기
word_data <- readLines('애국가(가사).txt')
word_data

# 3. 명사 추출
word_data2 <- sapply( word_data, extractNoun, USE.NAMES = F )
word_data2

# 3.1 제대로 추출되지 않은 단어를 사용자 사전에 등록
add_words <- c('백두산', '남산', '철갑', '가을', '하늘', '달', '삼천리')
buildDictionary( user_dic = data.frame(add_words, rep('ncn', length(add_words))),
                 replace_usr_dic = T )
get_dictionary( 'user_dic' )

# 3.2 단어 추가 후 다시 명사 추출
word_data3 <- sapply( word_data, extractNoun, USE.NAMES = F )
word_data3

# 4. 행렬을 벡터로 변환
undata <- unlist( word_data3 )
undata

# 5. 사용 빈도 확인
word_table <- table( undata )
word_table


# 6. 필터링 : 두 글자 이상 단어만 선별, 공백이나 한 자리 문자를 걸러냄
undata2 <- undata[ nchar( undata ) >= 2 ]
undata2
word_table2 <- table( undata2 )
word_table2

# 7. 데이터 정렬
sort( word_table2, decreasing = T )

# 애국가 형태 분석 완료
# 가장 기본적인 전처리만 수행

wordcloud( names( wordcount ), freq = wordcount, scale = c(5, 0.7),
           min.freq = 1, random.order = F, rot.per = .1, colors = pal3 )









