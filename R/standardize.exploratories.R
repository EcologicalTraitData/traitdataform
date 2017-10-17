#' Standardize Georeference from Biodiversity Exploratories Plot ID
#' 
#' @description Adds columns of georeference to trait-data table if measurements relate to specimens from the Biodiversity Exploratories plots or regions. 
#' 
#' This function requires valid credentials for the Biodiversity Exploratories Information System (BExIS)!
#'
#' @param x A traitdata table of class 'traitdata'. 
#' @param ... If input is a rawdata table of type species-trait matrix or occurence table (wide table) then provide parameters according to `as.traitdata()`.
#' 
#' @return std
#' @export
#'
#' @import getPass
#' @examples
#' 
#' moths <- read.service(21247, dec = ",")
#' 
#' dataset1 <- as.traitdata(moths, taxa = "species", traits = c(body_mass =
#'     "weight", wing_length = "wing_length", wing_width = "wing_width", wing_area =
#'     "wing_area", wing_loading = "wing_loading"),
#'   keep = c(locationID = "plot"))
#' 
#' dataset1Std <- standardize.exploratories(dataset1)
#' 

standardize.exploratories <- function(x,
                        plots = "locationID",
                        user = NULL,
                        pswd = NULL,
                        ..., 
                        verbose = NULL,
                        warnings = NULL) {
  
  if("data.frame" %in% class(x) && ! "traitdata" %in% class(x) ) x <- as.traitdata(x,...)
  
  if(is.null(user)) user <- readline("user name: ") 
  if(is.null(pswd)) pswd <- getPass::getPass("password: ", noblank = FALSE)
  
  #basic <- read.service(1000, user = user, pswd = pswd)
  basic_ep <- read.service(20826, user = user, pswd = pswd)
  gridplots <- read.service(20907, user = user, pswd = pswd)
  
  EP_valid <- levels(basic_ep$EP_PlotID)
  Region_valid <- c("HAI", "ALB", "SCH")
  
  request <- unique(x[,plots])
  
  GP_vec <- basic_ep$PlotID[match(request, EP_valid)] 
  temp <- gridplots[match(GP_vec, gridplots$Plot_ID) , c("Plot_ID", "Exploratory", "Landuse", "Longitude_Dec_Plotcenter", "Latitude_Dec_Plotcenter")]
  temp$ExploratoriesPlotID <- request
  temp$ExploratoriesType <- temp$Landuse
  temp$OriginExploratories <- TRUE
  temp$habitat <- c("forest", "grassland")[temp$Landuse]
  temp$elevation <-  as.numeric(sub(",", ".", basic_ep$Elevation[match(request, basic_ep$EP_PlotID)]))
  temp$geodeticDatum <- "WGS84"
  temp$verbatimLocality <- basic_ep$LocalName[match(request, basic_ep$EP_PlotID)]
  temp$country <- "Germany"
  temp$countryCode <- "DE"
  
  out <- merge(x, subset(temp, select = -c(Landuse, Plot_ID)), by.x = plots, by.y = "ExploratoriesPlotID")
  
  # sort columns according to glossary of terms
  out <- out[, order(match(names(out), glossary$columnName) )]
  
  class(out) <- c("data.frame", "traitdata")
  return(out)
}
