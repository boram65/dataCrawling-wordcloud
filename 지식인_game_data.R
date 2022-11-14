setwd("/Users/choidowon/Desktop/iot1500")
install.packages("rvest") #웹페이지 통째로 수집
install.packages("httr") #웹서버 접속
library(rvest)
library(httr)


url='https://kin.naver.com/qna/list.naver?dirId=2&queryTime=2022-10-24%2018%3A41%3A58&page='
allReview = c()

for(page in 1:100) {
  urls = paste(url,page,sep="")
  htxt = read_html(urls)
  comments = html_nodes(htxt,'td.field')
  reviews = html_text(comments)
  
  if(length(reviews) == 0) {
    break
  }
  allReview = c(allReview, reviews)
}

length(allReview)
allReview

write(allReview , "지식인_game.txt")
write.csv(allReview,"지식인_game.csv")
