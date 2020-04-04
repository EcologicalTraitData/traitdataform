context("get gbif taxonomy")

library(traitdataform)


pulldata("carabids")
pulldata("arthropodtraits")

test_that("gbif taxonomy reachable", {
  expect_known_hash(get_gbif_taxonomy(carabids$name_correct[1:12]), hash = '2448e3596a')
  expect_known_hash(get_gbif_taxonomy(arthropodtraits$SpeciesID[1:12]), hash = '4381d5bd4d')
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
  expect_true(get_gbif_taxonomy("Gymnetron melanarium")$scientificNameStd == "Gymnetron melanarius")
  expect_true(get_gbif_taxonomy( "Aspidapion radiolus")$scientificNameStd == "Aspidapion radiolus")
  })


test_that("mapping doubtful taxa", {
  expect_match(get_gbif_taxonomy("Rhynchaenus fagi")$warnings, "DOUBTFUL")
  expect_match(get_gbif_taxonomy("Rhynchaenus lonicerae")$warnings, "DOUBTFUL")
  expect_match(get_gbif_taxonomy("Scolytus intricatus")$warnings, "equally ranked")
  expect_match(get_gbif_taxonomy("Tychius meliloti")$warnings, "DOUBTFUL")
  })

test_that("mapping lower or higher taxa", {
  expect_true(
    get_gbif_taxonomy("Acrocephalus familiaris kingi")$scientificNameStd == "Acrocephalus familiaris kingi")
  
  expect_true(
    get_gbif_taxonomy("Acrocephalus familiaris kingi", subspecies = FALSE)$scientificNameStd == "Acrocephalus familiaris")
  
  expect_true(get_gbif_taxonomy("Abax")$taxonRank == "genus")
 # expect_true(get_gbif_taxonomy("Cidnopus quercus", higherrank = TRUE)$taxonRank == "genus")
  })

test_that("not matching", {
  expect_true(get_gbif_taxonomy("No_species")$warnings == " No match! Check spelling or lower confidence threshold!")
  expect_true(get_gbif_taxonomy("raoi_sdoi")$warnings == "No matching species concept! No match! Check spelling or lower confidence threshold!")
})


test_that("big data handling", {
  skip_on_cran()

  pulldata("carabids")
  expect_known_hash(get_gbif_taxonomy(levels(as_factor_clocale(carabids$name_correct))), hash = '62259f87630cd55f329f03e2bff8e8df')

  pulldata("heteroptera_raw")
  expect_known_hash(get_gbif_taxonomy(levels(as_factor_clocale(heteroptera_raw$SpeciesID))), hash = '2e3b9aa364e007bc98ab1fa3f2ff40dd')

#  pulldata("arthropodtraits")
#  expect_known_hash(get_gbif_taxonomy(levels(arthropodtraits$SpeciesID)), hash = '2efcaaa0e1')


})
