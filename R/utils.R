#' @export

is_unit <- function(x) { 
  !c("simpleError") %in% class(tryCatch(as_units(x), error  = function(e) e))
}
