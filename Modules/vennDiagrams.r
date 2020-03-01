"
This R script generates Venn Diagrams using VennDiagram package.
Read: https://cran.r-project.org/web/packages/VennDiagram/index.html
Read the manual for additional customizations.
The script assumes that the VennDiagram package is installed.
"

#### Export settings -------------
out_dir <- "/path/to/output/"

#### Loading required libraries -------------
library(VennDiagram)

venn_plotter <- function(input_data, justification_1, justification_2, out_dir, plotName, plotTitle, color_1, color_2){
  venn.diagram(c_1, cat.fontfamily = "Arial",
               cat.cex = .75, cex = .75, lwd =1, fontfamily ="Arial", 
               cat.just = list(justification_1, justification_2),
               filename = paste0(out_dir, plotName), imagetype = "tiff",
               height = 3000, width = 3000, resolution = 1500, units = "px",
               main=plotTitle, 
               title.fontface = "bold",
               main.pos=c(0.5,1.05), main.fontfamily="Arial", main.cex=.75, 
               col=c("#440154ff", '#21908dff'),
               fill = c(alpha(color_1,0.3), alpha(color_2,0.3)))
}

#### Calling Plotter Function -------------
venn_plotter(input_data, c(0.15, -2.75), c(0.9, -1.85), out_dir, 
             "Significantly Downregulated Genes", "plotname", "#440154ff", "#21908dff")
