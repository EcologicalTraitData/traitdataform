#' Transforms csv glossary of terms into the machine readable traitdata-template in xml format
#'
#' @param df 
#' @param name 
#'
#' @return
#' @export
#' @import XML
#'
#' @examples
#' 
convertToXML <- function(df,name)
{
  xml <- XML::xmlTree("Test")
  xml$addNode(name, close=FALSE)
  for (i in 1:nrow(df)) {
    xml$addNode("value", close=FALSE)
    for (j in names(df)) {
      xml$addNode(j, df[i, j])
    }
    xml$closeTag()
  }
  xml$closeTag()
  return(xml)
}

template = convertToXML(glossary,"BExIS_template")
XML::saveXML(template$value(), file = "data/template.xml")
