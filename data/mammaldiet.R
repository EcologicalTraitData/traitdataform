# for roxygen2 documentation please edit file R/data.R!

mammaldiet <- utils::read.csv("http://datadryad.org/bitstream/handle/10255/dryad.64565/MammalDIET_v1.0.txt?sequence=1",
                              sep = "\t",
                              fileEncoding = "UTF-8"
)

attr(mammaldiet, 'metadata') <- traitdataform::as.metadata(
  datasetName = "Mammal diet database",
  datasetID = "mammaldiet",
  bibliographicCitation =  utils::bibentry(
    bibtype = "Article",
    title = "Establishing macroecological trait datasets: digitalization, extrapolation, and validation of diet preferences in terrestrial mammals worldwide",
    journal = "Ecology and Evolution",
    author = c(utils::as.person("Wilm Daniel Kissling, Lars Dalby, Camilla Fløjgaard, Jonathan Lenoir, Brody Sandel,
                                Christopher Sandom, Kristian Trøjelsgaard, Jens-Christian Svenning")),
    year = 2014,
    doi = "10.1002/ece3.1136"
  ),
  author = "Wilm Daniel Kissling",
  license = "http://creativecommons.org/publicdomain/zero/1.0/"
)

attr(mammaldiet, 'thesaurus') <-  traitdataform::as.thesaurus(
  diet_content = traitdataform::as.trait("diet_content", valueType = "factor"),
  TrophicLevel = traitdataform::as.trait("TrophicLevel", valueType = "factor"),
  dietary_guild = traitdataform::as.trait("dietary_guild", valueType = "factor"))

print(attributes(mammaldiet)$metadata)
