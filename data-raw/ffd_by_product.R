library(dplyr)

ffd_trade <- iapdashboardadmin::ffd_trade

ffd_by_product <- ffd_trade %>% 
                    dplyr::filter(partner_iso !="WLD") %>% 
                    dplyr::group_by(year, reporter_iso, reporter, commodity_code, commodity) %>% 
                    dplyr::summarise(trade_val = sum(trade_value_us),
                                     trade_vol = sum(net_weight_kg))


usethis::use_data(ffd_by_product)
