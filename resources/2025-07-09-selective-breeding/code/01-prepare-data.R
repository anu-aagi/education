library(tidyverse)

maize <- read_csv(here::here("resources/2025-07-09-selective-breeding/data/data-raw/maize-production.csv")) |> 
  janitor::clean_names() |> 
  rename(production = maize_00000056_production_005510_tonnes) |> 
  select(-entity)

saveRDS(maize, here::here("resources/2025-07-09-selective-breeding/data/data-input/maize.rds"))


pop <- read_csv(here::here("resources/2025-07-09-selective-breeding/data/data-raw/population-with-un-projections.csv")) |> 
  janitor::clean_names() |> 
  rename(pop = population_sex_all_age_all_variant_estimates, 
         pred = population_sex_all_age_all_variant_medium) |> 
  mutate(pop = ifelse(is.na(pop), pred, pop)) |> 
  mutate(forecast = !is.na(pred)) |> 
  select(year, pop, forecast)

saveRDS(pop, here::here("resources/2025-07-09-selective-breeding/data/data-input/pop.rds"))
