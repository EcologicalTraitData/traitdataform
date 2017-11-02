pantheria <- utils::read.csv("http://esapubs.org/archive/ecol/E090/184/PanTHERIA_1-0_WR05_Aug2008.txt", sep = "\t")

attr(pantheria, 'citeAs') <- utils::bibentry(
  bibtype = "Article",
  title = "PanTHERIA: a species-level database of life history, ecology, and geography of extant and recently extinct mammals",
  journal = "Ecology",
  volume = 90,
  pages = 2648,
  author = c(utils::person(given = "Kate E.", family = "Jones", email = "Kate.Jones@ioz.ac.uk"), utils::as.person("Jon Bielby, Marcel Cardillo, Susanne A. Fritz, Justin O'Dell, C. David L. Orme, Kamran Safi, Wes Sechrest, Elizabeth H. Boakes, Chris Carbone, Christina Connolly, Michael J. Cutts, Janine K. Foster, Richard Grenyer, Michael Habib, Christopher A. Plaster, Samantha A. Price, Elizabeth A. Rigby, Janna Rist, Amber Teacher, Olaf R. P. Bininda-Emonds, John L. Gittleman, Georgina M. Mace, and Andy Purvis")
  ),
  year = 2009,
  doi = "10.1890/08-1494.1"
)
print({cat("loading dataset 'pantheria' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(pantheria)$citeAs) })
