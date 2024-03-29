#' Pull trait data from the internet
#'
#' This function sources a recipe for extracting public trait data. 
#' 
#' @details The package 'traitdataform' comes with a collection of recipes for public trait data. These R-scripts  
#' 
#'   1. define how to read the file from an online source, i.e. a URL to a txt, xlsx, or a ZIP archive
#'   2. assigns metadata attributes about authorship, license and original publication
#'   3. provide parameters for the standardize() function, i.e. a trait thesaurus, mappings and units. 
#'  
#'   New recipes can be suggested as a pull requrest via the package development page (https://github.com/EcologicalTraitData/traitdataform). 
#'  
#' @param x the dataset to source. Leave empty for full list of available datasets.
#' @return Makes a raw dataset available in R according to instructions provided by dataset function.
#'
#' @family rawdata
#' @import suppdata
#' @export
#' @author Florian D. Schneider
#' @examples
#' 
#' # to get a list of all available data within the package 
#' pulldata() 
#' 
#' # to import a dataset
#' pulldata("carabids")

pulldata <- function(x = NULL) {
  
  libpath <- system.file( "extdata", "carabids.R", package="traitdataform")
  available <- sub(".R", "", dir(sub("carabids.R", "", libpath)))
  
  if(is.null(x) || !x %in% available) {
    cat("Please choose a trait dataset to import! the following trait datasets are available: \n \t")
    cat(paste(available, collapse = "\n \t"))
    cat("\n")
  } else {
    
    tryCatch( source(system.file( "extdata", paste0(x,".R"), package="traitdataform")),
              warning = function(war) {
                message("Direct call to data source failed. Please check internet connectivity and re-load data!")
              },
              error = function(err) {
                message("Direct call to data source failed. Please check internet connectivity and re-load data!")
              } )
    
    if(exists(x))  message(paste0("The dataset '", x, "' has successfully been downloaded! \n" ) )

  } 
    
}


#' @title Functional Arthropod Traits
#' 
#' @name arthropodtraits
#' 
#' @description Data from: A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and
#' Araneae, occurring in grasslands in Germany.
#' 
#' @format A data frame of 1230 observations and 17 variables.
#' \describe{
#'   \item{Order}{}
#'   \item{Suborder}{}
#'   \item{Family}{}
#'   \item{SpeciesID}{}
#'   \item{Author}{}
#'   \item{Body_Size}{Mean body length (mm)}
#'   \item{Dispersal_ability}{ordinal scale of 0 = very low, 1 = low, 0,5 =
#'   medium, 0,75 = high, 1 = very high; Based on wing dimorphism, flying
#'   ability, activity ranges, dispersal strategies, individual movement and
#'   colonization dynamics, depending on taxon }
#'   \item{Feeding_guild}{Fine classification of feeding guild across larval and
#'   adult stages; less frequent assignments in brackets.
#'     \describe{
#'       \item{c}{carnivore}
#'       \item{c-d}{carni-detritivore}
#'       \item{c-d-h}{carni-detriti-herbivore}
#'       \item{c-f}{carni-fungivore}
#'       \item{c-h}{carni-herbivore}
#'       \item{c-(h)}{mainly carnivore, rarely herbivore}
#'       \item{d}{detritivor}
#'       \item{d-f}{detriti-fungivore}
#'       \item{d-h}{detriti-herbivore}
#'       \item{f}{fungivore}
#'       \item{f-h}{fungi-herbivore}
#'       \item{h}{herbivor}
#'       \item{h-(c)}{mainly herbivore, rarely carnivore}
#'     }
#'    }
#'   \item{Feeding_guild_short}{Coarse classification of feeding guild, indicating main feeding source across larval and adult stages}
#'   \item{Feeding_mode}{The way nutrients are ingested}
#'   \item{Feeding_specialization}{Host plant specialization in herbivores}
#'   \item{Feeding_tissue}{Fine classification on the plant tissues sucking herbivores are feeding on}
#'   \item{Feeding_plant_part}{Fine classification on the plant parts chewing herbivores are feeding on}
#'   \item{Endophagous_lifestyle}{Details on endophagously living larvae}
#'   \item{Stratum_use}{Vertical strata used across larval and adult stages; less frequent assignments in brackets}
#'   \item{Stratum_use_short}{Main vertical stratum used across larval and adult stages}
#'   \item{Remark}{Indicates species that do neither obligatory nor facultative occur in grasslands; * = non grasland species}
#' 
#' } 
#' 
#' original description: https://www.nature.com/articles/sdata201513/tables/3
#' 
#' 
#' @details Analyses of species traits have increased our understanding of how
#'   environmental drivers such as disturbances affect the composition of
#'   arthropod communities and related processes. There are, however, few
#'   studies on which traits in the arthropod community are affected by
#'   environmental changes and which traits affect ecosystem functioning. The
#'   assembly of arthropod traits of several taxa is difficult because of the
#'   large number of species, limited availability of trait databases and
#'   differences in available traits. We sampled arthropod species data from a
#'   total of 150 managed grassland plots in three regions of Germany. These
#'   plots represent the spectrum from extensively used pastures to mown
#'   pastures to intensively managed and fertilized meadows. In this paper, we
#'   summarize information on body size, dispersal ability, feeding guild and
#'   specialization (within herbivores), feeding mode, feeding tissue (within
#'   herbivorous suckers), plant part (within herbivorous chewers), endophagous
#'   lifestyle (within herbivores), and vertical stratum use for 1,230 species
#'   of Coleoptera, Hemiptera (Heteroptera, Auchenorrhyncha), Orthoptera
#'   (Saltatoria: Ensifera, Caelifera), and Araneae, sampled by sweep-netting
#'   between 2008 and 2012. We compiled traits from various literature sources
#'   and complemented data from reliable internet sources and the authors’
#'   experience.
#'   
#'   The data set comprises literature trait data of species that were sampled
#'   and measured in a project within the Biodiversity Exploratories which
#'   focuses on the effect of land use on arthropod community composition and
#'   related processes (e.g. species interactions such as herbivory or
#'   predation) in three regions of Germany
#'   
#' @details When using this data, please cite the original publication:
#' 
#'   \itemize{ \item  Gossner MM, Simons NK, Achtziger R, Blick T, Dorow WHO,
#'   Dziock F, Köhler F, Rabitsch W, Weisser WW (2015) A summary of eight traits
#'   of Coleoptera, Hemiptera, Orthoptera and Araneae, occurring in grasslands
#'   in Germany. Scientific Data 2: 150013.
#'   \doi{10.1038/sdata.2015.13} }
#'   
#'   Additionally, please cite the Dryad data package:
#'   
#'   \itemize{ \item  Gossner MM, Simons NK, Achtziger R,
#'   Blick T, Dorow WHO, Dziock F, Köhler F, Rabitsch W, Weisser WW (2015) Data
#'   from: A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and
#'   Araneae, occurring in grasslands in Germany. Dryad Digital Repository.
#'   \doi{10.5061/dryad.53ds2} }
#'   
#' @return This is a data object. provides instructions for `pulldata()`.
#' @author Gossner MM, Simons NK, Achtziger R, Blick T, Dorow WHO, Dziock F, Köhler F, Rabitsch W, Weisser WW
#' 
#' @family rawdata
#' 
#' @source \doi{10.5061/dryad.53ds2};
#'   \href{https://creativecommons.org/publicdomain/zero/1.0/}{Creative Commons
#'   0}. To the extent possible under law, the authors have waived all copyright
#'   and related or neighboring rights to this data.

NULL

# ----------------------------------------------------------------

#' @title Carabid morphological traits
#'
#' @name carabids
#' 
#' @description Average body measures of 120 Carabid species occuring in the Netherlands.
#'
#' @author Fons van der Plas, R. van Klink, P. Manning, H. Olff, M. Fischer
#'
#' @details When using this data, please cite the original publication:
#'
#'   \itemize{ \item  van der Plas F, van Klink R, Manning P, Olff H, Fischer M
#'   (2017) Sensitivity of functional diversity metrics to sampling intensity.
#'   Methods in Ecology and Evolution 8(9): 1072-1080.
#'   doi: \doi{10.1111/2041-210x.12728} }
#'
#'   Additionally, please cite the Dryad data package:
#'
#'   \itemize{ \item van der Plas F, van Klink R, Manning P, Olff H, Fischer M
#'   (2017) Data from: Sensitivity of functional diversity metrics to sampling
#'   intensity. Dryad Digital Repository. doi: \doi{10.5061/dryad.1fn46} }
#'
#' @return This is a data object. provides instructions for `pulldata()`.
#' 
#' @format A data frame containing following columns:
#'   \itemize{ 
#'     \item name_correct = species name
#'     \item source_measurement = researcher who performed measurement; 
#'     \item body_length = body length in mm; 
#'     \item antenna_length = antenna length in mm; 
#'     \item metafemur_length = length metafemur in mm;
#'     \item eyewidth_corr = eye width in mm; 
#'     \item note = note; 
#'     \item resid_femur = residual femur length in mm (i.e. residual from 
#'        linear model in which femur length is explained by body length); 
#'     \item resid_eye = residual eye length in mm (i.e. residual from linear 
#'        model in which eye length is explained by body length)
#'     \item resid_antenna = residual antenna length in mm (i.e. residual 
#'        from linear model in which antenna length is explained by body length)
#'   }
#'
#' @family rawdata
#' 
#' @source \doi{10.5061/dryad.53ds2};
#'   \href{https://creativecommons.org/publicdomain/zero/1.0/}{Creative Commons
#'   0}. To the extent possible under law, the authors have waived all copyright
#'   and related or neighboring rights to this data.

NULL

# -------------------------------------------------------------------

#' Heteroptera morphometry traits
#'
#' Morphometric measures of Heteroptera sampled in grasslands across three
#' regions of Germany.
#'
#' @name heteroptera_raw
#'     
#' @author Martin M. Gossner , Nadja K. Simons, Leonhard Höck, Wolfgang W.
#'   Weisser
#'
#' @source \url{https://figshare.com/articles/dataset/Data_Paper_Data_Paper/3561936};
#'   \href{https://creativecommons.org/publicdomain/zero/1.0/}{Creative Commons
#'   0}. To the extent possible under law, the authors have waived all copyright
#'   and related or neighboring rights to this data.
#'
#' @details Trait-based approaches have increased significantly in community
#'   ecology during the last decade. This is not least because studies on
#'   biodiversity-ecosystem functioning relationships became a major topic in
#'   ecology. Species' functions in ecosystems are mediated by their traits. For
#'   a better understanding of the relationships between environmental drivers,
#'   the community composition of organisms and ecosystems functioning, it is
#'   crucial to understand how these relationships are mediated by the
#'   communities' trait composition. While there are world-wide efforts to set
#'   up trait databases, most have so far focused on plants and species-poorer
#'   taxa such as birds or amphibians. In contrast, for insects, the large
#'   number of species makes the gathering of comparable trait data a
#'   challenging task. In addition, there is the danger that generic trait
#'   information, which is available from common textbooks, may not be
#'   sufficient to detect the response of insect communities to environmental
#'   change or the consequences of trait changes for ecosystem functioning. One
#'   method to overcome this is to take morphometric measurements of species. In
#'   this study we measured morphometric traits of a total of 179 Heteroptera
#'   species that were sampled by sweep-netting on a total of 150 managed
#'   grassland plots across three regions in Germany between 2008 and 2012.
#'   These plots represent the whole range of grassland management intensities
#'   from extensively used pastures to mown pastures to intensively managed and
#'   fertilized meadows. In this paper we provide a database of mean values of
#'   23 morphometric measures across sex and morphotypes for each sampled
#'   Heteroptera species. Morphological traits are assumed to be related to
#'   their adaptation and function in the environment. Thus the relative
#'   morphometric traits can be used as proxies for ecological features of a
#'   species that may affect its performance or fitness. Our database can be
#'   used by future trait-based studies for developing and testing hypotheses of
#'   the functional significance of these traits. Examples include studying the
#'   functional responses of insect communities to environmental drivers or
#'   studying how the change in trait composition affects ecosystem processes.
#' @return The dataset \code{heteroptera_raw} contains multiple observations of
#'   each species (occurence table). The dataset \code{heteroptera} is a
#'   compiled species-trait matrix.
#'
#' @return Returns a data object that includes attributes for data standardisation.
#' 
#' @section Citation: Cite this dataset as 
#'  
#' -  Gossner, M. M., N. K. Simons, L. Höck, and W. W. Weisser. 2015.
#' Morphometric measures of Heteroptera sampled in grasslands across three
#' regions of Germany. Ecology 96:1154-1154.
#' - Data publication: Gossner, M.M, Simons, N.K., Höck, L., Weisser, W.W., 
#'   2016. Morphometric measures of Heteroptera sampled in grasslands across three
#'   regions of Germany. figshare. \doi{10.6084/m9.figshare.c.3307611.v1} 
#'
#' @family rawdata

NULL

#' @rdname heteroptera_raw
#' @family rawdata
#' @name heteroptera

NULL

# -------------------------------------------------------------------

#' Amniote life-history traits
#' 
#' @name amniota
#' 
#' @description An amniote life-history database to perform comparative analyses
#'   with birds, mammals, and reptiles, Ecological Archives E096-269
#'   
#' @author Nathan P. Myhrvold, Elita Baldridge, Benjamin Chan, Dhileep Sivam,
#'   Daniel L. Freeman, and S. K. Morgan Ernest
#'   
#' @source Cite this dataset as \itemize{ \item P. Myhrvold, Nathan; Baldridge,
#'   Elita; Chan, Benjamin; Sivam, Dhileep; L. Freeman, Daniel; Ernest, S. K.
#'   Morgan (2016): An amniote life-history database to perform comparative
#'   analyses with birds, mammals, and reptiles.
#'   http://esapubs.org/archive/ecol/E096/269/}
#'   
#'   \href{https://creativecommons.org/publicdomain/zero/1.0/}{Creative Commons 
#'   0}. To the extent possible under law, the authors have waived all copyright
#'   and related or neighboring rights to this data.
#'   
#' @details Studying life-history traits within and across taxonomic
#'   classifications has revealed many interesting and important patterns, but
#'   this approach to life history requires access to large compilations of data
#'   containing many different life-history parameters. Currently, life-history
#'   data for amniotes (birds, mammals, and reptiles) is split among a variety
#'   of publicly available databases, data tables embedded in individual papers
#'   and books, and species-specific studies by experts. Using data from this
#'   wide range of sources is a challenge for conducting macroecological studies
#'   because of a lack of standardization in taxonomic classifications,
#'   parameter values, and even in which parameters are reported. In order to
#'   facilitate comparative analyses between amniote life-history data, we
#'   created a database compiled from peer-reviewed studies on individual
#'   species, macroecological studies of multiple species, existing life-history
#'   databases, and other aggregated sources as well as published books and
#'   other compilations. First, we extracted and aggregated the raw data from
#'   the aforementioned sources. Next, we resolved spelling errors and other
#'   formatting inconsistencies in species names through a number of
#'   computational and manual methods. Once this was completed, subspecies-level
#'   data and species-level data were shared via a data-sharing algorithm to
#'   accommodate the variety of species transformations (taxonomic promotions,
#'   demotions, merges, divergences, etc.) that have occurred over time.
#'   Finally, in species where multiple raw data points were identified for a
#'   given parameter, we report the median value. Here, we report a normalized
#'   and consolidated database of up to 29 life-history parameters, containing
#'   at least one life-history parameter for 21 322 species of birds, mammals,
#'   and reptiles.
#'   
#' @return Returns a data object that includes attributes for data standardisation.
#'   
#' @family rawdata

NULL

# ----------------------------------------------------------------------------

#' PanTHERIA mammal traits
#' 
#' @name pantheria
#'  
#' @description Here we describe a global species-level data set of key
#'   life-history, ecological and geographical traits of all known extant and
#'   recently extinct mammals (PanTHERIA) developed for a number of
#'   macroecological and macroevolutionary research projects.
#'   
#' @author Kate E. Jones, Jon Bielby, Marcel Cardillo, Susanne A. Fritz, Justin
#'   O'Dell, C. David L. Orme, Kamran Safi, Wes Sechrest, Elizabeth H. Boakes,
#'   Chris Carbone, Christina Connolly, Michael J. Cutts, Janine K. Foster,
#'   Richard Grenyer, Michael Habib, Christopher A. Plaster, Samantha A. Price,
#'   Elizabeth A. Rigby, Janna Rist, Amber Teacher, Olaf R. P. Bininda-Emonds,
#'   John L. Gittleman, Georgina M. Mace, and Andy Purvis.
#' 
#' @details Data were gathered from the literature for 25 types of ecological
#'   and life history information for any extant or recently extinct species
#'   within class Mammalia (100740 data lines): 
#'   
#'   1. Activity Cycle; 2. Age at Eye Opening; 3. Age at First Birth; 4. Average
#'   Lifespan; 5. Body Mass; 6. Diet; 7. Dispersal Age; 8. Adult Limb Length; 9.
#'   Gestation Length; 10. Group Composition & Size; 11. Growth Data; 12.
#'   Habitat Layer; 13. Head-Body Length; 14. Interbirth Interval; 15. Litter
#'   size; 16. Litters Per Year; 17. Maximum Longevity; 18. Metabolic Rate; 19.
#'   Migratory Behaviour; 20. Mortality Data;  21. Population Density; 22.
#'   Ranging Behaviour; 23. Sexual
#'   Maturity Age; 24. Teat Number; and 25. Weaning Age.
#'   
#'   30 specific variables (see Class IV, Table 1) were extracted from the above
#'   data types for PanTHERIA from a total of 94729 data lines (before error
#'   checking). Additionally, 4 variables were derived from extracted variables
#'   within PanTHERIA and 19 variables were calculated from other spatial data
#'   sources (see Class V, Section C).
#'   
#'   see \doi{10.6084/m9.figshare.c.3301274.v1} for further
#'   information.
#'   
#' @return Returns a data object that includes attributes for data standardisation.
#'   
#' @source Cite as:
#'   
#'   E. Jones, Kate; Bielby, Jon; Cardillo, Marcel; A. Fritz, Susanne; O'Dell,
#'   Justin; David L. Orme, C.; Safi, Kamran; Sechrest, Wes; H. Boakes,
#'   Elizabeth; Carbone, Chris; Connolly, Christina; Cutts, Michael J.; Foster,
#'   Janine K.; Grenyer, Richard; Habib, Michael; Plaster, Christopher A.;
#'   Price, Samantha A.; Rigby, Elizabeth A.; Rist, Janna; Teacher, Amber;
#'   Bininda-Emonds, Olaf R. P.; Gittleman, John L.; M. Mace, Georgina; Purvis,
#'   Andy (2016): PanTHERIA: a species-level database of life history, ecology,
#'   and geography of extant and recently extinct mammals.
#'   \doi{10.1890/08-1494.1};
#'   
#'   \href{https://creativecommons.org/publicdomain/zero/1.0/}{Creative Commons
#'   0}. To the extent possible under law, the authors have waived all copyright
#'   and related or neighboring rights to this data.
#'   
#' @family rawdata

NULL

# ----------------------------------------------------------------------------

#' Mammal diet database
#' 
#' @name mammaldiet
#' 
#' 
#' @description A comprehensive global dataset of diet preferences of mammals 
#'   ('MammalDIET'). Diet information was digitized from the literature and 
#'   extrapolated for species with missing information. The original and 
#'   extrapolated data cover species-level diet information for >99% of all 
#'   terrestrial mammals.
#'   
#' @source Cite this dataset as:
#'   
#'   - Kissling, W.D., Dalby, L., Fløjgaard, C., Lenoir, J., Sandel, B., Sandom,
#'   C., Trøjelsgaard, K., Svenning, J. (2014). Establishing macroecological 
#'   trait datasets: digitalization, extrapolation, and validation of diet 
#'   preferences in terrestrial mammals worldwide. Ecol Evol, 4, 2913-2930. 
#'   \doi{10.1002/ece3.1136}
#'   
#'   Additionally, please cite the Dryad data package:
#'   
#'   - Kissling WD, Dalby L, Fløjgaard C, Lenoir J, Sandel B, Sandom C, 
#'   Trøjelsgaard K, Svenning J-C (2014) Data from: Establishing macroecological
#'   trait datasets: digitalization, extrapolation, and validation of diet 
#'   preferences in terrestrial mammals worldwide. Dryad Digital Repository. 
#'   \doi{10.5061/dryad.6cd0v}
#'   
#'   \href{https://creativecommons.org/publicdomain/zero/1.0/}{Creative Commons 
#'   0}. To the extent possible under law, the authors have waived all copyright
#'   and related or neighboring rights to this data.
#'   
#' @details Ecological trait data are essential for understanding the 
#'   broad-scale distribution of biodiversity and its response to global change.
#'   For animals, diet represents a fundamental aspect of species' evolutionary 
#'   adaptations, ecological and functional roles, and trophic interactions. 
#'   However, the importance of diet for macroevolutionary and macroecological 
#'   dynamics remains little explored, partly because of the lack of 
#'   comprehensive trait datasets. We compiled and evaluated a comprehensive 
#'   global dataset of diet preferences of mammals (“MammalDIET”). Diet 
#'   information was digitized from two global and cladewide data sources and 
#'   errors of data entry by multiple data recorders were assessed. We then 
#'   developed a hierarchical extrapolation procedure to fill-in diet 
#'   information for species with missing information. Missing data were 
#'   extrapolated with information from other taxonomic levels (genus, other 
#'   species within the same genus, or family) and this extrapolation was 
#'   subsequently validated both internally (with a jack-knife approach applied 
#'   to the compiled species-level diet data) and externally (using independent 
#'   species-level diet information from a comprehensive continentwide data 
#'   source). Finally, we grouped mammal species into trophic levels and dietary
#'   guilds, and their species richness as well as their proportion of total 
#'   richness were mapped at a global scale for those diet categories with good 
#'   validation results. The success rate of correctly digitizing data was 94%, 
#'   indicating that the consistency in data entry among multiple recorders was 
#'   high. Data sources provided species-level diet information for a total of 
#'   2033 species (38% of all 5364 terrestrial mammal species, based on the IUCN
#'   taxonomy). For the remaining 3331 species, diet information was mostly 
#'   extrapolated from genus-level diet information (48% of all terrestrial 
#'   mammal species), and only rarely from other species within the same genus 
#'   (6%) or from family level (8%). Internal and external validation showed 
#'   that: (1) extrapolations were most reliable for primary food items; (2) 
#'   several diet categories (“Animal,” “Mammal,” “Invertebrate,” “Plant,” 
#'   “Seed,” “Fruit,” and “Leaf”) had high proportions of correctly predicted 
#'   diet ranks; and (3) the potential of correctly extrapolating specific diet 
#'   categories varied both within and among clades. Global maps of species 
#'   richness and proportion showed congruence among trophic levels, but also 
#'   substantial discrepancies between dietary guilds. MammalDIET provides a 
#'   comprehensive, unique and freely available dataset on diet preferences for 
#'   all terrestrial mammals worldwide. It enables broad-scale analyses for 
#'   specific trophic levels and dietary guilds, and a first assessment of trait
#'   conservatism in mammalian diet preferences at a global scale. The 
#'   digitalization, extrapolation and validation procedures could be 
#'   transferable to other trait data and taxa.
#'   
#' @return This is a data object. provides instructions for `pulldata()`.
#'   
#' @author Kissling, W.D., Dalby, L., Fløjgaard, C.,
#'   Lenoir, J., Sandel, B., Sandom, C., Trøjelsgaard, K., Svenning, J.
#'   
#' @family rawdata

NULL

# -----------------------------------------------------------------------------

#' AmphiBIO, a global database for amphibian ecological traits
#' 
#' @name amphibio 
#' 
#' @description A comprehensive database of natural history traits for amphibians worldwide. 
#' 
#' @author Brunno Freire Oliveira, Vinícius Avelar São-Pedro, Georgina Santos-Barrera, Caterina Penone, and Gabriel C. Costa
#' 
#' @details Current ecological and evolutionary research are increasingly moving from species- to trait-based approaches because traits provide a stronger link to organism’s function and fitness. Trait databases covering a large number of species are becoming available, but such data remains scarce for certain groups. Amphibians are among the most diverse vertebrate groups on Earth, and constitute an abundant component of major terrestrial and freshwater ecosystems. They are also facing rapid population declines worldwide, which is likely to affect trait composition in local communities, thereby impacting ecosystem processes and services. In this context, we introduce AmphiBIO, a comprehensive database of natural history traits for amphibians worldwide. The database releases information on 17 traits related to ecology, morphology and reproduction features of amphibians. We compiled data from more than 1,500 literature sources, and for more than 6,500 species of all orders (Anura, Caudata and Gymnophiona), 61 families and 531 genera. This database has the potential to allow unprecedented large-scale analyses in ecology, evolution and conservation of amphibians.
#' 
#' @source Cite as: 
#' 
#'   - Oliveira, B.F., São-Pedro, V.A., Santos-Barrera, G., Penone, C. & Costa, G.C. (2017). AmphiBIO, a global database for amphibian ecological traits. Scientific Data, 4:170123. doi: \doi{10.1038/sdata.2017.123}
#'   
#'   Please also cite the data repository on figshare: 
#'   
#'   - Oliveira, Brunno Freire; São-Pedro, Vinícius Avelar; Santos-Barrera, Georgina; Penone, Caterina; C. Costa, Gabriel (2017): AmphiBIO_v1. figshare. \doi{10.6084/m9.figshare.4644424.v5}
#'   
#'   \href{https://creativecommons.org/licenses/by/4.0/}{Creative Commons BY 4.0}. You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use. 
#'   
#' @return This is a data object. provides instructions for `pulldata()`.
#'   
#' 
#' @family rawdata

NULL

