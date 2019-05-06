context("trait data structure")
library(traitdataform)

pulldata('heteroptera_raw')
pulldata('arthropodtraits')
pulldata('carabids')


test_that("encoding and read-in successful", {
  skip_if_not( l10n_info()$`UTF-8` )
  
  expect_true(exists("arthropodtraits"))
  expect_equal(as.character(arthropodtraits[1065,"Author"]),"(Herrich-Schäffer, 1841)")
  
  
  expect_true(exists("heteroptera_raw"))
  
  expect_true(heteroptera_raw[1,6] == "(Fallen, 1807)")
  expect_equal(as.character(heteroptera_raw[13,6]), "(Herrich-Schäffer, 1841)")
  
  expect_false(is.null(attributes(heteroptera_raw)$taxa))
  expect_true(attributes(heteroptera_raw)$taxa == "SpeciesID")
  
  expect_false(is.null(attributes(heteroptera_raw)$thesaurus))
  expect_s3_class(attributes(heteroptera_raw)$thesaurus, "thesaurus")
  
  
})

test_that("keep matrix structure", {
  
  expect_message(as.traitdata(arthropodtraits, traits = c("Body_Size", "Dispersal_ability", "Feeding_guild", "Feeding_guild_short", "Feeding_mode", "Feeding_specialization", "Feeding_tissue", "Feeding_plant_part", "Endophagous_lifestyle", "Stratum_use", "Stratum_use_short"), longtable = FALSE), "data were not converted to longtable!")
  
  dd1 <- as.traitdata(arthropodtraits, traits = c("Body_Size", "Dispersal_ability", "Feeding_guild", "Feeding_guild_short", "Feeding_mode", "Feeding_specialization", "Feeding_tissue", "Feeding_plant_part", "Endophagous_lifestyle", "Stratum_use", "Stratum_use_short"), longtable = FALSE)
  
  expect_length(dd1$scientificName,1230)
  expect_length(dd1[1,], 14)
  expect_s3_class(dd1, "traitdata")

})

test_that("reformat, with trait columns provided as argument", {
  
  dd1 <- as.traitdata(arthropodtraits, traits = c("Body_Size", "Dispersal_ability", "Feeding_guild", "Feeding_guild_short", "Feeding_mode", "Feeding_specialization", "Feeding_tissue", "Feeding_plant_part", "Endophagous_lifestyle", "Stratum_use", "Stratum_use_short"))
  
  expect_length(dd1$scientificName,10238)
  expect_length(dd1[1,], 5)
  expect_s3_class(dd1, "traitdata")
  
  dd2 <- as.traitdata(carabids, traits = c("body_length", "antenna_length", "metafemur_length", "eyewidth_corr"))
  dd2 <- as.traitdata(carabids)
   
  expect_length(dd2$scientificName,480)
  expect_length(dd2[1,], 7)
  expect_s3_class(dd2, "traitdata")
  
} )

test_that("reformat species data, with trait columns provided as attributes", {

  expect_message(as.traitdata(arthropodtraits), "Input is taken to be a species -- trait matrix")
  dd1 <- as.traitdata(arthropodtraits)
  
  expect_length(dd1$scientificName,10238)
  expect_length(dd1[1,], 5)
  expect_s3_class(dd1, "traitdata")
  
  
})

 
test_that("reformat observation data, with trait columns provided as attributes", {

  dd3 <- as.traitdata(heteroptera_raw)

  expect_length(dd3$scientificName, 9386)
  expect_length(dd3[1,], 10)
  expect_s3_class(dd3, "traitdata")

})

test_that("reformat, with trait columns provided as thesaurus", {
  
  expect_message(as.traitdata(arthropodtraits), "Input is taken to be a species -- trait matrix")
  dd1 <- as.traitdata(arthropodtraits)
  
  expect_length(dd1$scientificName,10238)
  expect_length(dd1[1,], 5)
  expect_s3_class(dd1, "traitdata")
  
})



test_that("reformat, with 'keep' argument", {

  dd2 <- as.traitdata(carabids, traits = c("body_length", "antenna_length", "metafemur_length", "eyewidth_corr"), keep = c(measurementDeterminedBy = "source_measurement", measurementRemarks = "note"))

  expect_length(dd2$scientificName,480)
  expect_length(dd2[1,], 7)
  expect_true( all(names(dd2) ==  c("scientificName", "traitName", "traitValue", "traitUnit", "measurementID", "measurementDeterminedBy", "measurementRemarks")) )
  expect_s3_class(dd2, "traitdata")


}
)


test_that("reformat, with 'drop' argument", {

  dd2 <- as.traitdata(carabids, traits = c("body_length", "antenna_length", "metafemur_length", "eyewidth_corr"), keep = c(measurementDeterminedBy = "source_measurement"), drop = c("note"))

  expect_length(dd2$scientificName,480)
  expect_length(dd2[1,], 6)
  expect_true( all(names(dd2) ==  c("scientificName", "traitName", "traitValue", "traitUnit", "measurementID", "measurementDeterminedBy")) )
  expect_s3_class(dd2, "traitdata")

}
)

