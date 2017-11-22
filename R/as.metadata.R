#' Create metadata for trait dataset
#'
#' Function to create a defined object containing metadata paramaters according to a pre-defined template. 
#' 
#' @param ... named objects of any class. Names must be the same as given by template or they will be ignored when producing the metadata object. 
#' @param template The default template contains the elements as defined by the Ecological Traitdata Standard. (see Details)
#'
#' @return an object of class 'metadata', or - if metadata objects are provided as input - a list object of class 'metadatalist'. 
#' @export
#'
#' @examples
#' 
#' # set metadata object
#' a <- as.metadata(author = "Martin Gossner", datasetName = "Heteroptera morphometric traits")
#' 
#' # update an existing metadata object
#' a1 <- as.metadata(datasetID = "heteroptera", template = a)
#' 
#' 
as.metadata <- function(..., 
                    template = list(
                      datasetID = NULL,
                      datasetName = NULL,
                      author = NULL,
                      rightsHolder = NULL,
                      bibliographicCitation = NULL,
                      license = NULL,
                      version = NULL,
                      comments = NULL,
                      description = NULL,
                      region = NULL
                      )
                    ) {
    
    if("list" %in% class(..1)) {
      
      if("metadata" %in% class(..1)) {
        do.call(metadata, list(..1, template = template))
      } else {
        if("metadata" %in% class(..1[[1]])) {
          list(...)
        }  
      }
    } else {
      
      metadata_in <- list(...)
      
      metadata_out <- lapply(names(template), function(i) {
        if (i %in% names(metadata_in)) metadata_in[[i]]
        else template[[i]]  
      })
      names(metadata_out) <- names(template)
      
      class(metadata_out) <- c("metadata", "list")
      return(metadata_out)
      
    }
}


#' @export
print.metadata <- function(x, ...) {
  
      if(!is.null(x$datasetID)) {
        cat("\n", x$datasetID, ": ")
      } else { cat("\n[ ] : ")}
      
      # trait-dataset: datasetname (version) by author 
      
      if(!is.null(x$datasetName)) {
        cat(x$datasetName)
      }
      if(!is.null(x$version)) {
        cat(" (", x$version, ") ")
      }
      if(!is.null(x$author)) {
        cat(" by", x$author,".\n") 
      }
      
      
      if(!is.null(x$bibliographicCitation) |
         !is.null(x$license))  {
        cat("\n    When using these data must acknowledge the following usage policies: \n")
      }
      
      # cite as: 
      if(!is.null(x$bibliographicCitation)) {
        
        cat("\n    Cite this trait dataset as: \n")
        print(x$bibliographicCitation)
      }
      # published under
      if(!is.null(x$license)) {
        cat("\n    Published under:", x$license, "\n\n")
      }

}