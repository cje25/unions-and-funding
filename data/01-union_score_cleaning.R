library(dplyr)
library(here)
library(tidyverse)


# importing the union score data for the house candidates:
house_scores_df <- read.csv(here("data", "AFL-CIO-Scorecard-2022-House.csv"), 
                            encoding = "latin1")
house_scores_df <- mutate(house_scores_df, chamber = "House") |>
                      mutate(Name = sub('Rep. ', '', Name))

# importing the union score data for the senate candidates:
senate_scores_df <- read.csv(here("data", "AFL-CIO-Scorecard-2022-Senate.csv"),
                             encoding = "latin1")
senate_scores_df <- mutate(senate_scores_df, chamber = "Senate") |>
                      mutate(Name = sub('Sen. ', '', Name))

union_scores_df <- bind_rows(house_scores_df, senate_scores_df)

union_scores_df <- union_scores_df |> 
                      select("Name", 
                             "State", 
                             "District", 
                             "Party", 
                             "Score", 
                             "Lifetime.Score", 
                             "chamber") |>
                      rename(
                        name = Name,
                        state = State,
                        district = District,
                        party = Party,
                        score = Score,
                        lifetime_score = "Lifetime.Score"
                      ) |>
                      mutate(score = as.numeric(gsub('%', '', score)),
                             lifetime_score = as.numeric(gsub('%', '', lifetime_score)))

union_scores_df

other_par <- 'ID'
test_par <- c('Republican', 'Democrat')

independent_candidates <- union_scores_df |> filter(union_scores_df$party %in% other_par)




write.csv(union_scores_df, "cleaned_union_scores.csv", row.names=FALSE)

# To do:
  # change the score values into integers -- done!
  # recode the party and chamber values as factors
  # associate this data with the incumbents list
  # make a new df with just the incumbents info