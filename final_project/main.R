library(proxy)
library(recommenderlab)
library(reshape2)
movies <- read.csv("https://raw.githubusercontent.com/josephsimone/Data-612/master/final_project/movies.csv", header = TRUE, stringsAsFactors=FALSE)
ratings <- read.csv("https://raw.githubusercontent.com/josephsimone/Data-612/master/final_project/ratings.csv", header = TRUE)
movie2 <- movies[-which((movies$movieId %in% ratings$movieId) == FALSE),]

## Recommendation
movie_recommendation <- function(input,input2,input3) {
  num_row <- which(movie2[,2] == input)
  num_row2 <- which(movie2[,2] == input2)
  num_row3 <- which(movie2[,2] == input3)
  select_user <- matrix(NA,10325)
  select_user[num_row] <- 5 
  select_user[num_row2] <- 4 
  select_user[num_row3] <- 3 
  select_user <- t(select_user)
  
  matrix_rating <- dcast(ratings, userId~movieId, value.var = "rating", na.rm=FALSE)
  matrix_rating <- matrix_rating[,-1]
  colnames(select_user) <- colnames(matrix_rating)
  matrix_rating2 <- rbind(select_user,matrix_rating)
  matrix_rating2 <- as.matrix(matrix_rating2)
  
  #Rating Matrix to  Sparse Matrix
  matrix_rating2 <- as(matrix_rating2, "realRatingMatrix")
  
  
  #Create Recommender Model. "UBCF" stands for user-based collaborative filtering
  recommender_model <- Recommender(matrix_rating2, method = "UBCF",param=list(method="Cosine",nn=30))
  movie_recommendation <- predict(recommender_model, matrix_rating2[1], n=10)
  movie_recommendation_list <- as(movie_recommendation, "list")
  no_result <- data.frame(matrix(NA,1))
  movie_recommendation_result <- data.frame(matrix(NA,10))
  
  
  if (as.character(movie_recommendation_list[1])=='character(0)'){
    no_result[1,1] <- "Please be patient will us, there seems to not enough information from the movies you've selected. Sorry, please try and  select different movies you enjoy."
    colnames(no_result) <- "No Results Found"
    return(no_result) 
  } else {
    for (i in c(1:10)){
      movie_recommendation_result[i,1] <- as.character(subset(movies, 
                                               movies$movieId == as.integer(movie_recommendation_list[[1]][i]))$title)
    }
  colnames(movie_recommendation_result) <- "User Based Collaborative Filtering Recommended Movies"
  return(movie_recommendation_result)
  }
}