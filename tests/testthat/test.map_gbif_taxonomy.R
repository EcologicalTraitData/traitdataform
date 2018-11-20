context("get gbif taxonomy")

library(traitdataform)


test_that("gbif taxonomy reachable", {
  pulldata("carabids")
  pulldata("arthropodtraits")
  #expect_known_hash(get_gbif_taxonomy(as.character(carabids$name_correct[1:12])), hash = 'c8f437ad70')
  expect_known_hash(get_gbif_taxonomy(as.character(arthropodtraits$SpeciesID[1:12])), hash = '74f9a02a12')
})

test_that("mapping misspelled names", {
  expect_true(get_gbif_taxonomy("Cicindela_silvatica")$scientificNameStd == "Cicindela sylvatica")
  expect_true(get_gbif_taxonomy("Tetrix krausi")$scientificNameStd == "Tetrix kraussi")
  expect_true(is.null(get_gbif_taxonomy("Tetrics krausi")$scientificNameStd))
  expect_true(get_gbif_taxonomy("Tetrics krausi", conf_threshold = 50)$scientificNameStd == "Tetrix kraussi")
  expect_true(get_gbif_taxonomy("Closterotomus norwegicus")$scientificNameStd == "Closterotomus norvegicus")
  
  })

test_that("mapping synonyms", {
  expect_true(get_gbif_taxonomy("Limodromus_assimilis")$scientificNameStd == "Platynus assimilis")
  expect_true(get_gbif_taxonomy("Trichocellus_cognatus")$scientificNameStd == "Dicheirotrichus cognatus")
  expect_true(get_gbif_taxonomy("Trichocellus_placidus")$scientificNameStd == "Dicheirotrichus placidus")
  expect_true(get_gbif_taxonomy("Styloctetor stativus")$scientificNameStd == "Styloctetor compar")
  
  })


test_that("mapping doubtful taxa", {
  expect_match(get_gbif_taxonomy("Rhynchaenus fagi")$warnings, "DOUBTFUL")
  expect_match(get_gbif_taxonomy("Rhynchaenus lonicerae")$warnings, "DOUBTFUL")
  expect_match(get_gbif_taxonomy("Scolytus intricatus")$warnings, "ACCEPTED")
  expect_match(get_gbif_taxonomy("Tychius meliloti")$warnings, "DOUBTFUL")
  })

test_that("mapping lower or higher taxa", {
  expect_true(
    get_gbif_taxonomy("Acrocephalus familiaris kingi")$scientificNameStd == "Acrocephalus familiaris kingi")
  
  expect_true(
    get_gbif_taxonomy("Acrocephalus familiaris kingi", subspecies = FALSE)$scientificNameStd == "Acrocephalus familiaris")
  
  expect_true(get_gbif_taxonomy("Abax")$taxonRank == "genus")
  expect_true(get_gbif_taxonomy("Cidnopus quercus", higherrank = TRUE)$taxonRank == "genus")
  })

test_that("not matching", {
  expect_true(get_gbif_taxonomy("No_species")$warnings == " Lower confidence threshold might yield results.")
  expect_true(get_gbif_taxonomy("raoi_sdoi")$warnings == "No matching species concept! Lower confidence threshold might yield results.")
})


test_that("big data handling", {
  skip_on_cran() 
  
  pulldata("carabids")
  #expect_known_hash(get_gbif_taxonomy(levels(carabids$name_correct)), hash = '8b82d2ee6b')
  
  pulldata("heteroptera_raw")
  #expect_known_hash(get_gbif_taxonomy(levels(heteroptera_raw$SpeciesID)), hash = 'b505673cd7')
  
  
}) 
