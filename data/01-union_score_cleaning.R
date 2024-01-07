library(dplyr)
library(here)
library(tidyverse)


# importing the union score data for the house candidates:
house_scores_df <- read_csv(here("final_project/unions-and-funding/data", "AFL-CIO-Scorecard-2022-House.csv"))
house_scores_df <- mutate(house_scores_df, chamber = "House")

# importing the union score data for the senate candidates:
senate_scores_df <- read_csv(here("final_project/unions-and-funding/data", "AFL-CIO-Scorecard-2022-Senate.csv"))
senate_scores_df <- mutate(senate_scores_df, chamber = "Senate")

union_scores_df <- bind_rows(house_scores_df, senate_scores_df)

union_scores_df <- union_scores_df |> 
                      select("Name", 
                             "State", 
                             "District", 
                             "Party", 
                             "Score", 
                             "Lifetime Score", 
                             "chamber") |>
                      rename(
                        name = Name,
                        state = State,
                        district = District,
                        party = Party,
                        score = Score,
                        lifetime_score = "Lifetime Score"
                      )
union_scores_df

# To do:
  # change the score values into integers
  # recode the party and chamber values as factors
  # associate this data with the incumbents list
  # make a new df with just the incumbents info