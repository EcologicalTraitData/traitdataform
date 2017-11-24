# for roxygen2 documentation please edit file R/data.R!

mammaldiet <- utils::read.csv("http://datadryad.org/bitstream/handle/10255/dryad.64565/MammalDIET_v1.0.txt?sequence=1",
                              sep = "\t",
                              fileEncoding = "UTF-8"
)

mammaldiet$taxa <- paste(mammaldiet$Genus, mammaldiet$Species)

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
  diet_Animal = traitdataform::as.trait("diet_Animal", valueType = "integer"),
  diet_Vertebrate = traitdataform::as.trait("diet_Vertebrate", valueType = "integer"),
  diet_Mammal = traitdataform::as.trait("diet_Mammal", valueType = "integer"),
  diet_Bird = traitdataform::as.trait("diet_Bird", valueType = "integer"),
  diet_Herptile = traitdataform::as.trait("diet_Herptile", valueType = "integer"),
  diet_Fish = traitdataform::as.trait("diet_Fish", valueType = "integer"),
  diet_Invertebrate = traitdataform::as.trait("diet_Invertebrate", valueType = "integer"),
  diet_Plant = traitdataform::as.trait("diet_Plant", valueType = "integer"),
  diet_Seed = traitdataform::as.trait("diet_Seed", valueType = "integer"),
  diet_Fruit = traitdataform::as.trait("diet_Fruit", valueType = "integer"),
  diet_Nectar = traitdataform::as.trait("diet_Nectar", valueType = "integer"),
  diet_Root = traitdataform::as.trait("diet_Root", valueType = "integer"),
  diet_Leaf = traitdataform::as.trait("diet_Leaf", valueType = "integer"),
  diet_Woody = traitdataform::as.trait("diet_Woody", valueType = "integer"),
  diet_Herbaceous = traitdataform::as.trait("diet_Herbaceous", valueType = "integer"),
  diet_Other = traitdataform::as.trait("diet_Other", valueType = "integer"),
  
  TrophicLevel = traitdataform::as.trait("TrophicLevel", valueType = "factor"),
  
  diet_guild_MammalEater = traitdataform::as.trait("diet_guild_MammalEater", valueType = "logical"),
  diet_guild_Insectivore = traitdataform::as.trait("diet_guild_Insectivore", valueType = "logical"),
  diet_guild_Frugivore = traitdataform::as.trait("diet_guild_Frugivore", valueType = "logical"),
  diet_guild_Granivore = traitdataform::as.trait("diet_guild_Granivore", valueType = "logical"),
  diet_guild_Folivore = traitdataform::as.trait("diet_guild_Folivore", valueType = "logical")
)

attr(mammaldiet, 'taxa') <- "taxa"
attr(mammaldiet, 'keep') <-  c(datasetID = "DataSource", taxaSynonym = "note")

print(attributes(mammaldiet)$metadata)
