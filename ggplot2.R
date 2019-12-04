\#데이터 시각화
#ggplot2를 이용

#install.packages("ggplot2")
library(ggplot2)

ggplot(diamonds, aes(cut)) + geom_bar()

ggplot(sleep, aes(ID, extra)) + geom_bar(stat='identity')

ggplot(sleep, aes(ID, extra, fill=group)) + geom_bar(stat="identity")

#응용으용
head(diamonds)
ggplot(diamonds, aes(color, cut, fill=clarity)) + geom_bar(stat="identity")

ggplot(sleep, aes(ID, extra, fill=group)) + geom_bar(stat="identity", position='dodge')

ggplot(diamonds, aes(color, fill=cut)) + geom_bar(position="fill")

ggplot(sleep, aes(ID, extra, fill=group)) + geom_bar(stat="identity") + coord_flip()

ggplot(sleep, aes(ID, extra, fill=group)) + geom_bar(stat="identity", position = "dodge") + coord_flip()

#color 와 fill
library(dplyr)
library(ggplot2)

head(Orange)
Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference)) + geom_bar(stat="identity")

# geom 함수에 적용하여 색상 나타내기 / 데이터를 기반으로 aes 함수에 적용
# fill : 도형에 색을 채워줄 때
# color : 선에 색을 채워줄 때

Orange %>%
  group_by(Tree)%>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference)) + geom_bar(stat="identity", fill="red")

Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference)) + geom_bar(stat="identity", color="red", fill="white") +
  theme_bw()

Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference)) + geom_line(group=1, color='red')+ theme_bw()

Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference)) + geom_point(size=6, color='red') + theme_bw()

Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference)) + geom_point(shape=2, size=6, color='red') + theme_bw()

# point shape : -8 ~ 19 (color) 20 ~ 29 (color, fill) 

#데이터를 기반으로 aes함수에 적용하기
#line
library(dplyr)
library(ggplot2)

ggplot(Orange, aes(x=age, y=circumference, color=Tree)) + geom_line(size=1)

ggplot(Orange, aes(x=age, y=circumference, fill=Tree)) + geom_bar(stat="identity")

ggplot(Orange, aes(x=age, y=circumference, color=Tree)) + geom_point()

#좌표계 설정하기
head(faithful)

ggplot(faithful, aes(waiting, eruptions)) + geom_point() +
  coord_cartesian(xlim=c(60,80), ylim=c(2:4))

ggplot(faithful, aes(waiting, eruptions)) + geom_point() +
  coord_cartesian(xlim=c(40,120), ylim=c(1,5))

ggplot(faithful, aes(waiting, eruptions)) + geom_point() +
  coord_cartesian(xlim = c(min(faithful$waiting)-5, max(faithful$waiting) + 5 ))

library(ggplot2)

ggplot(faithful, aes(waiting, eruptions)) + geom_point() +
  coord_cartesian(expand = FALSE)

ggplot(faithful, aes(waiting, eruptions)) + geom_point() +
  coord_cartesian(expand = TRUE)

# coord_cartesian 은 출력되는 좌표계의 범위를 지정하는 것을 의미 (좌표평면 확대)
ggplot(faithful, aes(waiting, eruptions)) +
  geom_bin2d() +
  coord_cartesian(xlim = c(60, 80)) +
  geom_smooth(method=lm)

# scale_x_continuous 에서 limit/xlim 사용하면 지정 범위 밖에 있는 데이터를 관측에서 제외
ggplot(faithful, aes(waiting, eruptions)) +
  geom_bin2d() + 
  scale_x_continuous(limits = c(60, 80)) +
  geom_smooth(method = lm)

# 컬러 지정(fill)
Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference)) +
  geom_bar(stat="identity", fill='#CC3399')

# 각각의 바에 컬러 지정 **fill/color 함수 꼭 지정해줘야 함
p <- Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference, fill=Tree)) +
  geom_bar(stat="identity")

p + scale_fill_manual(values = c("#FFFFFF", "#FFCC00", "#FF9900", "#FF6600", "#FF3300"))

# 컬러 팔레트 차트
p <- Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference, fill=Tree)) +
  geom_bar(stat="identity")

p + scale_fill_brewer(palette="Greens")

p <- Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference=sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference, fill=Tree)) +
  geom_bar(stat="identity")
p + scale_fill_brewer(palette = "Pastel1")

#line 그래프는 scale_color_brewer

head(economics)

# hline / vline / abline

ggplot(economics, aes(pop, psavert)) + geom_point() +
  geom_hline(yintercept = 8, linetype='dashed', color='red', size=1)

ggplot(economics, aes(pop, psavert)) + geom_point() +
  geom_vline(xintercept = 280000, linetype='dotted', color='red', size=2)

#절편과 기울기를 설정하여 라인 그리기 (geom_abline)
ggplot(economics, aes(pop, psavert)) +geom_point() +
  geom_abline(intercept = 27.9, slope=-0.00007447, color='blue', size=1.5)

#두 점을 연결하는 선 그리기 (geom_segment)
ggplot(economics, aes(pop, psavert)) +geom_point() +
  geom_segment(aes(x=200000, y=14, xend=320000, yend=3), color='blue', size=1.5)

#화살표 그리기
library(scales)
basic <- ggplot(sleep, aes(ID, extra)) + geom_line(size=1) +
  theme_bw() + geom_text(aes(label=extra)) +
  scale_y_continuous(breaks=-1.6:5.5)
basic

basic + geom_segment(aes(x=5, y=3, xend=5, yend=0.4),
                     arrow=arrow(), color='orange', size=2)

basic + geom_segment(aes(x=5, y=3, xend=4, yend=0.4),
                     arrow=arrow(ends='last'), color='orange', size=2)

basic + geom_segment(aes(x=5, y=3, xend=5, yend=0.4),
                     arrow=arrow(angle=60),
                     color='orange', size=2)

basic + geom_segment(aes(x=5, y=3, xend=5, yend=0.4),
                     arrow=arrow(length = unit(1.2, 'cm')),
                     color='orange', size=2)
basic + geom_segment(aes(x=5, y=3, xend=5, yend=0.4),
                     arrow=arrow(length=unit(1.2,'inch')),
                     color='orange', size=2)

basic + geom_segment(aes(x=5, y=3, xend=5, yend=0.4),
                     arrow=arrow(type='closed'),
                     color='orange', size=2)

basic + geom_segment(aes(x=5, y=3, xend=5, yend=0.4),
                     arrow=arrow(ends='both'),
                     color='orange', size=2)

#jitter
ggplot(midwest, aes(state, percollege)) +
  geom_point()
# 위에꺼가 점이 다 겹쳐서 알아보기 힘들기 때문에 jitter가 등장한거
ggplot(midwest, aes(state, percollege)) +
  geom_jitter()

#점이 뿌려지는 높이 조절
dia <- diamonds[sample(1:length(diamonds$carat), 1000),]
dia

ggplot(dia, aes(cut, color)) +
  geom_jitter()

ggplot(dia, aes(cut, color)) +
  geom_jitter(height=0.2)

#너비 조정
ggplot(midwest, aes(state, percollege)) +
  geom_jitter(width=0.2)

set.seed(2) # 같은 그래프가가 나오도록 하려면
ggplot(midwest, aes(state, percollege)) +
  geom_jitter()

#컬러컬러 (조건식 사용하는 게 신기하고만)
ggplot(midwest, aes(state, percollege)) +
  geom_jitter(data=midwest, aes(color=inmetro==1, shape=percprof>mean(percprof)))

#boxplot
ggplot(data=airquality, aes(x=1, y=Temp)) +
  geom_boxplot()

ggplot(data=airquality, aes(x=Month, y=Temp, group=Month)) + 
  geom_boxplot()

ggplot(data=airquality, aes(x=Month, y=Temp, group=Month)) +
  geom_boxplot(fill='slategrey', color='darkslategrey', width=0.6)

ggplot(data=airquality, aes(x=Month, y=Temp, group=Month)) +
  geom_boxplot(outlier.color = 'red', outlier.shape = 2)

ggplot(data=airquality, aes(x=Month, y=Temp, group=Month)) +
  geom_boxplot(outlier.shape = NA)

ggplot(data=airquality, aes(x=Month, y=Temp, group=Month)) +
  geom_boxplot() +
  stat_summary(fun.y="mean", geom="point", shape=22, size=3, fill="blue")


library(help='graphics')

library(ggplot2)

ggplot(economics, aes(date, uempmed)) +
  geom_ribbon(aes(ymax=uempmed*(1+0.5), ymin=uempmed*(1-0.5)),
              fill="slategray4") +
  geom_line(color="orangered")

ggplot(economics, aes(date, uempmed)) +
  geom_ribbon(aes(ymax=uempmed+10, ymin=uempmed-1), fill="slategray4") +
  geom_line(color="orangered")

ggplot(economics, aes(date, uempmed)) +
  geom_ribbon(aes(ymax=uempmed, ymin=8), fill="slategray4") +
  geom_line(color="orangered")


