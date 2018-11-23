context("apply standardize() functions to traitdata")

library(traitdataform)

test_that("mapping of taxa works", {
  pulldata("carabids")
  dataset1 <- as.traitdata(carabids)
  
  dd1 <- standardise_taxa(dataset1[c(1,83,166,206,240,286,320,323,361,306,440),])
  expect_equal(as.character(dd1$scientificNameStd), c("Abax parallelepipedus", "Abax parallelepipedus", "Calathus cinctus", "Calathus cinctus", "Dromius angustus", "Platynus assimilis", "Platynus assimilis", NA, NA, "Notiophilus aquaticus", "Dicheirotrichus placidus") )
  expect_true(all(c("scientificNameStd", "taxonID", "warnings") %in% names(dd1)))

  dd1 <- standardise_taxa(dataset1[c(1,83,166,206,240,286,320,323,361,306,440),], method_options = c(resolve_synonyms = FALSE))
  expect_equal(as.character(dd1$scientificNameStd), c("Abax parallelepipedus", "Abax parallelepipedus", "Calathus cinctus", "Calathus cinctus", "Dromius angustus", "Limodromus assimilis", "Limodromus assimilis", NA, NA, "Notiophilus aquaticus", "Trichocellus placidus") )
  expect_true(all(c("scientificNameStd", "taxonID", "warnings") %in% names(dd1)))
  
  
  pulldata("arthropodtraits")
  dataset2 <- as.traitdata(arthropodtraits)
  
  dd2 <- standardise_taxa(dataset2[c(215,476,774,975,1445,1706,3437,3905,4667,5396,5896,8755,8966),])
  expect_equal(as.character(dd2$scientificNameStd), c("Acalypta parvula", "Kosswigianella denticauda", "Kosswigianella spinosa", "Kosswigianella spinosa", "Kosswigianella spinosa", "Aspidapion radiolus", "Aspidapion radiolus", "Aspidapion radiolus", "Mocyta fungi", "Gymnetron ictericus", "Gymnetron ictericus", "Gymnetron ictericus", "Trigonocranus emmeae") )
  expect_true(all(c("scientificNameStd", "taxonID", "warnings") %in% names(dd2)))
  
  })


test_that("mapping of traits based on thesaurus works", {
  
})