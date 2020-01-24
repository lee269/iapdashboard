## code to prepare `ffd_indicators` dataset goes here
# Need to have a better write up of making the indicator data here
ffd_indicators <- readRDS(here::here("data", "db", "ffd_indicators.rds")) %>% dplyr::ungroup()

usethis::use_data(ffd_indicators)
