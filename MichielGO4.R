# A treemap R script
# If you don't have the treemap package installed, uncomment the following line:
# install.packages( "treemap" );
library(treemap) 
# Set the working directory if necessary
revigo.names <- c("term_ID","description","freqInDbPercent","abslog10pvalue","uniqueness","dispensability","representative");
revigo.data <- rbind(c("GO:0003824","catalytic activity",65.827,8.8729,0.916,0.000,"catalytic activity"),
                     c("GO:0035251","UDP-glucosyltransferase activity",0.102,2.9245,0.351,0.000,"UDP-glucosyltransferase activity"),
                     c("GO:0016757","transferase activity, transferring glycosyl groups",1.986,1.6517,0.546,0.228,"UDP-glucosyltransferase activity"),
                     c("GO:0016758","transferase activity, transferring hexosyl groups",0.898,2.3098,0.325,0.662,"UDP-glucosyltransferase activity"),
                     c("GO:0046527","glucosyltransferase activity",0.118,2.5784,0.348,0.685,"UDP-glucosyltransferase activity"),
                     c("GO:0016620","oxidoreductase activity, acting on the aldehyde or oxo group of donors, NAD or NADP as acceptor",0.395,2.1096,0.660,0.023,"oxidoreductase activity, acting on the aldehyde or oxo group of donors, NAD or NADP as acceptor"),
                     c("GO:0016903","oxidoreductase activity, acting on the aldehyde or oxo group of donors",0.627,1.6615,0.659,0.338,"oxidoreductase activity, acting on the aldehyde or oxo group of donors, NAD or NADP as acceptor"),
                     c("GO:0016491","oxidoreductase activity",12.783,3.9469,0.735,0.038,"oxidoreductase activity"));

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