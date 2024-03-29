context("get gbif taxonomy")

library(traitdataform)

test_that("gbif taxonomy reachable", {
  skip_if_not( curl::has_internet() )
  # digest(get_gbif_taxonomy(carabids$name_correct[1:12]))
  expect_known_hash(get_gbif_taxonomy(carabids$name_correct[1:12]), hash = 'd37d3df9bed65e2451367aeaf98866dd')
  # digest(get_gbif_taxonomy(arthropodtraits$SpeciesID[1:12]))
  expect_known_hash(get_gbif_taxonomy(arthropodtraits$SpeciesID[1:12]), hash = '78fc839027d0fa26b64e6f856ece50b0')
})

test_that("mapping misspelled names", {
  skip_if_not( curl::has_internet() )
  expect_true(get_gbif_taxonomy("Cicindela_silvatica", fuzzy = TRUE)$scientificName == "Cicindela sylvatica")
  expect_true(get_gbif_taxonomy("Tetrix krausi", fuzzy = TRUE)$scientificName == "Tetrix kraussi")
  expect_true(is.na(get_gbif_taxonomy("Tetrics krausi", fuzzy = TRUE)$scientificName))
  expect_true(get_gbif_taxonomy("Tetrics krausi", conf_threshold = 50, fuzzy = TRUE)$scientificName == "Tetrix kraussi")
  
  })

test_that("mapping synonyms", {
  skip_if_not( curl::has_internet() )
  expect_true(get_gbif_taxonomy("Limodromus_assimilis")$scientificName == "Platynus assimilis")
  expect_true(get_gbif_taxonomy("Trichocellus_cognatus")$scientificName == "Dicheirotrichus cognatus")
  expect_true(get_gbif_taxonomy("Trichocellus_placidus")$scientificName == "Dicheirotrichus placidus")
  expect_true(get_gbif_taxonomy("Styloctetor stativus")$scientificName == "Styloctetor compar")
  })


test_that("mapping doubtful taxa", {
  })

test_that("mapping lower or higher taxa", {
  skip_if_not( curl::has_internet() )
  expect_true(
    get_gbif_taxonomy("Acrocephalus familiaris kingi")$scientificName == "Acrocephalus familiaris kingi")
  
  expect_true(
    get_gbif_taxonomy("Acrocephalus familiaris kingi", subspecies = FALSE)$scientificName == "Acrocephalus familiaris")
  
  expect_true(get_gbif_taxonomy("Abax")$taxonRank == "genus")
 # expect_true(get_gbif_taxonomy("Cidnopus quercus", higherrank = TRUE)$taxonRank == "genus")
  })

test_that("not matching", {
  skip_if_not( curl::has_internet() )
  expect_true(get_gbif_taxonomy("No_species", fuzzy = TRUE)$warnings == " Check spelling or lower confidence threshold!")
  expect_true(get_gbif_taxonomy("raoi_sdoi", fuzzy = TRUE)$warnings == "No matching species concept! Check spelling or lower confidence threshold!")
})


test_that("big data handling", {
  skip_if_not( curl::has_internet() )
  skip_on_cran()

  # digest(get_gbif_taxonomy(levels(traitdataform:::as_factor_clocale(carabids$name_correct))) )
  expect_known_hash(get_gbif_taxonomy(levels(as_factor_clocale(carabids$name_correct))), hash = '6e354098357e48a0ef7132a60e00736d')

  # digest(get_gbif_taxonomy(levels(traitdataform:::as_factor_clocale(heteroptera_raw$SpeciesID))) )
  expect_known_hash(get_gbif_taxonomy(levels(as_factor_clocale(heteroptera_raw$SpeciesID))), hash = 'b9505ad8e3a6c8f79005b30c42fce201')

#  expect_known_hash(get_gbif_taxonomy(levels(arthropodtraits$SpeciesID)), hash = '2efcaaa0e1')


})

