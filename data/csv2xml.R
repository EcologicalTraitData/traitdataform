# transforms csv glossary of terms into the machine readable traitdata-template in xml format

library(XML)

glossary <- read.csv("data/template_glossary.csv")

convertToXML <- function(df,name)
{
  xml <- xmlTree("Test")
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
saveXML(template$value(), file = "data/template.xml")
