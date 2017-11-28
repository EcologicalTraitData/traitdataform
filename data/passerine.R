
temp <- tempfile(fileext = ".zip")
utils::download.file("http://onlinelibrary.wiley.com/store/10.1002/ecy.1783/asset/supinfo/ecy1783-sup-0002-DataS1.zip?v=1&s=361647dd673d04c9b0838931cda1cf28e1f6eb1f", temp, method = "auto", quiet = TRUE, mode="wb")
utils::unzip(temp, files = "Measurements of passerine birds.xlsx", exdir = ".")

passerine <- readxl::read_excel("Measurements of passerine birds.xlsx", sheet=1)
file.remove("Measurements of passerine birds.xlsx")
unlink(temp)
rm(temp)

passerine$taxa <- paste(passerine$Genus,passerine$Species)

attr(passerine, 'metadata') <- traitdataform::as.metadata(
  datasetName = "Passerine morphology",
  datasetID = "passerine",
  bibliographicCitation =  utils::bibentry(
    bibtype = "Article",
    title = "Passerine morphology: external measurements of approximately one-quarter of passerine bird species",
    journal = "Ecology",
    author = c(utils::as.person("Robert E. Ricklefs")
    ),
    year = 2017,
    doi = "10.1002/ecy.1783"
  ),
  author = "Robert E. Ricklefs",
  license = "http://creativecommons.org/publicdomain/zero/1.0/"
)

attr(passerine, 'thesaurus') <-  traitdataform::as.thesaurus(
  Length = traitdataform::as.trait("Length", expectedUnit = "mm", valueType = "numeric",
                                   identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Body_length"),
  Wing = traitdataform::as.trait("Wing", expectedUnit = "mm", valueType = "numeric",
                                   identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Locomotion_morphology"),
  Tail = traitdataform::as.trait("Tail", expectedUnit = "mm", valueType = "numeric",
                                   identifier = NA),
  Tarsus = traitdataform::as.trait("Tarsus", expectedUnit = "mm", valueType = "numeric",
                                   identifier = NA),
  Toe = traitdataform::as.trait("Toe", expectedUnit = "mm", valueType = "numeric",
                                   identifier = NA),
  BillL = traitdataform::as.trait("Bill L", expectedUnit = "mm", valueType = "numeric",
                                   identifier = NA),
  BillW = traitdataform::as.trait("Bill W", expectedUnit = "mm", valueType = "numeric",
                                   identifier = NA),
  BillD = traitdataform::as.trait("Bill D", expectedUnit = "mm", valueType = "numeric",
                                   identifier = NA),
  
  HN = traitdataform::as.trait("HN", expectedUnit = "mm", valueType = "logic",
                                  identifier = NA),
  N = traitdataform::as.trait("N", expectedUnit = "mm", valueType = "logic",
                               identifier = NA),
  NI = traitdataform::as.trait("NI", expectedUnit = "mm", valueType = "logic",
                               identifier = NA),
  HP = traitdataform::as.trait("HP", expectedUnit = "mm", valueType = "logic",
                               identifier = NA),
  E = traitdataform::as.trait("EI", expectedUnit = "mm", valueType = "logic",
                               identifier = NA),
  O = traitdataform::as.trait("O", expectedUnit = "mm", valueType = "logic",
                               identifier = NA),
  OI = traitdataform::as.trait("OI", expectedUnit = "mm", valueType = "logic",
                               identifier = NA),
  AU = traitdataform::as.trait("AU", expectedUnit = "mm", valueType = "logic",
                               identifier = NA),
  AZ = traitdataform::as.trait("AZ", expectedUnit = "mm", valueType = "logic",
                               identifier = NA),
  AI = traitdataform::as.trait("AI", expectedUnit = "mm", valueType = "logic",
                               identifier = NA)
)

attr(passerine, 'taxa') <- "taxa"
attr(passerine, 'keep') <-  c(sex ="sex", basisOfRecord = "PreservedSpecimen")

print(attributes(passerine)$metadata)
