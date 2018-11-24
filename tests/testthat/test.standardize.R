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
  pulldata("heteroptera_raw")
  
  dataset2 <- as.traitdata(heteroptera_raw)
                            
                          
  traits2 <- as.thesaurus(
     Body_length = as.trait("Body_length",
                            expectedUnit = "mm", valueType = "numeric",
                            traitDescription = "From the tip of the head to the end of the abdomen"),
     Antenna_Seg1 = as.trait("Antenna_Seg1",
                             expectedUnit = "mm", valueType = "numeric",
                             traitDescription = "Length of first antenna segment",
                             broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
     Antenna_Seg2 = as.trait("Antenna_Seg2",
                             expectedUnit = "mm", valueType = "numeric",
                             traitDescription = "Length of second antenna segment",
                             broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
     Antenna_Seg3 = as.trait("Antenna_Seg3",
                             expectedUnit = "mm", valueType = "numeric",
                             traitDescription = "Length of third antenna segment",
                             broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
     Antenna_Seg4 = as.trait("Antenna_Seg4",
                             expectedUnit = "mm", valueType = "numeric",
                             traitDescription = "Length of fourth antenna segment",
                             broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
     Antenna_Seg5 = as.trait("Antenna_Seg5",
                             expectedUnit = "mm", valueType = "numeric",
                             traitDescription = "Length of fifth antenna segment (only Pentatomoidea)",
                             broaderTerm = "http://ecologicaltraitdata.github.io/TraitDataList/Antenna_length"),
     Hind.Femur_length = as.trait("Hind.Femur_length",
                             expectedUnit = "mm", valueType = "numeric",
                             traitDescription = "Length of the femur of the hind leg",
                             broaderTerm = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Femur_length")
   )
                           
   dataset2Std <- standardize_traits(dataset2, 
                                thesaurus = traits2
                                )
   expect_equal(dim(dataset2Std), c(2586,13))
})


test_that("unit conversion works", {
  
  pulldata("carabids")
  
})

test_that("factor level harmonizationworks", {
  
  pulldata("arthropodtraits")
  dd1 <- as.traitdata(arthropodtraits, traits = c("Body_Size", "Dispersal_ability", "Feeding_guild_short", "Feeding_mode"))
  dd1Std <- standardize_traits(dd1)
  
  expect_equal(dim(dd1Std), c(4920,9))
  expect_equal(sum(subset(dd1Std, traitName == "Body_Size")$traitValueStd), 5795.08)
})