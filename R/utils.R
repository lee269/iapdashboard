#' RAG status
#' 
#' 
#'
#' @param n an integer
#'
#' @return html link to RAG image
#' @export
#'
#' @keywords internal
rag <- function(n) {
  
  file <- dplyr::case_when(n == 4 ~ "green",
                           n == 3 ~ "amber",
                           n == 2 ~ "amber",
                           n == 1 ~ "red")
  
  link <- paste0("<img src = 'www/", file, ".png' >")
  return(link)
}




#' Format numbers
#'
#' @param x 
#' @param format 
#'
#' @return
#' @export
#'
#' @keywords internal
format_number <- function(x, format){
  
  switch(format,
         dollar = paste0("$", formatC(x, digits = 0, big.mark = ",", format = "f")),
         percent = paste0(formatC(x, digits = 1, big.mark = ",", format = "f"), "%"),
         integer = formatC(x, digits = 0, big.mark = ",", format = "f")
  )
  
}
