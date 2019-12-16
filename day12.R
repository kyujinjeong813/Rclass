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

# 8. word cloud 작성 후 분석
wordcloud2( word_table2 )

# 8.1 배경 및 색상 변경
wordcloud2( word_table2, color = 'random-light',
            backgroundColor = 'black' )

# 8.2 모양 변경
wordcloud2( word_table2, fontFamily = '맑은고딕',
            size = 1.2, color = 'random-light',
            backgroundColor = 'black',
            shape = 'star')

# 8.3 선택 색상 반복
wordcloud2( word_table2, size = 1.6,
            color = rep_len(c('red','blue'), nrow(word_table2)))

wordcloud2( demoFreq, size = 1.6, 
            color = rep_len(c('red', 'blue'), nrow(word_table2)))


# 8.4 일정 방향 정렬
wordcloud2( word_table2, minRotation = -pi/6, maxRotation = -pi/6,
            rotateRatio = 1 )
wordcloud2( demoFreq, minRotation = -pi/6, maxRotation = -pi/6,
            rotateRatio = 1 )


#
# Web Scraping : 웹사이트에 있는 정보를 추출하는 컴퓨팅 기술
#     웹 문서(사이트)는 통상 텍스트와 이미지가 혼합되어 있는 HTML 형식으로 구성
#     웹스크래핑은 비구조화된 웹문서 자료를 정형화된(구조화된) 형태로 변환하여 데이터베이스나 스프레드시트에 저장, 분석할 수 있도록 하는 것
#
# 참고 : https://dr-hkim.github.io/Naver-News-Web-Scraping-using-Keywords-in-R/
#        http://datamining.dongguk.ac.kr/lectures/bigdata/_book/section-27.html            
#
# HTML (HyperText Markup Language)
#   팀 버너스리가 개발한 마크업 요소(tag)와 속성등을 이용하여 웹 페이지를 쉽게 작성할 수 있도록 하는 마크업 언어
# 
# <!DOCTYPE html>
# <html>
#     <body>
#       <p>This is a paragraph.</p>
#       <p>This is another paragraph.</p>
#     </body>
#  </html>
#
#
# XML(Extensible Markup Language)
#   XML은 서로 다른 유형의 데이터를 기술하는 마크업 언어
#   다른 종류의 시스템간 (특히 인터넷에 연결된 시스템)끼리 데이터를 쉽게 주고 받을 수 있도록 고안
#   HTML의 한계에 대한 대안
#
# <note>
#   <to>Tove</to>
#   <from>Jani</from>
#   <heading>Reminder</heading>
#   <body>Don't forget me this weekend!</body>
# </note>
#
#
# 웹 문서 가져오기
#
# 웹 크롤러(web crawler): 조직적, 자동화된 방법으로 웹을 탐색하는 컴퓨터 프로그램
# 웹 크롤링(web crawling): 웹 크롤러가 하는 작업
#
# R 에서 웹문서 가져오기
#
# 웹에 있는 데이터를 가져오는 단계
#     요청: GET과 POST 방식
#     추출 및 저장
# 관련 R 패키지
#   XML, RCurl, httr, rvest, …
#
# 
install.packages( "rvest" )

## 네이버 뉴스에서 원하는 키워드의 검색 결과를 웹크롤링(스크래핑)하는 코드
## 제작: hkim (dr-hkim.github.io)

## 패키지 불러오기
library(rvest)
library(dplyr)

## 변수 입력하기
QUERY <- "제주" # 검색키워드
DATE  <- as.Date( as.character( 20191210 ), format = "%Y%m%d" ) # 검색시작날짜 & 검색종료날짜
DATE  <- format( DATE, "%Y.%m.%d" )
PAGE  <- 1

naver_url_1 <- "https://search.naver.com/search.naver?&where=news&query="
naver_url_2 <- "&pd=3&ds="
naver_url_3 <- "&de="
naver_url_4 <- "&start="

## 날짜 리스트 만들기
DATE_START <- as.Date( as.character( 20191210 ), format = "%Y%m%d" ) # 시작일자
DATE_END   <- as.Date( as.character( 20191210 ), format = "%Y%m%d" ) # 종료일자
DATE <- DATE_START:DATE_END
DATE <- as.Date( DATE, origin = "1970-01-01" )

## 게시물 번호 리스트 만들기
PAGE <- seq( from = 1, to = 41, by = 10 ) # 시작값과 종료값을 지정해줄 수 있습니다.
PAGE <- seq( from = 1, by = 10, length.out = 5) # 시작값과 원하는 갯수를 지정할 수도 있습니다.

## 네이버 검색결과 url 리스트에서 관련기사 url 리스트 만들기
news_url <- c()
news_date <-c() 

for ( date_i in DATE ){
  for ( page_i in PAGE ){
    dt <- format( as.Date( date_i, origin = "1970-01-01" ), "%Y.%m.%d" )
    naver_url <- paste0( naver_url_1, QUERY, naver_url_2, dt, naver_url_3, dt, naver_url_4, page_i )
    html <- read_html( naver_url )
    temp <- unique( html_nodes( html, '#main_pack' ) %>%     # id= 는 # 을 붙인다
                      html_nodes( css = '.news ' ) %>%         # class= 는 css= 를 붙인다 
                      html_nodes( css = '.type01' ) %>%
                      html_nodes( 'a' )%>%
                      html_attr( 'href' ) )
    news_url <- c( news_url, temp )
    news_date <- c( news_date, rep( dt, length( temp ) ) )
  }
  print( dt ) # 진행상황을 알기 위함이니 속도가 느려지면 제외
}

NEWS0 <- as.data.frame( cbind( date = news_date, url = news_url, query = QUERY))
NEWS1 <- NEWS0[ which( grepl( "news.naver.com", NEWS0$url ) ), ]         # 네이버뉴스(news.naver.com)만 대상으로 한다   
NEWS1 <- NEWS1[ which( !grepl( "sports.news.naver.com", NEWS1$url ) ), ] # 스포츠뉴스(sports.news.naver.com)는 제외한다  
NEWS2 <- NEWS1[ !duplicated( NEWS1 ), ] # 중복된 링크 제거 


## 뉴스 페이지에 있는 기사의 제목과 본문을 크롤링
NEWS2$news_title   <- ""
NEWS2$news_content <- ""

for ( i in 1:dim( NEWS2 )[ 1 ] ){
  html <- read_html( as.character( NEWS2$url[ i ] ) )
  temp_news_title   <- repair_encoding( html_text( html_nodes( html, '#articleTitle' ) ), from = 'utf-8' )
  temp_news_content <- repair_encoding( html_text( html_nodes( html, '#articleBodyContents') ), from = 'utf-8' )
  if ( length( temp_news_title ) > 0 ) {
    NEWS2$news_title[ i ]   <- temp_news_title
    NEWS2$news_content[i] <- temp_news_content
  }
}

NEWS2$news_content <- gsub( "// flash 오류를 우회하기 위한 함수 추가\nfunction _flash_removeCallback()", "", NEWS2$news_content )
NEWS <- NEWS2 # 최종 결과 저장
NEWS
NEWS$news_content

# 워드클라우드
library( KoNLP )
useSejongDic()

word_data <- sapply( NEWS$news_content, extractNoun, USE.NAMES = F )
word_data

undata <- unlist( word_data )
undata

word_table <- table( undata )
word_table

undata2 <- undata[ nchar( undata ) >= 2 ]
undata2
word_table2 <- table( undata2 )
word_table2

sort( word_table2, decreasing = T )

library( wordcloud2 )

wordcloud2( word_table2, minRotation = -pi / 6, maxRotation = -pi / 6, rotateRatio = 1 )