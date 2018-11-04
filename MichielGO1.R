library( ggplot2 );
library( scales );

revigo.names <- c("term_ID","description","frequency_%","plot_X","plot_Y","plot_size","log10_p_value","uniqueness","dispensability");
revigo.data <- rbind(c("GO:0008152","metabolic process",75.387,-4.213,-3.489, 6.986,-1.6925,0.994,0.000),
                     c("GO:0044262","cellular carbohydrate metabolic process", 1.257, 3.434, 5.039, 5.208,-9.7905,0.670,0.000),
                     c("GO:0009056","catabolic process", 4.820,-4.275,-1.664, 5.791,-5.4260,0.941,0.019),
                     c("GO:0034599","cellular response to oxidative stress", 0.224,-1.452, 5.187, 4.458,-2.2168,0.916,0.031),
                     c("GO:0017144","drug metabolic process", 0.058,-2.532, 3.034, 3.868,-2.4908,0.897,0.050),
                     c("GO:0046434","organophosphate catabolic process", 0.365, 2.055,-5.967, 4.671,-4.3565,0.544,0.060),
                     c("GO:0006090","pyruvate metabolic process", 0.817, 7.861,-1.859, 5.021,-5.2161,0.558,0.065),
                     c("GO:0072524","pyridine-containing compound metabolic process", 1.351, 5.231,-7.861, 5.239,-8.2013,0.753,0.069),
                     c("GO:0006732","coenzyme metabolic process", 3.111,-4.486, 0.124, 5.601,-7.5171,0.735,0.077),
                     c("GO:0005975","carbohydrate metabolic process", 5.260,-3.518,-5.410, 5.829,-13.5513,0.868,0.078),
                     c("GO:0006091","generation of precursor metabolites and energy", 1.940,-3.840, 1.834, 5.396,-4.1911,0.866,0.080),
                     c("GO:0051186","cofactor metabolic process", 3.985, 1.783, 6.944, 5.709,-7.4045,0.856,0.089),
                     c("GO:0006793","phosphorus metabolic process",13.507,-1.810,-7.055, 6.239,-1.5702,0.836,0.114),
                     c("GO:0055114","oxidation-reduction process",15.060, 7.592, 0.715, 6.286,-7.5100,0.682,0.234),
                     c("GO:0055086","nucleobase-containing small molecule metabolic process", 4.917, 6.523,-1.980, 5.800,-2.7545,0.506,0.410),
                     c("GO:0019637","organophosphate metabolic process", 6.148, 2.527,-7.634, 5.897,-3.1403,0.626,0.412),
                     c("GO:0044281","small molecule metabolic process",15.138, 8.010, 0.528, 6.288,-5.5702,0.682,0.415),
                     c("GO:0006538","glutamate catabolic process", 0.021, 4.310,-4.120, 3.433,-1.3575,0.586,0.417),
                     c("GO:0005991","trehalose metabolic process", 0.085, 4.421, 2.728, 4.040,-3.0650,0.587,0.488),
                     c("GO:0042866","pyruvate biosynthetic process", 0.005, 8.518,-2.693, 2.780,-4.0762,0.652,0.488),
                     c("GO:1901292","nucleoside phosphate catabolic process", 0.187, 4.468,-3.567, 4.379,-4.5406,0.429,0.493),
                     c("GO:0032787","monocarboxylic acid metabolic process", 2.485, 7.441,-1.389, 5.504,-4.1938,0.527,0.520),
                     c("GO:0006979","response to oxidative stress", 0.575,-1.091, 5.415, 4.868,-1.8125,0.962,0.523),
                     c("GO:0046939","nucleotide phosphorylation", 0.792, 5.836,-3.484, 5.007,-3.8041,0.441,0.546),
                     c("GO:0006082","organic acid metabolic process", 9.086, 6.651,-1.148, 6.067,-3.7399,0.487,0.592),
                     c("GO:0006754","ATP biosynthetic process", 0.432, 5.669,-3.000, 4.743,-2.6861,0.390,0.592),
                     c("GO:0044283","small molecule biosynthetic process", 5.677, 6.860,-0.714, 5.862,-2.0150,0.482,0.608),
                     c("GO:0009132","nucleoside diphosphate metabolic process", 0.698, 5.957,-3.702, 4.952,-3.1891,0.447,0.619),
                     c("GO:0016052","carbohydrate catabolic process", 1.078, 0.760,-0.933, 5.141,-8.7932,0.578,0.627),
                     c("GO:0016051","carbohydrate biosynthetic process", 1.079, 5.043, 1.595, 5.141,-6.6021,0.491,0.627),
                     c("GO:0005978","glycogen biosynthetic process", 0.099, 5.403, 2.253, 4.103,-2.7799,0.488,0.632),
                     c("GO:0044270","cellular nitrogen compound catabolic process", 1.045, 1.174,-5.486, 5.127,-1.5591,0.680,0.635),
                     c("GO:0006112","energy reserve metabolic process", 0.168, 7.590, 2.872, 4.334,-2.3575,0.706,0.660));

one.data <- data.frame(revigo.data);
names(one.data) <- revigo.names;
one.data <- one.data [(one.data$plot_X != "null" & one.data$plot_Y != "null"), ];
one.data$plot_X <- as.numeric( as.character(one.data$plot_X) );
one.data$plot_Y <- as.numeric( as.character(one.data$plot_Y) );
one.data$plot_size <- as.numeric( as.character(one.data$plot_size) );
one.data$log10_p_value <- as.numeric( as.character(one.data$log10_p_value) );
one.data$frequency <- as.numeric( as.character(one.data$frequency) );
one.data$uniqueness <- as.numeric( as.character(one.data$uniqueness) );
one.data$dispensability <- as.numeric( as.character(one.data$dispensability) );

p1 <- ggplot( data = one.data );
p1 <- p1 + geom_point( aes( plot_X, plot_Y, colour = log10_p_value, size = plot_size), alpha = I(0.6) ) + scale_size_area();
p1 <- p1 + scale_colour_gradientn( colours = c("blue", "green", "yellow", "red"), limits = c( min(one.data$log10_p_value), 0) );
p1 <- p1 + geom_point( aes(plot_X, plot_Y, size = plot_size), shape = 21, fill = "transparent", colour = I (alpha ("black", 0.6) )) + scale_size_area();
p1 <- p1 + scale_size( range=c(5, 30)) + theme_bw(); # + scale_fill_gradientn(colours = heat_hcl(7), limits = c(-300, 0) );
ex <- one.data [ one.data$dispensability < 0.15, ]; 
p1 <- p1 + geom_text( data = ex, aes(plot_X, plot_Y, label = description), colour = I(alpha("black", 0.85)), size = 3 );
p1 <- p1 + labs (y = "semantic space x", x = "semantic space y");
p1 <- p1 + theme(legend.key = element_blank()) ;
one.x_range = max(one.data$plot_X) - min(one.data$plot_X);
one.y_range = max(one.data$plot_Y) - min(one.data$plot_Y);
p1 <- p1 + xlim(min(one.data$plot_X)-one.x_range/10,max(one.data$plot_X)+one.x_range/10);
p1 <- p1 + ylim(min(one.data$plot_Y)-one.y_range/10,max(one.data$plot_Y)+one.y_range/10);

# Output the plot to screen

p1;