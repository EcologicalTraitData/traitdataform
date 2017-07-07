# minimal example

# read raw data

inputdata1 <- read.csv("../example_data/Orthoptera_MelanieChiste_flucAssym.csv")

head(inputdata1)

# bring into longtable format

out1 <- as.traitdata(inputdata1,
                     traits = c("length1", "body_length", "pronl1", "pronl2", "pronw1", "pronw2", "ov1", "ov2", "femurleft1", "femurright1", "femurleft2", "femurright2", "forewingleft1", "forewingright1", "forewingleft2", "forewingright2"),
                     taxa = "spec",
                     occurences = "nr",
                     datasetID = "CHISTE",
                     units = "mm",
                     keep = c("bz", locationID = "EP", sex = "sex", age =  "age", measurementDeterminedBy = "name")
)
head(out1)

# mapping columns to traitdata standard

out1mapped <- mapping(out1, replace = c(bz = "locationID", locationID = "ExploratoriesPlotID"))
head(out1mapped)

# standardize taxonomy 

out1taxonomy <- standardize.taxonomy(out1mapped)
head(out1taxonomy)

# standardize traits

traits1 <- thesaurus(read.csv("docs/traitlist_arthropods.csv"), replace = c(measurementType = "traitName", measurementTypeDescription = "traitDescription", measurementTypeID = "traitID", measurementValueType = "valueType", measurementUnit = "traitUnit") )

head(traits1)

out1taxtraits <- standardize.traits(out1taxonomy, traits1, traitmap = c(length1 ="body_length", body_length = "body_length", pronl1 = "pronothum_length", pronl2 = "pronothum_length", pronw1 = "pronothum_width", pronw2 = "pronothum_width", ov1 = "ovipositor_length", ov2 = "ovipositor_length", femurright1 = "femur_length", femurright2 = "femur_length", femurleft1 = "femur_length", femurleft2 = "femur_length", forewingleft1 = "wing_length" , forewingleft2 = "wing_length", forewingright1 = "wing_length", forewingright2 = "wing_length"))

head(out1taxtraits)

# all-in-one

traitdataset1 <- standardize(x = read.csv("../example_data/Orthoptera_MelanieChiste_flucAssym.csv"),
            traits = c("length1", "body_length", "pronl1", "pronl2", "pronw1", "pronw2", "ov1", "ov2", "femurleft1", "femurright1", "femurleft2", "femurright2", "forewingleft1", "forewingright1", "forewingleft2", "forewingright2"),
            taxa = "spec",
            occurences = "nr",
            units = "mm",
            keep = c("bz", locationID = "EP", sex = "sex", age =  "age", measurementDeterminedBy = "name"), 
            map = c(length1 ="body_length", body_length = "body_length", pronl1 = "pronothum_length", pronl2 = "pronothum_length", pronw1 = "pronothum_width", pronw2 = "pronothum_width", ov1 = "ovipositor_length", ov2 = "ovipositor_length", femurright1 = "femur_length", femurright2 = "femur_length", femurleft1 = "femur_length", femurleft2 = "femur_length", forewingleft1 = "wing_length" , forewingleft2 = "wing_length", forewingright1 = "wing_length", forewingright2 = "wing_length")
            thesaurus = thesaurus(read.csv("docs/traitlist_arthropods.csv"), replace = c(measurementType = "traitName", measurementTypeDescription = "traitDescription", measurementTypeID = "traitID", measurementValueType = "valueType") )
)
