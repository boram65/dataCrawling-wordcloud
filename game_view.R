install.packages(c("cli","hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex", "lazyeval", "htmlwidgets", "crosstalk", "promises", "later", "sessioninfo", "xopen", "bit64", "blob", "DBI", "memoise", "plogr", "covr", "DT", "rcmdcheck", "rversions"), type = "binary")
install.packages("remotes")
install.packages("wordcloud")
install.packages("RColorBrewer")
setwd("/Users/choidowon/Desktop/iot1500")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))


library(KoNLP)
library(wordcloud)
library(RColorBrewer)
library(stringr)

data1 <- readLines("지식인_game.txt")
data1
#data2 <- sapply(data1,extractNoun, USE.NAMES = F)
#data2
data3 <- unlist(data1)
data3
game_gsub <- str_replace_all(data3,"[^[:alpha:]]","")
#gsub("\\d+","",game_gsub)   숫자제거인데 안함
data3
gsub("\\.","",game_gsub)
#game_gsub <- gsub(" ","",game_gsub)
game_gsub <- gsub("내공","",game_gsub)
game_gsub <- gsub("게임","",game_gsub)
game_gsub <- gsub("사사이","",game_gsub)
game_gsub <- gsub("모바일","",game_gsub)

game_gsub <- Filter(function(x) {nchar(x) >= 2} , game_gsub)
game_gsub

write(unlist(game_gsub), "game.txt")
data4 <- read.table("game.txt")

wordcount <- table(data4)
head(sort(wordcount, decreasing=T),100)
palete <- brewer.pal(9,"Set3")
wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per=0.25,min.freq=1,random.order=F,random.color=T,colors=palete, family="AppleGothic")

#데이터 시각화

top10 <- head(sort(wordcount, decreasing=T),10)
pie(top10,main="게임관심태그 TOP 10")
pie(top10,col=rainbow(10),radius=1,main="게임심태그 TOP 10",family="AppleGothic")

pct <- round(top10/sum(top10) * 100 ,1)
names(top10)

lab <- paste(names(top10),"\n",pct,"%")
pie(top10,main="게임관심태그 TOP 10",col=rainbow(10), cex=0.8,labels = lab,family="AppleGothic")

bchart <- head(sort(wordcount, decreasing=T),10)
bchart
bp <- barplot(bchart, main ="게임관심태그 TOP 10", col = rainbow(10), cex.names=0.7, las = 2 , ylim = c(0,130), family="AppleGothic")
