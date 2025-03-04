
Top5dfUrls<- read.csv("Top5PlayerUrls.csv")
Top5dfUrls<-purrr::discard(Top5dfUrls, ~all(is.na(.)))
