library(rvest)
library(xml2)
library(tibble)
library(dplyr)

website <- xml2::read_html("https://www.nationsonline.org/oneworld/country_code_list.htm")

country_codes  <-  website %>% 
                    rvest::html_nodes("table") %>% 
                    rvest::html_table() %>% 
                    .[[1]] %>% 
                    tibble::as_tibble()

colnames(country_codes) <- c("flag", "country", "country_iso2", "country_iso3", "country_un") 

country_codes <- country_codes %>% 
                  dplyr::select(-flag) %>% 
                  dplyr::mutate(country_un = as.numeric(country_un)) %>% 
                  na.omit()

usethis::use_data(country_codes)
