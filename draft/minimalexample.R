# minimal example

# review raw data
head(carabids)

# bring into longtable format

dataset1 <- as.traitdata(carabids, 
                         taxa = "name_correct",
                         traits = c("body_length", "antenna_length", "metafemur_length", "eyewidth_corr"),
                         units = "mm",
                         datasetID = "carabidtraits",
                         keep = c(measurementDeterminedBy = "source_measurement")
                         )

head(dataset1)


# standardize taxonomy

dataset1std <- standardize.taxonomy(dataset1)
head(dataset1std)

# standardize traits

thesaurus <- as.thesaurus(body_length = as.trait("body_length", 
                                                 traitUnit = "mm", 
                                                 traitUnitStd = "mm", 
                                                 traitType = "numeric"),
                          antenna_length = as.trait("antenna_length", 
                                                 traitUnit = "mm", 
                                                 traitUnitStd = "mm", 
                                                 traitType = "numeric"),
                          metafemur_length = as.trait("metafemur_length", 
                                                 traitUnit = "mm", 
                                                 traitUnitStd = "mm", 
                                                 traitType = "numeric"),
                          eyewidth = as.trait("eyewidth_corr", 
                                                 traitUnitStd = "mm", 
                                                 traitType = "numeric")
            ) 
                          
str(traitmap)

dataset1std2 <- standardize.traits(dataset1std, thesaurus)

head(dataset1std2)

# all-in-one

traitdataset1 <- standardize(carabids,
            thesaurus = thesaurus,
            taxa = "name_correct",
            units = "mm",
            keep = c(measurementDeterminedBy = "source_measurement")
            )



