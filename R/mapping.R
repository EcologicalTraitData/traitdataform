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
                    glossary = glossary,
                    #glossary = read.csv(paste0("https://github.com/fdschneider/bexis_traits/raw/", version , "/", filename)), # to activate once repo is public
                    traitmap = NULL,
                    filename = "template_glossary.csv",
                    version = "master",
                    ...
) {
  
  

  if(!"traitdata" %in% class(x)) as.traitdata(x, ...)
  
  # perform renaming following sequence
  if(length(replace) == length(colnames(x)) && is.null(names(replace))) colnames(x) <- replace
  
  # perform renaming following named vector
  if(!is.null(names(replace))) {x <- reshape::rename(x, replace)}
  
  checkagainst <- glossary$columnName
  
  if(!all(names(x) %in% checkagainst)) warning("not all column names are corresponding to names expected by the glossary! Not corresponding: ... .")
  
  return(x)
}
