library(tidyverse)
arable <- read_csv(here::here("resources/2025-07-09-selective-breeding/data/data-raw/FAOSTAT_data_en_7-6-2025-arable-land.csv")) |> 
  janitor::clean_names() |> 
  janitor::remove_constant() |> 
  select(year, arable = value)

crop <- read_csv(here::here("resources/2025-07-09-selective-breeding/data/data-raw/FAOSTAT_data_en_7-6-2025-crop.csv")) |> 
  janitor::clean_names() |> 
  janitor::remove_constant() |> 
  pivot_wider(id_cols = c(year, item), names_from = element, values_from = value) |> 
  janitor::clean_names()

pop <- read_csv(here::here("resources/2025-07-09-selective-breeding/data/data-raw/FAOSTAT_data_en_7-6-2025-population.csv")) |> 
  janitor::clean_names() |> 
  janitor::remove_constant() |> 
  select(year, pop = value)

fao <- crop |> 
  left_join(arable, by = "year") |> 
  left_join(pop, by = "year") |> 
  filter(item %in% c("Barley", "Wheat", "Oats", "Sorghum", "Maize (corn)", "Triticale", "Millet", "Rye", "Canary seed", "Lupins", "Peas, green", "Chick peas, dry", "Vetches", "Soya beans", "Cow peas, dry", "Lentils, dry", "Sunflower seed", "Safflower seed", "Linseed")) 

saveRDS(fao, file = here::here("resources/2025-07-09-selective-breeding/data/data-input/fao.rds"))
