#' Standardise logical variables
#'
#' @param x a vector of two different types of entries (can be of type factor, integer, logical, or character).
#' @param output a switch to set the desired output format. Defaults to "logical", but can be "character", "binary" or "factor".  
#' @param categories output target categories for binary/logical traits harmonization if `output` is not set to 'logical'.
#'
#' @return A vector of harmonized logical values.
#' @export
#'
#' @examples
#'
#' a <- factor(sample(c("ja", "nein"), 10, replace = TRUE))
#' b <- sample(0:1, 20, replace = TRUE)
#' d <- sample(c("Y", "N"), 13, replace = TRUE)
#' d[c(3,7)] <- NA
#' e <- sample(c(TRUE, FALSE), 18, replace = TRUE)
#'
#' fixlogical(c(e,d))
#'

fixlogical <- function(x, output = "logical", categories = c("No", "Yes")) {

  x <- factor(tolower(x))

  # ToDo: add test or fuzzy matching algorithm

  levels(x) <- list('0'=c("0", "no", "n", "nein", "false", "non"),
                    '1'=c("1", "yes", "y", "ja",  "j", "true", "oui", "si"))

  levels(x) <- categories

  x <- switch(output,
              factor = x,
              character = as.character(x),
              binary = as.numeric(x)-1,
              logical = as.logical(as.numeric(x)-1)
  )
  return(x)
}
