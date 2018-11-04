# Use acrobat reader dc to open the Gene Ontology treemap pdf file
# A treemap R script
install.packages("treemap")
library(treemap)
revigo.names <- c("term_ID","description","freqInDbPercent","abslog10pvalue","uniqueness","dispensability","representative");
revigo.data <- rbind(c("GO:0008152","metabolic process",75.387,1.6925,0.994,0.000,"metabolism"),
                     c("GO:0044262","cellular carbohydrate metabolic process",1.257,9.7905,0.670,0.000,"cellular carbohydrate metabolism"),
                     c("GO:0005991","trehalose metabolic process",0.085,3.0650,0.587,0.488,"cellular carbohydrate metabolism"),
                     c("GO:0016052","carbohydrate catabolic process",1.078,8.7932,0.578,0.627,"cellular carbohydrate metabolism"),
                     c("GO:0016051","carbohydrate biosynthetic process",1.079,6.6021,0.491,0.627,"cellular carbohydrate metabolism"),
                     c("GO:0005978","glycogen biosynthetic process",0.099,2.7799,0.488,0.632,"cellular carbohydrate metabolism"),
                     c("GO:0044270","cellular nitrogen compound catabolic process",1.045,1.5591,0.680,0.635,"cellular carbohydrate metabolism"),
                     c("GO:0006112","energy reserve metabolic process",0.168,2.3575,0.706,0.660,"cellular carbohydrate metabolism"),
                     c("GO:0009056","catabolic process",4.820,5.4260,0.941,0.019,"catabolism"),
                     c("GO:0034599","cellular response to oxidative stress",0.224,2.2168,0.916,0.031,"cellular response to oxidative stress"),
                     c("GO:0006979","response to oxidative stress",0.575,1.8125,0.962,0.523,"cellular response to oxidative stress"),
                     c("GO:0017144","drug metabolic process",0.058,2.4908,0.897,0.050,"drug metabolism"),
                     c("GO:0046434","organophosphate catabolic process",0.365,4.3565,0.544,0.060,"organophosphate catabolism"),
                     c("GO:0019637","organophosphate metabolic process",6.148,3.1403,0.626,0.412,"organophosphate catabolism"),
                     c("GO:0006538","glutamate catabolic process",0.021,1.3575,0.586,0.417,"organophosphate catabolism"),
                     c("GO:1901292","nucleoside phosphate catabolic process",0.187,4.5406,0.429,0.493,"organophosphate catabolism"),
                     c("GO:0046939","nucleotide phosphorylation",0.792,3.8041,0.441,0.546,"organophosphate catabolism"),
                     c("GO:0006754","ATP biosynthetic process",0.432,2.6861,0.390,0.592,"organophosphate catabolism"),
                     c("GO:0009132","nucleoside diphosphate metabolic process",0.698,3.1891,0.447,0.619,"organophosphate catabolism"),
                     c("GO:0006090","pyruvate metabolic process",0.817,5.2161,0.558,0.065,"pyruvate metabolism"),
                     c("GO:0055114","oxidation-reduction process",15.060,7.5100,0.682,0.234,"pyruvate metabolism"),
                     c("GO:0055086","nucleobase-containing small molecule metabolic process",4.917,2.7545,0.506,0.410,"pyruvate metabolism"),
                     c("GO:0044281","small molecule metabolic process",15.138,5.5702,0.682,0.415,"pyruvate metabolism"),
                     c("GO:0042866","pyruvate biosynthetic process",0.005,4.0762,0.652,0.488,"pyruvate metabolism"),
                     c("GO:0032787","monocarboxylic acid metabolic process",2.485,4.1938,0.527,0.520,"pyruvate metabolism"),
                     c("GO:0006082","organic acid metabolic process",9.086,3.7399,0.487,0.592,"pyruvate metabolism"),
                     c("GO:0044283","small molecule biosynthetic process",5.677,2.0150,0.482,0.608,"pyruvate metabolism"),
                     c("GO:0072524","pyridine-containing compound metabolic process",1.351,8.2013,0.753,0.069,"pyridine-containing compound metabolism"),
                     c("GO:0006732","coenzyme metabolic process",3.111,7.5171,0.735,0.077,"coenzyme metabolism"),
                     c("GO:0005975","carbohydrate metabolic process",5.260,13.5513,0.868,0.078,"carbohydrate metabolism"),
                     c("GO:0006091","generation of precursor metabolites and energy",1.940,4.1911,0.866,0.080,"generation of precursor metabolites and energy"),
                     c("GO:0051186","cofactor metabolic process",3.985,7.4045,0.856,0.089,"cofactor metabolism"),
                     c("GO:0006793","phosphorus metabolic process",13.507,1.5702,0.836,0.114,"cofactor metabolism"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$abslog10pvalue <- as.numeric( as.character(stuff$abslog10pvalue) );
stuff$freqInDbPercent <- as.numeric( as.character(stuff$freqInDbPercent) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_treemap.pdf", width=16, height=9 ) # width and height are in inches

# check the tmPlot command documentation for all possible parameters - there are a lot more
tmPlot(
  stuff,
  index = c("representative","description"),
  vSize = "abslog10pvalue",
  type = "categorical",
  vColor = "representative",
  title = "REVIGO Gene Ontology treemap",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  bg.labels = "#CCCCCCAA",     # define background color of group labels
  # "#CCCCCC00" is fully transparent, "#CCCCCCAA" is semi-transparent grey, NA is opaque
  position.legend = "none"
)

dev.off()
