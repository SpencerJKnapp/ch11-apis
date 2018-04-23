# Exercise 2: working with data APIs

# load relevant libraries
library(httr)
library(jsonlite)

# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source("apikey.R")

# Create a variable `movie.name` that is the name of a movie of your choice.
movie_name <- "anchorman"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
base_uri <- "https://api.nytimes.com/svc/movies/v2/"
resource <- "reviews/search.json"
full_uri <- paste0(base_uri, resource)

# You should use YOUR api key (as the `api-key` parameter)
# and your `movie.name` variable as the search query!
parameters <- list("api-key" = nyt_apikey, "query" = movie_name)
response <- GET(full_uri, query = parameters)

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
response_text <- content(response, "text")
converted_text <- fromJSON(response_text)

# What kind of data structure did this produce? A data frame? A list?
class(converted_text)
is.data.frame(converted_text)
is.list(converted_text)

converted_text_df <- data.frame(converted_text, stringsAsFactors = F)
# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
names(converted_text)
names(converted_text$results)

# Flatten the movie reviews content into a data structure called `reviews`
reviews <- flatten(converted_text$results)

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
review_1 <- reviews[1, ]
headline <- review_1$headline
summary <- review_1$summary_short
link <- review_1$link.url

# Create a list of the three pieces of information from above. 
# Print out the list.
review_a <- list(headline = headline, summary = summary, link = link)
