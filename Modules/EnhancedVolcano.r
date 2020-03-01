"
This R script generates Enhanced Volcano plots using Bioconductor EnhancedVolcano package.
Read: https://bioconductor.org/packages/release/bioc/html/EnhancedVolcano.html
Read the manual for additional customizations.
The script assumes that the EnhancedVolcano package is installed.
"

#### Loading required libraries -------------
library(EnhancedVolcano)

#### Enhanced Volcano Function
EVolcano_Plotter <- function(input_data, p_cutOFF, fc_cutOFF, x_lim, y_lim, cus_labels, plt_title){
  EnhancedVolcano(input_data,
                  lab = input_data$Gene,
                  x = 'log2FoldChange',
                  y = 'padj',
                  xlab = bquote(~Log[2]~ 'Fold Change'),
                  ylab = bquote(~-Log[10]~adjusted~italic(P)),
                  pCutoff = p_cutOFF,
                  FCcutoff = fc_cutOFF,
                  xlim = x_lim,
                  ylim = y_lim,
                  selectLab = cus_labels,
                  drawConnectors = TRUE,
                  labSize = 4,
                  colAlpha = 0.6,
                  legendPosition = "None",
                  gridlines.minor = TRUE,
                  pointSize = 2,
                  title = plt_title,
                  subtitle = 'Volcano Plot',
                  caption = paste("adjP cutoff = ", p_cutOFF, " and ", "FC CutOff = ", fc_cutOFF)
  )
  
}

#### Plot Saver Function
save_plots <- function(plot_name, width, height, res, plot_variable){
  tiff(file = paste0(prefix, plot_name), width = width, height = height, units = "px", res = res)
  plot(plot_call)
  dev.off()
}

#### Calling Plotter Function
cus_labels <- "" #c("mir-958", "mir-956", "mir-314") # Custom list of lables

plot_title_1 <- bquote(~italic(me31b)~-RNAi~vs~Control) # Title of the plot
vol_1 <- EVolcano_Plotter(resdata_1, 0.05, 1.0, c(-10, 10), c(0, 60), cus_labels, plot_title_1)
vol_1
dev.off()

plot_title_2 <- bquote(~italic(tral)~-RNAi~vs~Control) # Title of the plot
vol_2 <- EVolcano_Plotter(resdata_2, 0.05, 1.0, c(-10, 10), c(0, 40), cus_labels, plot_title_2)
vol_2
dev.off()

plot_title_3 <- bquote(~italic(edc3)~-RNAi~vs~Control) # Title of the plot
vol_3 <- EVolcano_Plotter(resdata_3, 0.05, 1.0, c(-10, 10), c(0, 60), cus_labels, plot_title_3)
vol_3
dev.off()

plot_title_4 <- "" # bquote(~italic(pcm)~-RNAi~vs~Control) # Title of the plot
vol_4 <- EVolcano_Plotter(resdata_4, 0.05, 1.0, c(-10, 10), c(0, 50), cus_labels, plot_title_4)
vol_4
dev.off()

save_plots("me31b_vs_Control_VPlot.tiff", 4800, 5400, 800, vol_1)

"
Key to the Enhanced Volcano Function:
    input_data        Final output dataframe of the DEseq2 script. Default text: resdata
    p_cutOFF          Adjusted p-value cutoff to be used. Recommended = 0.05
    fc_cutOFF         Log2FC cutoff to be used. Recommended = 0.05
    x_lim             X-axis limits
    y_lim             Y-axis limits
    cus_labels        A list of gene names to be marked on the plot
    plt_title         Title of the plot

Key to the Plot Saver Function:
    plot_name         Name of the saved .TIFF file. Ex: EnhacedVolcano.tiff
    width             Width of the .tiff
    height            Height of the .tiff
    res               Resolution of the .tiff
    plot_variable     Plot variable to be used to generate the plot. Ex: vol_1 from above
"
