## code to prepare `wb_indicators` dataset goes here

wb_indicators <- readRDS(here::here("data", "db", "wb_indicators.rds")) %>% dplyr::ungroup()

usethis::use_data(wb_indicators)
