"
This R script performs Gene Ontology (GO) analysis using Bioconductor clusterProfiler package.
Read: https://bioconductor.org/packages/release/bioc/html/clusterProfiler.html
Read the manual for additional customizations.
The script assumes that clusterProfiler, AnnotationHub and org.Dm.eg.db packages are installed.
Note that org.xx.eg.db must be altered depending on the model organism.
"

#### Loading required libraries -------------
library("clusterProfiler")
library("AnnotationHub")
library("org.Dm.eg.db")

#### Import/export data -------------
file <- "/path/to/file/*.csv"                         ## File must be in .csv format.
list <- read.csv(file, header=TRUE, sep = ",")
genes <- as.character(list$Gene)                      ## Gene is the column id of gene names in the .csv file.
head(genes)

output_dir <- "/path/to/output/directory/"                 ## Path to the output directory.
top_hits <- 20

organism <- "Drosophila melanogaster"
orgdb <- org.Dm.eg.db

genes <- bitr(genes, fromType="SYMBOL", toType="ENTREZID", OrgDb = orgdb)
head(genes)
genes

go_bp <- enrichGO(gene=genes$ENTREZID, OrgDb=orgdb, ont="BP", readable=TRUE)
go_mf <- enrichGO(gene=genes$ENTREZID, OrgDb=orgdb, ont="MF", readable=TRUE)
go_cc <- enrichGO(gene=genes$ENTREZID, OrgDb=orgdb, ont="CC", readable=TRUE)

#### Export GO analysis results: Graphics -------------
setwd(output_dir)
pdf("enrichment.pdf", width=18)
barplot(go_bp, title="Go Enrichment (Biological Process)", showCategory=top_hits)
barplot(go_mf, title="Go Enrichment (Molecular Function)", showCategory=top_hits)
barplot(go_cc, title="Go Enrichment (Cellular Component)", showCategory=top_hits)
dev.off()

#### Export GO analysis results: Text Documents -------------
write.table(go_bp@result, "biological_process.txt", row.names=FALSE, sep="\t", quote=FALSE, na="")
write.table(go_mf@result, "molecular_function.txt", row.names=FALSE, sep="\t", quote=FALSE, na="")
write.table(go_cc@result, "cellular_component.txt", row.names=FALSE, sep="\t", quote=FALSE, na="")

"
Note that GO categories displayed in graphics can be customized.
"
