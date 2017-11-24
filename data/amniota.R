
amniota <- utils::read.csv("http://esapubs.org/archive/ecol/E096/269/Data_Files/Amniote_Database_Aug_2015.csv",
                           fileEncoding = "UTF-8")

amniota$taxa <- paste(amniota$genus, amniota$species)

#replace -999 with NA
amniota[amniota == -999] <- NA

attr(amniota, 'metadata') <- traitdataform::as.metadata(
  datasetName = "Amnote life-history",
  datasetID = "amniota",
  bibliographicCitation =  utils::bibentry(
    bibtype = "Article",
    title = "An amniote life-history database to perform comparative analyses with birds, mammals, and reptiles",
    journal = "Ecology",
    author = c(utils::as.person("Nathan P. Myhrvold, Elita Baldridge, Benjamin CHan, Dhileep Sivam, 
                                Daniel L. Freeman, S.K. Morgan Ernest")),
    year = 2015,
    doi = "10.1890/15-0846.1"
  ),
  author = "Nathan P. Myhrvold",
  license = "http://creativecommons.org/publicdomain/zero/1.0/"
)

attr(amniota, 'thesaurus') <-  traitdataform::as.thesaurus(
  female_maturity_d = traitdataform::as.trait("female_maturity_d",
                                        expectedUnit = "d", valueType = "numeric",
                                        identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Development"),
  
  litter_or_clutch_size_n = traitdataform::as.trait("litter_or_clutch_size_n",
                                              valueType = "numeric",
                                              identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Reproduction_mode"),
  
  litters_or_clutches_per_y = traitdataform::as.trait("litters_or_clutches_per_y",
                                                    valueType = "numeric",
                                                    identifier = NA),
  
  adult_body_mass_g = traitdataform::as.trait("adult_body_mass_g",
                                              expectedUnit = "g", valueType = "numeric",
                                              identifier = "http://purl.obolibrary.org/obo/VT_0001259"),
  
  maximum_longevity_y = traitdataform::as.trait("maximum_longevity_y",
                                              expectedUnit = "a", valueType = "numeric",
                                              identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Life_span_potential"),
  
  gestation_d = traitdataform::as.trait("gestation_d",
                                        expectedUnit = "d", valueType = "numeric",
                                        identifier = NA),
 
  weaning_d = traitdataform::as.trait("weaning_d",
                                        expectedUnit = "d", valueType = "numeric",
                                        identifier = NA),
  
  birth_or_hatching_weight_g = traitdataform::as.trait("birth_or_hatching_weight_g",
                                      expectedUnit = "g", valueType = "numeric",
                                      identifier = "http://purl.obolibrary.org/obo/VT_0001259"),
  
  weaning_weight_g = traitdataform::as.trait("weaning_weight_g",
                                             expectedUnit = "g", valueType = "numeric",
                                             identifier = "http://purl.obolibrary.org/obo/VT_0001259"),
  
  egg_mass_g = traitdataform::as.trait("egg_mass_g",
                                       expectedUnit = "g", valueType = "numeric",
                                       identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Egg_biomass"),
  
  incubation_d = traitdataform::as.trait("incubation_d",
                                         expectedUnit = "d", valueType = "numeric",
                                         identifier = "https://ecologicaltraitdata.github.io/TraitDataList/#egg_development_time"),
  
  fledging_age_d = traitdataform::as.trait("fledging_age_d",
                                         expectedUnit = "d", valueType = "numeric",
                                         identifier = NA),
  
  longevity_y = traitdataform::as.trait("longevity_y",
                                        expectedUnit = "a", valueType = "numeric",
                                        identifier = "http://purl.obolibrary.org/obo/VT_0001661"),
  
  male_maturity_d = traitdataform::as.trait("male_maturity_d",
                                        expectedUnit = "d", valueType = "numeric",
                                        identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Development"),
  
  inter_litter_or_interbirth_interval_y = traitdataform::as.trait("inter_litter_or_interbirth_interval_y",
                                            expectedUnit = "a", valueType = "numeric",
                                            identifier = NA),
  
  female_body_mass_g = traitdataform::as.trait("female_body_mass_g",
                                            expectedUnit = "g", valueType = "numeric",
                                            identifier = "http://purl.obolibrary.org/obo/VT_0001259"),
  
  male_body_mass_g = traitdataform::as.trait("male_body_mass_g",
                                               expectedUnit = "g", valueType = "numeric",
                                               identifier = "http://purl.obolibrary.org/obo/VT_0001259"),
  
  no_sex_body_mass_g = traitdataform::as.trait("no_sex_body_mass_g",
                                               expectedUnit = "g", valueType = "numeric",
                                               identifier = "http://purl.obolibrary.org/obo/VT_0001259"),
  
  egg_width_mm = traitdataform::as.trait("egg_width_mm",
                                               expectedUnit = "mm", valueType = "numeric",
                                               identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Egg_size"),
  
  egg_length_mm = traitdataform::as.trait("egg_length_mm",
                                               expectedUnit = "mm", valueType = "numeric",
                                               identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Egg_size"),
  
  fledging_mass_g = traitdataform::as.trait("fledging_mass_g",
                                               expectedUnit = "g", valueType = "numeric",
                                               identifier = "http://purl.obolibrary.org/obo/VT_0001259"),
  
  adult_svl_cm = traitdataform::as.trait("adult_svl_cm",
                                               expectedUnit = "cm", valueType = "numeric",
                                               identifier = "http://purl.obolibrary.org/obo/VT_0100005"),
  
  male_svl_cm = traitdataform::as.trait("male_svl_cm",
                                               expectedUnit = "cm", valueType = "numeric",
                                               identifier = "http://purl.obolibrary.org/obo/VT_0100005"),
  
  female_svl_cm = traitdataform::as.trait("female_svl_cm",
                                        expectedUnit = "cm", valueType = "numeric",
                                        identifier = "http://purl.obolibrary.org/obo/VT_0100005"),
  
  birth_or_hatching_svl_cm = traitdataform::as.trait("birth_or_hatching_svl_cm",
                                        expectedUnit = "cm", valueType = "numeric",
                                        identifier = "http://purl.obolibrary.org/obo/VT_0100005"),
  
  female_svl_at_maturity_cm = traitdataform::as.trait("female_svl_at_maturity_cm",
                                        expectedUnit = "cm", valueType = "numeric",
                                        identifier = "http://purl.obolibrary.org/obo/VT_0100005"),
  
  female_body_mass_at_maturity_g = traitdataform::as.trait("female_body_mass_at_maturity_g",
                                        expectedUnit = "g", valueType = "numeric",
                                        identifier = "http://purl.obolibrary.org/obo/VT_0001259"),
  
  no_sex_svl_cm = traitdataform::as.trait("no_sex_svl_cm",
                                        expectedUnit = "cm", valueType = "numeric",
                                        identifier = "http://purl.obolibrary.org/obo/VT_0100005"),
  
  no_sex_maturity_d = traitdataform::as.trait("no_sex_maturity_d",
                                        expectedUnit = "d", valueType = "numeric",
                                        identifier = "http://ecologicaltraitdata.github.io/TraitDataList/Development"),
)

attr(amniota, 'taxa') <- "taxa"


print(attributes(amniota)$metadata)



