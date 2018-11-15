context("trait data structure")
library(traitdataform)

pulldata('arthropodtraits')
pulldata('heteroptera_raw')

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
  
  
} )

test_that("reformat species data, with trait columns provided as attributes", {
  
  expect_message(as.traitdata(arthropodtraits), "Input is taken to be a species -- trait matrix")
  dd1 <- as.traitdata(arthropodtraits)
  
  expect_length(dd1$scientificName,10238)
  expect_length(dd1[1,], 5)
  expect_s3_class(dd1, "traitdata")
  
  
})

 
test_that("reformat observation data, with trait columns provided as attributes", {

dd2 <- as.traitdata(heteroptera_raw)

expect_length(dd2$scientificName, 9386)
expect_length(dd2[1,], 10)
expect_s3_class(dd2, "traitdata")

})

test_that("reformat, with trait columns provided as thesaurus", {
  
  expect_message(as.traitdata(arthropodtraits), "Input is taken to be a species -- trait matrix")
  dd1 <- as.traitdata(arthropodtraits)
  
  expect_length(dd1$scientificName,10238)
  expect_length(dd1[1,], 5)
  expect_s3_class(dd1, "traitdata")
  
})

# 
# 
# test_that("reformat, with taxa column provided as argument", {
#   
#   
# }
# )
# 
# 
# test_that("reformat, with taxa column provided as argument", {
#   
#   
# }
# )
# 
