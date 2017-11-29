#' Functional Arthropod Traits
#'
#' Data from: A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and
#' Araneae, occurring in grasslands in Germany.
#'
#' @details When using this data, please cite the original publication:
#' 
#'   \itemize{ \item  Gossner MM, Simons NK, Achtziger R, Blick T, Dorow WHO,
#'   Dziock F, Köhler F, Rabitsch W, Weisser WW (2015) A summary of eight traits
#'   of Coleoptera, Hemiptera, Orthoptera and Araneae, occurring in grasslands
#'   in Germany. Scientific Data 2: 150013.
#'   http://dx.doi.org/10.1038/sdata.2015.13 }
#'   
#'   Additionally, please cite the Dryad data package:
#'   
#'   \itemize{ \item  Gossner MM, Simons NK, Achtziger R,
#'   Blick T, Dorow WHO, Dziock F, Köhler F, Rabitsch W, Weisser WW (2015) Data
#'   from: A summary of eight traits of Coleoptera, Hemiptera, Orthoptera and
#'   Araneae, occurring in grasslands in Germany. Dryad Digital Repository.
#'   http://dx.doi.org/10.5061/dryad.53ds2 }
#'   
#' @author Gossner MM, Simons NK, Achtziger R, Blick T, Dorow WHO, Dziock F, Köhler F, Rabitsch W, Weisser WW
#' 
#' @family rawdata
#' 
#' @source \url{http://dx.doi.org/10.5061/dryad.53ds2};
#'   \href{http://creativecommons.org/publicdomain/zero/1.0/}{Creative Commons
#'   0}. To the extent possible under law, the authors have waived all copyright
#'   and related or neighboring rights to this data.
"arthropodtraits"

# ----------------------------------------------------------------

#' @title Carabid morphological traits
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
#'   https://doi.org/10.1111/2041-210x.12728 }
#'
#'   Additionally, please cite the Dryad data package:
#'
#'   \itemize{ \item van der Plas F, van Klink R, Manning P, Olff H, Fischer M
#'   (2017) Data from: Sensitivity of functional diversity metrics to sampling
#'   intensity. Dryad Digital Repository. https://doi.org/10.5061/dryad.1fn46 }
#' 
#' @format A data frame containing following columns:
#'   \itemize{ 
#'     \item name_correct = species name
#'     \item source_measurement = researcher who performed measurement; 
#'     \item body_length = body length in mm; 
#'     \item antenna_length = antenna length in mm; 
#'     \item metafemur_length = length metafemur in mm;
#'     \item eyewith_corr = eye width in mm; 
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
#' @source \url{http://dx.doi.org/10.5061/dryad.53ds2};
#'   \href{http://creativecommons.org/publicdomain/zero/1.0/}{Creative Commons
#'   0}. To the extent possible under law, the authors have waived all copyright
#'   and related or neighboring rights to this data.
"carabids"

# -------------------------------------------------------------------

#' Heteroptera morphometry traits
#' 
#' Morphometric measures of Heteroptera sampled in grasslands across three
#' regions of Germany.
#' 
#' @author Martin M. Gossner , Nadja K. Simons, Leonhard Höck, Wolfgang W.
#'   Weisser
#'   
#' @details When using this data, please cite the original publication:
#'
#'   \itemize{ \item  M. Gossner, Martin; K. Simons,
#'   Nadja; Höck, Leonhard; W. Weisser, Wolfgang (2016): Morphometric measures
#'   of Heteroptera sampled in grasslands across three regions of Germany.
#'   figshare. https://doi.org/10.6084/m9.figshare.c.3307611.v1}
#'   
#' @format The dataset \code{heteropteraRaw} contains multiple observations of
#'   each species (occurence table). The dataset \code{heteroptera} is a
#'   compiled species-trait matrix. For column definitions please see:
#'   \url{https://figshare.com/articles/Data_Paper_Data_Paper/3561936}
#'   
#'   Description: The data sets comprise morphometric trait data of species that
#'   were sampled and measured within the a subproject of the Biodiversity
#'   Exploratories Project (Fischer et al. 2010) which focuses on the  effect of
#'   land use on arthropod community composition and related processes in three
#'   regions of Germany (Gossner et al. 2014, Simons et al. 2014, Simons et al.
#'   2015).
#'   
#'   
#' @family rawdata
#' 
"heteroptera_raw"
"heteroptera"

# -------------------------------------------------------------------

#' Amniote life-history traits
#' 
#' @description An amniote life-history database to perform comparative analyses
#'   with birds, mammals, and reptiles, Ecological Archives E096-269
#'   
#' @author Nathan P. Myhrvold, Elita Baldridge, Benjamin Chan, Dhileep Sivam,
#'   Daniel L. Freeman, and S. K. Morgan Ernest
#'   
#' @details When using this data, please cite the original publication:
#' 
#' \itemize{ \item P. Myhrvold, Nathan; Baldridge,
#'   Elita; Chan, Benjamin; Sivam, Dhileep; L. Freeman, Daniel; Ernest, S. K.
#'   Morgan (2016): An amniote life-history database to perform comparative
#'   analyses with birds, mammals, and reptiles.
#'   http://esapubs.org/archive/ecol/E096/269/}
#'   
#'   Column names:
#'   \itemize{ 
#'     \item class = The taxonomic class designation for the corresponding data entry;
#'     \item order = The taxonomic order designation for the corresponding data entry; 
#'     \item family = The taxonomic family designation for the corresponding data entry; 
#'     \item genus = The taxonomic genus designation for the corresponding data entry;
#'     \item species = The taxonomic species designation for the corresponding data entry;
#'     \item subspecies = The taxonomic subspecies designation for the corresponding data entry;
#'     \item common_name = The common name for the corresponding data entry;
#'     \item female_maturity_d = The amount of time it takes for a female individual to reach maturity in days;
#'     \item litter_or_clutch_size_n = The size of the litter/clutch;
#'     \item litters_or_clutches_per_y = The number of litters/clutches produced per year;
#'     \item adult_body_mass_g = The body mass of an adult individual in grams;
#'     \item maximum_longevity_y = The longest lifespan reported of the species in years;
#'     \item gestation_d = The time between conception and birth in days;
#'     \item weaning_d = The amount of time it takes to wean the offspring in days;
#'     \item birth_or_hatching_weight_g = The weight at birth/hatching in grams;
#'     \item weaning_weight_g = The weight at weaning in grams;
#'     \item egg_mass_g = The mass of the egg in grams;
#'     \item fledging_age_d = The time between when the egg is laid and when it hatches in days;
#'     \item incubation_d = The time it takes for the bird to be capable of flight (or for some species, leaving the nest) in days;
#'     \item longevity_y = The lifespan of an individual in years;
#'     \item male_maturity_d = The amount of time it takes for a male individual to reach maturity in days;
#'     \item inter_litter_or_interbirth_interval_y = The time between the reproduction cycles in years;
#'     \item female_body_mass_g = The body mass of a female individual in grams;
#'     \item male_body_mass_g = The body mass of a male individual in grams;
#'     \item no_sex_body_mass_g = The body mass of an individual of unreported sex in grams;
#'     \item egg_width_mm = The width of the egg in millimeters;
#'     \item egg_length_mm = The length of the egg in millimeters;
#'     \item fledging_mass_g = The mass of a fledging in grams;
#'     \item adult_svl_cm = The snout-to-vent length of an adult individual in centimeters;
#'     \item male_svl_cm = The snout-to-vent length of a male individual in centimeters;
#'     \item female_svl_cm = The snout-to-vent length of a female individual in centimeters;
#'     \item birth_or_hatching_svl_cm = The snout-to-vent length of a newly-hatched individual in centimeters;
#'     \item female_svl_at_maturity_cm = The snout-to-vent length of a female individual at maturity in centimeters;
#'     \item female_body_mass_at_maturity_g = The body mass of a female individual at maturity in grams;
#'     \item no_sex_svl_cm = The snout-to-vent length of an individual of unreported sex in centimeters;
#'     \item no_sex_maturity_d = The amount of time it takes for an individual of unreported sex to reach maturity in days;
#'     \item taxa = The taxonomic genus and species designation for the corresponding data entry;
#'   }
#'   
#'   Description:
#'   Studying life-history traits within and across taxonomic
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
#' @source \url{https://doi.org/10.6084/m9.figshare.c.3308127.v1};
#'   \href{http://creativecommons.org/publicdomain/zero/1.0/}{Creative Commons
#'   0}. To the extent possible under law, the authors have waived all copyright
#'   and related or neighboring rights to this data.
#'   
#' @family rawdata
"amniota"

# ----------------------------------------------------------------------------

#' PanTHERIA 1.0 mammal traits
#' 
#' @description A global species-level data set of key
#'   life-history, ecological and geographical traits of all known extant and
#'   recently extinct mammals (PanTHERIA) developed for a number of
#'   macroecological and macroevolutionary research projects.
#'   
#' @details When using this data, please cite the original publication:
#'   
#'   \itemize{ \item E. Jones, Kate; Bielby, Jon; Cardillo, Marcel; A. Fritz, Susanne; O'Dell,
#'   Justin; David L. Orme, C.; Safi, Kamran; Sechrest, Wes; H. Boakes,
#'   Elizabeth; Carbone, Chris; Connolly, Christina; Cutts, Michael J.; Foster,
#'   Janine K.; Grenyer, Richard; Habib, Michael; Plaster, Christopher A.;
#'   Price, Samantha A.; Rigby, Elizabeth A.; Rist, Janna; Teacher, Amber;
#'   Bininda-Emonds, Olaf R. P.; Gittleman, John L.; M. Mace, Georgina; Purvis,
#'   Andy (2016): PanTHERIA: a species-level database of life history, ecology,
#'   and geography of extant and recently extinct mammals.
#'   http://esapubs.org/archive/ecol/E090/184/metadata.htm}

#'   
#'   For column names details, please see original metadata at:
#'   \url{http://esapubs.org/archive/ecol/E090/184/metadata.htm}
#'   
#' 
#'   Data were gathered from the literature for 25 types of ecological
#'   and life history information for any extant or recently extinct species
#'   within class Mammalia (100740 data lines): 
#'   
#'   1. Activity Cycle; 2. Age at Eye Opening; 3. Age at First Birth; 4. Average
#'   Lifespan; 5. Body Mass; 6. Diet; 7. Dispersal Age; 8. Adult Limb Length; 9.
#'   Gestation Length; 10. Group Composition & Size; 11. Growth Data; 12.
#'   Habitat Layer; 13. Head-Body Length; 14. Interbirth Interval; 15. Litter
#'   size; 16. Litters Per Year; 17. Maximum Longevity; 18. Metabolic Rate; 19.
#'   Migratory Behaviour; 20. Mortality Data;  21. Population Density; 22.
#'   Ranging Behaviour; 23. Sexual Maturity Age; 24. Teat Number; and 25. Weaning Age.
#'   
#'   30 specific variables (see Class IV, Table 1) were extracted from the above
#'   data types for PanTHERIA from a total of 94729 data lines (before error
#'   checking). Additionally, 4 variables were derived from extracted variables
#'   within PanTHERIA and 19 variables were calculated from other spatial data
#'   sources (see Class V, Section C).
#'   
#'   see \url{http://esapubs.org/archive/ecol/E090/184/metadata.htm} for further
#'   information.
#'   
#'   @source \url{http://dx.doi.org/10.5061/dryad.53ds2};
#'   \href{http://creativecommons.org/publicdomain/zero/1.0/}{Creative Commons
#'   0}. To the extent possible under law, the authors have waived all copyright
#'   and related or neighboring rights to this data.
#'   
#'   @family rawdata
"pantheria"

# ----------------------------------------------------------------------------

#' @title Mammal diet database
#' 
#' @description A comprehensive global dataset of diet preferences of mammals 
#'   (‘MammalDIET’). Diet information was digitized from the literature and 
#'   extrapolated for species with missing information. The original and 
#'   extrapolated data cover species-level diet information for >99% of all 
#'   terrestrial mammals.
#'   
#'   @details When using this data, please cite the original publication:
#'   
#'   \itemize{ \item Kissling, W.D., Dalby, L., Fløjgaard, C., Lenoir, J., Sandel, B., Sandom,
#'   C., Trøjelsgaard, K., Svenning, J. (2014). Establishing macroecological 
#'   trait datasets: digitalization, extrapolation, and validation of diet 
#'   preferences in terrestrial mammals worldwide. Ecol Evol, 4, 2913–2930.}
#'   
#'   Additionally, please cite the Dryad data package:
#'   
#'   \itemize{ \item Kissling WD, Dalby L, Fløjgaard C, Lenoir J, Sandel B, Sandom C, 
#'   Trøjelsgaard K, Svenning J-C (2014) Data from: Establishing macroecological
#'   trait datasets: digitalization, extrapolation, and validation of diet 
#'   preferences in terrestrial mammals worldwide. Dryad Digital Repository
#'   https://doi.org/10.5061/dryad.6cd0v}
#'   
#'   Column names:
#'   \itemize{ 
#'     \item TaxonID = Unique numeric code for each species, starting with 1 and ending with 5364;
#'     \item Order = The mammal order name of each species, following the IUCN taxonomy (IUCN 2013);
#'     \item Family = The mammal family name of each species, following the IUCN taxonomy (IUCN 2013);
#'     \item Genus = The mammal genus name of each species, following the IUCN taxonomy (IUCN 2013);
#'     \item Species = The mammal species name, following the IUCN taxonomy (IUCN 2013);
#'     \item Animal = Whether a mammal species eats animals (rank 1–3) or not (rank 0);
#'     \item Vertebrate = Whether a mammal species eats vertebrates (1-3) or not (0);
#'     \item Mammal = Whether a mammal species eats other mammals (rank 1–3) or not (rank 0);
#'     \item Bird = Whether a mammal species eats birds (rank 1–3) or not (rank 0).;
#'     \item Herptile = Whether a mammal species eats herptiles (amphibians or reptiles) (rank 1–3) or not (rank 0);
#'     \item Fish = Whether a mammal species eats fish (rank 1–3) or not (rank 0);
#'     \item Invertebrate = Whether a mammal species eats invertebrates (rank 1–3) or not (rank 0);
#'     \item Plant = Whether a mammal species eats plants (rank 1–3) or not (rank 0).;
#'     \item Seed = Whether a mammal species eats seeds (rank 1–3) or not (rank 0);
#'     \item Fruit = Whether a mammal species eats fleshy fruits (rank 1–3) or not (rank 0);
#'     \item Nectar = Whether a mammal species eats nectar (rank 1–3) or not (rank 0);
#'     \item Root = Whether a mammal species eats roots (rank 1–3) or not (rank 0);
#'     \item Leaf = Whether a mammal species eats leaves (rank 1–3) or not (rank 0);
#'     \item Woody = Whether a mammal species eats leaves of woody plants (rank 1–3) or not (rank 0). 
#'     Allows the definition of browsers (as opposed to grazers);
#'     \item Herbaceous = Whether a mammal species eats leaves of herbaceous plants (rank 1–3) or not (rank 0). 
#'     Allows the definition of grazers (as opposed to browsers);
#'     \item Other = Whether a mammal species eats other plant material (rank 1–3) or not (rank 0). 
#'     Other plant material refers to plant food items that are not covered by the other plant categories 
#'     (e.g., buds, flowers, pollen, and gum). It also includes fungi and lichens;
#'     \item TaxonomicNote = Information on synonyms (species, genus, family), i.e., differences in taxonomy between Nowak (1999) and IUCN (2013);
#'     \item FillCode = Data extrapolation method for species without species-level diet information in Nowak (1999);
#'     \item TrophicLevel = A classification of species into  three trophic levels. Carnivore (predominantly eating animals); Herbivore (predominantly 
#'     eating plant material); Omnivore (feeding on both animals and plants); NotAssigned (species which do not fit in any of the previous categories);
#'     \item MammalEater = Species with mammals as an important diet item;
#'     \item Insectivore = Species with invertebrates as an important diet item;
#'     \item Frugivore = Species with fruits as an important diet item;
#'     \item Granivore = Species with seeds as an important diet item;
#'     \item Folivore = Species with leaves as an important diet item;
#'     \item DataSource = Whether data come from Nowak (1999), IUCN (2013), or whether they have been extrapolated;
#'     \item taxa = Combination of Genus and Species name;
#'     
#'     Codes and definitions:
#'     For Animal, Vertebrate, Mammal, Bird, Herptile, Fish, Invertebrate, Plant, Seed,
#'     Fruit, Nectar, Root, Leaf, Woody, Herbaceous, Other:
#'     0 = does not eat x; 
#'     1 = x is primary food item; 
#'     2 = x is secondary food item; 
#'     3 = x is occasional food item
#'     
#'     For MammalEater, Insectivore, Frugivore, Granivore, Folivore:
#'     1 = species with rank 1 in diet category x;
#'     0 = species without rank 1 in ‘Leaf’
#'   }
#'   
#'   
#'         
#'   Description
#'   Ecological trait data are essential for understanding the 
#'   broad-scale distribution of biodiversity and its response to global change.
#'   For animals, diet represents a fundamental aspect of species’ evolutionary 
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
#' @source \url{http://dx.doi.org/10.5061/dryad.53ds2};
#' \href{http://creativecommons.org/publicdomain/zero/1.0/}{Creative Commons
#' 0}. To the extent possible under law, the authors have waived all copyright
#' and related or neighboring rights to this data.
#' 
#' @family rawdata
#' 
"mammaldiet"

# -----------------------------------------------------------------------------

#' @title AmphiBIO, a global database for amphibian ecological traits
#' 
#' @description A comprehensive database of natural history traits for amphibians worldwide. 
#' 
#' @details When using this data, please cite the original publication:
#' 
#' \itemize{ \item Oliveira, B.F., São-Pedro, V.A., Santos-Barrera, G., Penone, C. & Costa, G.C. (2017). 
#' AmphiBIO, a global database for amphibian ecological traits. Scientific Data, 4:170123. 
#' doi: [10.1038/sdata.2017.123](https://www.nature.com/articles/sdata2017123)}
#'   
#' Additionally, please cite the data repository on figshare:
#'   
#' \itemize{ \item Oliveira, Brunno Freire; São-Pedro, Vinícius Avelar; Santos-Barrera, Georgina; Penone, Caterina; 
#' C. Costa, Gabriel (2017): AmphiBIO_v1. figshare. https://doi.org/10.6084/m9.figshare.4644424.v5}
#' 
#' Column names:
#'   \itemize{ 
#'     \item id = AmphiBIO species’ identification number;
#'     \item Order = Amphibian Species of the World Order (Frost 2011);
#'     \item Family = Amphibian Species of the World Family (Frost 2011);
#'     \item Species = Amphibian Species of the World species scientific name (Frost 2011);
#'     \item Fos, Ter, Aqua, Herb = Overall vertical foraging stratum classification. 
#'     4 logical columns: Fos=Fossorial, Ter=Terrestrial, Aqua=Aquatic, Arb=Arboreal.
#'     Ignores details about seasonal or ontogenetic changes;
#'     \item Diet = Food items from the eating habits of adults using qualitative dietary categories. Information is based 
#'     on expert knowledge, direct observation or stomach content examination, as reported in the literature.
#'     6 logical columns: Leaves, Flowers, Seeds, Fruits, Arthro, Vert;
#'     \item Diel = Overall diel period as active
#'     3 logical columns: Diu=Diurnal (i.e., active during the day), Noc=Nocturnal (i.e., active during the night)
#'     Crepu=Crepuscular (i.e., active during the period immediately after dawn and that immediately before dusk);
#'     \item Seasonality = Seasonal period as active. Based on the comparison of the precipitation (wet or dry) and temperature 
#'     (warm or cold) conditions when active in relation to the average climatic conditions over the year. 
#'     Climatic conditions were obtained from weather stations closer to localities where specimens were collected or to
#'     field sites reported in publications (available at www.weatherbase.com)
#'     4 logical columns: Wet_warm, Wet_cold, Dry_warm, Dry_cold;
#'     \item Body_mass_g = Maximum adult body mass;
#'     \item Age_at_maturity_min_y = Minimum age at maturation/sexual maturity;
#'     \item Age_at_maturity_max_y = Maximum age at maturation/sexual maturity;
#'     \item Body_size_mm = Maximum adult body size. In Anura, body size is reported as snout to vent length (SVL). 
#'     In Gymnophiona and Caudata, body size is reported as total length (TL);
#'     \item Size_at_maturity_min_mm = Minimum size at maturation/sexual maturity;
#'     \item Size_at_maturity_max_mm = Maximum size at maturation/sexual maturity;
#'     \item Longevity_max_y = Maximum life span;
#'     \item Litter_size_min_n = Minimum no. of offspring or eggs per clutch;
#'     \item Litter_size_max_n = Maximum no. of offspring or eggs per clutch;
#'     \item Reproductive_output_y = Maximum no. reproduction events per year;
#'     \item Offspring_size_min_mm = Minimum offspring or egg size;
#'     \item Offspring_size_max_mm = Maximum offspring or egg size;
#'     \item Breeding strategy = Whether the species reproduce via direct, larval development or is viviparous
#'     3 logical columns: Dir=Species reproduce via direct development, Lar=Species present larval stages Viv=Species is viviparous;
#'     \item OBS = Comments
#'     }
#'     
#'     Description: Current ecological and evolutionary research are increasingly moving from species- to trait-based approaches 
#'     because traits provide a stronger link to organism’s function and fitness. Trait databases covering a large number of 
#'     species are becoming available, but such data remains scarce for certain groups. Amphibians are among the most diverse 
#'     vertebrate groups on Earth, and constitute an abundant component of major terrestrial and freshwater ecosystems. They are 
#'     also facing rapid population declines worldwide, which is likely to affect trait composition in local communities, thereby 
#'     impacting ecosystem processes and services. In this context, we introduce AmphiBIO, a comprehensive database of natural 
#'     history traits for amphibians worldwide. The database releases information on 17 traits related to ecology, morphology and 
#'     reproduction features of amphibians. We compiled data from more than 1,500 literature sources, and for more than 6,500 species 
#'     of all orders (Anura, Caudata and Gymnophiona), 61 families and 531 genera. This database has the potential to allow unprecedented 
#'     large-scale analyses in ecology, evolution and conservation of amphibians.
#'     
#'     
#'  @source \url{http://dx.doi.org/10.5061/dryad.53ds2};
#'  \href{https://creativecommons.org/licenses/by/4.0/}{Creative Commons BY 4.0}. You must give appropriate credit, 
#'  provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, 
#'  but not in any way that suggests the licensor endorses you or your use.
#' 
#'  @family rawdata
#' 
"amphibio"

# -----------------------------------------------------------------------------
#' @title Passerine morphology
#' 
#' @description Passerine morphology: external measurements of approximately one-quarter of passerine bird species.
#' 
#' @details When using this data, please cite the original publication:
#' 
#' \itemize{ \item Ricklefs, R. E. (2017), Passerine morphology: external measurements of approximately one-quarter of 
#' passerine bird species. Ecology, 98: 1472. doi:10.1002/ecy.1783}
#' 
#' Column names:
#'   \itemize{ 
#'     \item Order/Sup = taxonomic Order;
#'     \item Family = taxonomic Family;
#'     \item Subfam = taxonomic Subfamily;
#'     \item Genus = taxonomic Genus;
#'     \item Species = taxonomic Species;
#'     \item Length = total length of the specimen, including the bill and tail;
#'     \item Wing = length of the folded wing, flattened along a stiff ruler, from the wrist to the tip of the longest primary;
#'     \item Tail = length of the tail from the base of the feathers in the center of the tail to the tip of the longest rectrix;
#'     \item Tarsus = length of the tarsus;
#'     \item Toe = length of the middle toe (to the base of the claw);
#'     \item Bill L = length of the beak: culmen from the tip of the upper mandible to its kinetic hinge at the front of the skull;
#'     \item Bill W = width of the beak at the kinetic hinge;
#'     \item Bill D = depth of the beak;
#'     \item Taxonomy and distributon
#'     11 columns describing the distributions of species of Passeriformes in each of 11 biogeographic regions are from Edwards’s 
#'     Coded List of Birds of the World (1974). The biogeographic regions (column names) are HN = Nearctic, N = Neotropics, 
#'     NI = Neotropical Islands (primarily the West Indies), HP = Palearctic, E = Ethiopian (Africa), 
#'     EI = African Islands (primarily Madagascar), O = Oriental (southern Asia), OI = Oriental Islands, AU = Australia, 
#'     AZ = New Zealand, AI = Australasian Islands (including New Guinea and the southern Pacific). 
#'     Edwards’s checklist is out of date with respect to taxonomy, but provides detailed distributions of the species, whose 
#'     taxonomy was updated to match the Taxonomy in Flux Checklist. Edwards treats 5999 species of passerine birds, compared to 
#'     the 6198 species in the TiF checklist;
#'     \item TIF No. = code from Taxonomy in Flux (TiF) Checklist, Version 2.5, updated August 17, 2009 (http://jboyd.net/Taxo/index.html);
#'     \item IOC No. = code from Bird List of the International Ornithological Council (IOC), Version 4.4 (http://dx.doi.org/10.14344/IOC.ML.4.4);
#'     }
#'     
#'     Description: A data set including eight measurements of the external morphology of 1642 species, roughly one-quarter of all
#'     passerine birds (Aves: Order Passeriformes), from all parts of the world, characterizing the relative proportions of the wing, 
#'     tail, legs, and beak. Specimens were measured opportunistically over the past 40 years in museums in the United States and Europe.
#'     Numbers of individuals measured per species vary from one to dozens in some cases. Measurements for males and females of sexually 
#'     size-dimorphic species are presented separately. Taxonomy follows the Taxonomy in Flux (TIF) checklist as well as the World Bird 
#'     List of the International Ornithological Council. Geographic distributions are summarized from Edwards's Coded List of Birds of 
#'     the World.
#'     
#'     
#'  @source \url{http://onlinelibrary.wiley.com/doi/10.1002/};
#' \href{http://creativecommons.org/publicdomain/zero/1.0/}{Creative Commons
#' 0}. To the extent possible under law, the authors have waived all copyright
#' and related or neighboring rights to this data.
#'  @family rawdata
#' 
"passerine"

# -----------------------------------------------------------------------------

#' D3: The Dispersal and Diaspore Database
#' 
#' @description  Baseline data and statistics on plant seed dispersal
#' 
#' @details Seed dispersal is hard to measure, and there is still a lack of knowledge about dispersal-related traits of plant species. Therefore, we developed D3, the Dispersal and Diaspore Database (available at www.seed-dispersal.info), which aims at simplifying ecological and evolutionary analyses by providing and integrating various items related to seed dispersal: empirical studies, functional traits, image analyses and ranking indices (quantifying the adaptation to dispersal modes).
#' 
#' @source Cite as: 
#' 
#'   - Hintze, C., Heydel, F., Hoppe, C., Cunze, S., König, A., & Tackenberg, O. (2013). D3: the dispersal and diaspore database baseline data and statistics on seed dispersal. Perspectives in Plant Ecology Evolution and Systematics, 15(3):180-192.doi: [https://doi.org/10.1016/j.ppees.2013.02.001](http://www.sciencedirect.com/science/article/pii/S1433831913000218?via%3Dihub#sec0110)
#'   
#'   \href{https://creativecommons.org/licenses/by-nc-nd/3.0/}{Creative Commons BY-NC-ND 3.0}. You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use. NonCommercial: You may not use the material for commercial purposes.
#'   NoDerivatives — If you remix, transform, or build upon the material, you may not distribute the modified material.
#'   
#' @author Christina Hintze, Felix Heydel, Christina Hoppe, Sarah Cunze, Andreas König and Oliver Tackenberg
#' 
#' @family rawdata
"plantsD3"

# -----------------------------------------------------------------------------

#' Fire-related traits for vascular plant species of the Mediterranean Basin (BROT database)
#' 
#' @description  Most updated and comprehensive information on fire-related traits for vascular plant species of the Mediterranean Basin.
#' 
#' @details Plant trait information is essential for understanding plant evolution, vegetation dynamics and vegetation responses to disturbance and management. Furthermore, in Mediterranean ecosystems, changes in fire regime may be more relevant than direct changes in climatic conditions, making the knowledge of fire-related traits specially relevant. 
#' 
#' @source Cite as: 
#' 
#'   - Paula, S., Arianoutsou, M., Kazanis, D., Tavsanoglu, Ç., Lloret, F., Buhk, C., Ojeda, F., Luna, B., Moreno, J. M., Rodrigo, A., Espelta, J. M., Palacio, S., Fernández-Santos, B., Fernandes, P. M. and Pausas, J. G. (2009), Fire-related traits for plant species of the Mediterranean Basin. Ecology, 90: 1420. doi: [10.1890/08-1309.1]
#'   
#'   \href{https://creativecommons.org/licenses/by/4.0/}{Creative Commons BY 4.0}. You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use. 
#'   
#' @author Paula, S., Arianoutsou, M., Kazanis, D., Tavsanoglu, Ç., Lloret, F., Buhk, C., Ojeda, F., Luna, B., Moreno, J. M., Rodrigo, A., Espelta, J. M., Palacio, S., Fernández-Santos, B., Fernandes, P. M. and Pausas, J. G.
#' 
#' @family rawdata
"plantsFire"

# -----------------------------------------------------------------------------

#' The thermal dependence of biological traits (biotraits)
#' 
#' @description  Dataset on how diverse biological rates and times respond to temperature.
#' 
#' @details A dataset of 2352 thermal responses for 220 traits for microbes, plants, and animals compiled from 270 published sources. This represents the most diverse and comprehensive thermal response data set ever compiled. The traits in this database span levels of biological organization from internal physiology to species interactions and were measured in marine, freshwater, and terrestrial habitats for 411 species.
#' 
#' @source Cite as: 
#' 
#'   - Dell, A. I., Pawar, S. and Savage, V. M. (2013), The thermal dependence of biological traits. Ecology, 94: 1205–1206. doi: [10.1890/12-2060.1]
#'   - I. Dell, Anthony; Pawar, Samraat; M. Savage, Van (2016): Data Paper. Data Paper. Wiley. https://doi.org/10.6084/m9.figshare.3556611.v1 Retrieved: 14:45, Nov 21, 2017 (GMT) 
#'   
#'   \href{https://creativecommons.org/licenses/by/4.0/}{Creative Commons BY 4.0}. You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use. 
#'   
#' @author Dell, A. I., Pawar, S. and Savage, V. M.
#' 
#' @family rawdata
"biotraits"