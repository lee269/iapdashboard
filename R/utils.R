#' RAG status
#' 
#' 
#'
#' @param n 
#'
#' @return
#' @export
#'
#' @examples
rag <- function(n) {
  
  file <- dplyr::case_when(n == 4 ~ "green",
                           n == 3 ~ "amber",
                           n == 2 ~ "amber",
                           n == 1 ~ "red")
  
  link <- paste0("<img src = 'www/", file, ".png' >")
  return(link)
}
