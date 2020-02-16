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


#' Table
#' 
#' Create shinyMobile table.
#' 
#' @param df Data.frame.
#' @param card Whether to use as card.
#' 
#' @keywords internal
as_f7_table <- function(df, card = FALSE){
  headers <- purrr::map(df, class2f7)
  colnames <- names(headers)
  
  headers <- purrr::map2(headers, colnames, function(x, y){
    tags$th(class = x, y)
  }) 
  
  df_list <- purrr::transpose(df)
  
  table <- purrr::map(df_list, function(row){
    r <- purrr::map(row, function(cell){
      tags$th(class = class2f7(cell), cell)
    })
    tags$tr(r)
  })
  
  cl <- "data-table"
  
  if(card)
    cl <- paste(cl, "card")
  
  div(
    class = cl,
    tags$table(
      tags$thead(
        tags$tr(headers)
      ),
      tags$tbody(table)
    )
  )
}

#' Get CSS class based on cell class
#' 
#' @param x Value.
#' 
#' @keywords internal
class2f7 <- function(x){
  if(inherits(x, "numeric"))
    return("numeric-cell")
  
  return("label-cell")
}