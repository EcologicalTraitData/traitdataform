# for roxygen2 documentation please edit file R/data.R!

carabids <- utils::read.table("http://datadryad.org/bitstream/handle/10255/dryad.134418/carabid%20traits%20final.txt", 
                              sep = "\t", 
                              header = TRUE,
                              fileEncoding = "UTF-8"
                              )

attr(carabids, 'metadata') <- as.metadata(
      datasetName = "Carabid traits",
      datasetID = "carabids",
      bibliographicCitation =  utils::bibentry(
        bibtype = "Article",
        title = "Sensitivity of functional diversity metrics to sampling intensity",
        journal = "Methods in Ecology and Evolution",
        author = c(utils::as.person("Fons van der Plas, Roel van Klink, Pete Manning, Han Olff, Markus Fischer")
        ),
        year = 2017,
        doi = "10.1111/2041-210x.12728"
      ),
      author = "Fons van der Plas", 
      license = "http://creativecommons.org/publicdomain/zero/1.0/"
       )

attr(carabids, 'thesaurus') <-  as.thesaurus(
          body_length = as.trait("body_length", 
                              expectedUnit = "mm", valueType = "numeric", 
                              identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Body_length"), 
          antenna_length = as.trait("antenna_length", 
                              expectedUnit = "mm", valueType = "numeric", 
                              identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Antenna_length"),
          metafemur_length = as.trait("femur_length", 
                              expectedUnit = "mm", valueType = "numeric", 
                              identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Femur_length"),
          eyewidth_corr = as.trait("eye_diameter", 
                              expectedUnit = "mm", valueType = "numeric",
                              identifier = "http://t-sita.cesab.org/BETSI_vizInfo.jsp?trait=Eye_diameter")
        )

print(attributes(carabids)$metadata)
