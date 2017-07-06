#' Title
#'
#' @param x 
#' @param replace 
#' @param template 
#' @param ... 
#' 
#' @usage data(glossary)
#' @export
#'
mapping <- function(x, 
                    replace,
                    template = glossary,
                    ...
) {
  
  if(!"traitdata" %in% class(x)) as.traitdata(x, ...)
  
  # perform renaming following sequence
  if(length(replace) == length(colnames(x)) && is.null(names(replace))) colnames(x) <- replace
  
  # perform renaming following named vector
  if(!is.null(names(replace))) {x <- reshape::rename(x, replace)}
  
  checkagainst <- names(template)
  
  if(!all(replace %in% checkagainst)) warning("not all column names are corresponding to names expected by the template! Not corresponding: ... .")
  
  return(x)
}
