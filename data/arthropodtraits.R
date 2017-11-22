# for roxygen2 documentation please edit file R/data.R!

arthropodtraits <- utils::read.csv("http://datadryad.org/bitstream/handle/10255/dryad.76638/ArthropodSpeciesTraits.txt?sequence=1", 
                                   sep = "\t",
                                   fileEncoding = "latin1"
                                   )

attr(arthropodtraits, 'citeAs') <- utils::bibentry(
  bibtype = "Article",
  title = "A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and Araneae, occurring in grasslands in Germany.",
  journal = "Scientific Data",
  volume = 2,
  pages = 150013,
  author = c(utils::as.person("Martin M Gossner , Nadja K Simons, R Achtziger, T Blick, WHO Dorow, F Dziock, F Köhler, W Rabitsch, Wolfgang W Weisser")
  ),
  year = 2015,
  doi = "10.1038/sdata.2015.13"
)

print({cat("loading dataset 'arthropodtraits' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(arthropodtraits)$citeAs) })
