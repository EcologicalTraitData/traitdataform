
temp <- tempfile(fileext = ".zip")
utils::download.file("https://ndownloader.figshare.com/files/8828578", temp, method = "auto", quiet = TRUE, mode="wb")
utils::unzip(temp, files = "AmphiBIO_v1.csv", exdir = ".")
unlink(temp)
rm(temp)

amphibio <- utils::read.csv("AmphiBIO_v1.csv")
file.remove("AmphiBIO_v1.csv")

attr(amphibio, 'metadata') <- traitdataform::as.metadata(
  datasetName = "AmphiBio",
  datasetID = "amphibio",
  bibliographicCitation =    utils::bibentry(
    bibtype = "Article",
    title = "AmphiBIO, a global database for amphibian ecological traits",
    journal = "Scientific Data",
    volume = 4,
    pages = 170123,
    author = utils::as.person("Brunno Freire Oliveira, Vinícius Avelar São-Pedro, 
                              Georgina Santos-Barrera, Caterina Penone, and Gabriel C. Costa"),
    year = 2017,
    doi = "10.1038/sdata.2017.123"
  ),
  author = "Brunno Freire Oliveira",
  license = "http://creativecommons.org/publicdomain/zero/1.0/"
)
  
attr(amphibio, 'thesaurus') <-  traitdataform::as.thesaurus(
  Fos = traitdataform::as.trait("Fos",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  Ter = traitdataform::as.trait("Ter",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  Aqu = traitdataform::as.trait("Aqu",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  Arb = traitdataform::as.trait("Arb",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  
  Leaves = traitdataform::as.trait("Leaves",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  Flowers = traitdataform::as.trait("Flowers",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  Seeds = traitdataform::as.trait("Seeds",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  Fruits = traitdataform::as.trait("Fruits",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  Arthro = traitdataform::as.trait("Arthro",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  
  Diu = traitdataform::as.trait("Diu",
                                expectedUnit = NA, valueType = "logical",
                                identifier = "http://purl.obolibrary.org/obo/VT_0001502"),
  Noc = traitdataform::as.trait("Noc",
                                expectedUnit = NA, valueType = "logical",
                                identifier = "http://purl.obolibrary.org/obo/VT_0001502"),
  Crepu = traitdataform::as.trait("Crepu",
                                expectedUnit = NA, valueType = "logical",
                                identifier = "http://purl.obolibrary.org/obo/VT_0001502"),
  
  Wet_warm = traitdataform::as.trait("Wet_warm",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  Wet_cold = traitdataform::as.trait("Wet_cold",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  Dry_warm = traitdataform::as.trait("Dry_warm",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  Dry_cold = traitdataform::as.trait("Dry_cold",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  
  Body_mass_g = traitdataform::as.trait("Body_mass_g",
                                expectedUnit = "g", valueType = "numeric",
                                identifier = "http://purl.obolibrary.org/obo/VT_0001259"),
  Age_at_maturity_min_y = traitdataform::as.trait("Age_at_maturity_min_y",
                                expectedUnit = "a", valueType = "numeric",
                                identifier = " 	http://ecologicaltraitdata.github.io/TraitDataList/Age_at_maturity"),
  Age_at_maturity_max_y = traitdataform::as.trait("Age_at_maturity_max_y",
                                expectedUnit = "a", valueType = "numeric",
                                identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Age_at_maturity"),
  Body_size_mm = traitdataform::as.trait("Body_size_mm",
                                expectedUnit = "mm", valueType = "numeric",
                                identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Body_length"),
  Size_at_maturity_min_mm = traitdataform::as.trait("Size_at_maturity_min_mm",
                                expectedUnit = "mm", valueType = "numeric",
                                identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Body_length"),
  Size_at_maturity_max_mm = traitdataform::as.trait("Size_at_maturity_max_mm",
                                expectedUnit = "mm", valueType = "numeric",
                                identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Body_length"),
  Longevity_max_y = traitdataform::as.trait("Longevity_max_y",
                                expectedUnit = "a", valueType = "numeric",
                                identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Life_span_potential"),
  Litter_size_min_n = traitdataform::as.trait("Litter_size_min_n",
                                expectedUnit = NA, valueType = "numeric",
                                identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Clutch_size"),
  Litter_size_max_n = traitdataform::as.trait("Litter_size_max_n",
                                expectedUnit = NA, valueType = "numeric",
                                identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Clutch_size"),
  Reproductive_output_y = traitdataform::as.trait("Reproductive_output_y",
                                expectedUnit = "a", valueType = "numeric",
                                identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Fecundity"),
  Offspring_size_min_mm = traitdataform::as.trait("Offspring_size_min_mm",
                                expectedUnit = "mm", valueType = "numeric",
                                identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Reproduction_mode"),
  Offspring_size_max_mm = traitdataform::as.trait("Offspring_size_max_mm",
                                expectedUnit = "mm", valueType = "numeric",
                                identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Reproduction_mode"),
  
  Dir = traitdataform::as.trait("Dir",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  Lar = traitdataform::as.trait("Lar",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA),
  Viv = traitdataform::as.trait("Viv",
                                expectedUnit = NA, valueType = "logical",
                                identifier = NA)
)

attr(amphibio, 'Species') <- "Species"
attr(amphibio, 'keep') <-  c(measurementRemarks = "OBS")


print(attributes(amphibio)$metadata)

