library(dplyr)

ffd_trade <- iapdashboardadmin::ffd_trade

ffd_by_country <- ffd_trade %>% 
                    dplyr::filter(partner_iso !="WLD") %>% 
                    dplyr::group_by(year, reporter_iso, reporter, partner_iso, partner) %>% 
                    dplyr::summarise(trade_val = sum(trade_value_us),
                                     trade_vol = sum(net_weight_kg)) %>% 
                    dplyr::ungroup()


usethis::use_data(ffd_by_country, overwrite = TRUE)
