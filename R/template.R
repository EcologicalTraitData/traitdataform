#' Title
#'
#' @param name
#' @param version
#' @param author
#' @param input
#' @param parent
#' @param columns
#' @param fun
#' @param out_map
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
#'
#'
#'template.base <- template(
#'  name = "template.traitdata",
#'  author = "Schneider, Florian D., Nadja Simons, Caterina Penone, Andreas Ostrowski",
#'  input = read.csv("data/template_base.csv"),
#'  parent = NULL
#')
#'

template <- function(
  name,
  version = NULL,
  author = NULL,
  input = read.csv("data/template_base.csv"),
  parent = NULL,
  columns = NULL,
  fun = NULL, # functions to be executed when generating data
  out_map = NULL,
  ...
) {

  # ToDo: if parent is provided, add new columns and glossary content, overwrite existing entries

  out  <- list(
    name = name,
    version = version,
    author = author,
    parent = parent,
    columns = input[,"columnName"],
    glossary = glossary,
    fun = fun,
    out_map = out_map,
    ...
  )

  out$glossary <- as.data.table(input[!names(input) %in% c("columnName")])
  out$glossary <- setNames(split(out$glossary, f = seq(nrow(out$glossary))), out$columns)

  class(out) <- c("list", "traitdata")
  return(out)
}


BExIS.traitdata <- list(
  name = "BExIS.traitdata",
  author = "Schneider, Florian D., Nadja Simons, Caterina Penone, Andreas Ostrowski",
  parent = template.base,
  template = read.csv("data/template_glossary.csv")
)

