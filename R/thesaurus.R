thesaurus <- function(x = NULL,
                      replace = NULL,
                      appliestoall = NULL,
                      ...) {
  
  
  if(class(x) == "data.frame") {
    if(!c("traitName", "traitID", "traitDescription", "measurementType") %in% names(x)) {
      message("Dataset does not match expected column names.")
        if(!is.null(replace)) {
          message("I'm using parameter 'replace' for renaming!")
          x <- reshape::rename(x, replace)
          if(!c("traitName", "traitID", "traitDescription", "measurementType") %in% names(x)) stop("Parameter 'replace' must at least provide mapping for 'traitName', 'traitID', 'traitDescription', 'measurementType'")
        } else { stop("Provide mapping of column names in parameter 'replace'!")}
    }
    out <- x
  } else {
    out <- thesaurus(data.frame(...))
    
  }
  
  class(out) <- c("thesaurus", "data.frame")
  return(out)
}

