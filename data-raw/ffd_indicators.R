## code to prepare `ffd_indicators` dataset goes here
# Need to have a better write up of making the indicator data here
library(dplyr)
library(tidyr)

ffd_trade <- iapdashboardadmin::ffd_trade

all_data <- ffd_trade %>% 
  group_by(reporter_code, reporter_iso, reporter) %>% 
  summarise(n = n()) %>% 
  select(-n)

# Total food imports and market size rating by year
total_food_imports <- ffd_trade %>% 
  filter(partner_iso != "WLD") %>% 
  group_by(reporter, year) %>% 
  summarise(total_food_imports_value = sum(trade_value_us)) %>% 
  group_by(year) %>% 
  mutate(total_food_imports_rating = ntile(total_food_imports_value, 4)) %>% 
  arrange(year, total_food_imports_value)


# Total UK food imports by year
uk_food_imports <- ffd_trade %>% 
  filter(partner_iso == "GBR") %>% 
  group_by(reporter, year) %>% 
  summarise(uk_food_imports = sum(trade_value_us)) 


uk_market_share <- ffd_trade %>% 
  filter(partner_iso %in% c("WLD", "GBR")) %>% 
  select(year, reporter, partner_iso, commodity, commodity_code, trade_value_us) %>%
  group_by(year, reporter, partner_iso) %>% 
  summarise(trade_value_us = sum(trade_value_us)) %>% 
  pivot_wider(id_cols = c(year, reporter), names_from = partner_iso, values_from = trade_value_us) %>% 
  filter(GBR > 0) %>% 
  mutate(uk_market_share = (GBR/WLD)*100) %>% 
  arrange(reporter, year)

export_diversity <- ffd_trade %>%
  filter(partner_iso == "GBR") %>% 
  group_by(reporter, year, commodity_code) %>% 
  summarise(count = n()) %>% 
  group_by(reporter, year) %>% 
  summarise(uk_export_diversity = sum(count))

dominant_products <- ffd_trade %>%
  filter(partner_iso == "GBR") %>%
  select(year, reporter, commodity, commodity_code, trade_value_us) %>%
  group_by(year, reporter) %>% 
  mutate(uk_percentage = (trade_value_us/sum(trade_value_us)*100)) %>% 
  arrange(year, reporter, desc(uk_percentage)) %>% 
  slice(1)

ffd_indicators <- all_data %>% 
  left_join(total_food_imports) %>% 
  left_join(uk_food_imports) %>% 
  left_join(uk_market_share) %>% 
  left_join(dominant_products) %>% 
  ungroup()

usethis::use_data(ffd_indicators, overwrite = TRUE)
