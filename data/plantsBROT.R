
temp <- tempfile(fileext = ".zip")
utils::download.file("https://ndownloader.figshare.com/articles/3531092/versions/1", temp, method = "auto", quiet = TRUE, mode="wb")
utils::unzip(temp, files = "BROT_2008.11.txt", exdir = ".")
unlink(temp)
rm(temp)

BROT <- utils::read.table("BROT_2008.11.txt", header = T, sep="\t")
file.remove("BROT_2008.11.txt")

attr(BROT, 'citeAs') <- utils::bibentry(
  bibtype = "Article",
  title = "Fire-related traits for plant species of the Mediterranean Basin",
  journal = "Ecology",
  volume = 90,
  pages = 1420,
  author = utils::as.person("Paula, S., Arianoutsou, M., Kazanis, D., Tavsanoglu, Ç., Lloret, F., Buhk, C., Ojeda, F., Luna, B., Moreno, J. M., Rodrigo, A., Espelta, J. M., Palacio, S., Fernández-Santos, B., Fernandes, P. M. and Pausas, J. G."),
  year = 2009,
  doi = "10.1890/08-1309.1"
)
print({cat("loading dataset 'BROT' from original data source! \n When using this data, please cite the original publication: \n") 
  (attributes(BROT)$citeAs) })