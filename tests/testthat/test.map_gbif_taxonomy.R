context("get gbif taxonomy")

library(traitdataform)


pulldata("carabids")
pulldata("arthropodtraits")

test_that("gbif taxonomy reachable", {
  # digest(get_gbif_taxonomy(carabids$name_correct[1:12]))
  expect_known_hash(get_gbif_taxonomy(carabids$name_correct[1:12]), hash = 'c21e44a8f71c86ad2a0228d29d7b3698')
  # digest(get_gbif_taxonomy(arthropodtraits$SpeciesID[1:12]))
  expect_known_hash(get_gbif_taxonomy(arthropodtraits$SpeciesID[1:12]), hash = 'f6bbc8c0f02487fdbd3ca35c091fa65e')
})

test_that("mapping misspelled names", {
  expect_true(get_gbif_taxonomy("Cicindela_silvatica", fuzzy = TRUE)$scientificName == "Cicindela sylvatica")
  expect_true(get_gbif_taxonomy("Tetrix krausi", fuzzy = TRUE)$scientificName == "Tetrix kraussi")
  expect_true(is.null(get_gbif_taxonomy("Tetrics krausi", fuzzy = TRUE)$scientificName))
  expect_true(get_gbif_taxonomy("Tetrics krausi", conf_threshold = 50, fuzzy = TRUE)$scientificName == "Tetrix kraussi")
  
  })

test_that("mapping synonyms", {
  expect_true(get_gbif_taxonomy("Limodromus_assimilis")$scientificName == "Platynus assimilis")
  expect_true(get_gbif_taxonomy("Trichocellus_cognatus")$scientificName == "Dicheirotrichus cognatus")
  expect_true(get_gbif_taxonomy("Trichocellus_placidus")$scientificName == "Dicheirotrichus placidus")
  expect_true(get_gbif_taxonomy("Styloctetor stativus")$scientificName == "Styloctetor compar")
  expect_true(get_gbif_taxonomy("Aspidapion radiolus")$scientificName == "Curculio radiolus")
  })


test_that("mapping doubtful taxa", {
  })

test_that("mapping lower or higher taxa", {
  expect_true(
    get_gbif_taxonomy("Acrocephalus familiaris kingi")$scientificName == "Acrocephalus familiaris kingi")
  
  expect_true(
    get_gbif_taxonomy("Acrocephalus familiaris kingi", subspecies = FALSE)$scientificName == "Acrocephalus familiaris")
  
  expect_true(get_gbif_taxonomy("Abax")$taxonRank == "genus")
 # expect_true(get_gbif_taxonomy("Cidnopus quercus", higherrank = TRUE)$taxonRank == "genus")
  })

test_that("not matching", {
  expect_true(get_gbif_taxonomy("No_species", fuzzy = TRUE)$warnings == " No match! Check spelling or lower confidence threshold!")
  expect_true(get_gbif_taxonomy("raoi_sdoi", fuzzy = TRUE)$warnings == "No matching species concept! No match! Check spelling or lower confidence threshold!")
})


test_that("big data handling", {
  skip_on_cran()

  pulldata("carabids")
  # digest(get_gbif_taxonomy(levels(traitdataform:::as_factor_clocale(carabids$name_correct))) )
  expect_known_hash(get_gbif_taxonomy(levels(as_factor_clocale(carabids$name_correct))), hash = '5ecae54449e8e2bb0d877de5e990d039')

  pulldata("heteroptera_raw")
  # digest(get_gbif_taxonomy(levels(traitdataform:::as_factor_clocale(heteroptera_raw$SpeciesID))) )
  expect_known_hash(get_gbif_taxonomy(levels(as_factor_clocale(heteroptera_raw$SpeciesID))), hash = '4b341b4fde02d4befd961e5f91235dcd')

#  pulldata("arthropodtraits")
#  expect_known_hash(get_gbif_taxonomy(levels(arthropodtraits$SpeciesID)), hash = '2efcaaa0e1')


})
