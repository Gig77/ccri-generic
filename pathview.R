library("AnnotationDbi")
library("org.Hs.eg.db")
columns(org.Hs.eg.db)

deseq <- read.delim("/mnt/projects/ikaros/results/anduril/execute/deseq_IKNp_vs_IKCp/results.csv")
deseq <- deseq[!is.na(deseq$qIKNp.vs.IKCp) & deseq$qIKNp.vs.IKCp < 0.1,]
deseq$entrez <- mapIds(org.Hs.eg.db, keys=as.character(deseq$ids), column="ENTREZID", keytype="ENSEMBL", multiVals="first")

foldchanges <- deseq$fcIKNp.vs.IKCp
names(foldchanges) <- deseq$entrez
foldchanges <- foldchanges[!is.na(names(foldchanges))]
head(foldchanges)

# install
source("http://bioconductor.org/biocLite.R")
biocLite(c("Rgraphviz", "png", "KEGGgraph", "org.Hs.eg.db"))
biocLite("pathview")
biocLite("gage")

# gage
library(gage)
data(kegg.gs)
kegg.sets.hs <- kegg.gsets(species="hsa", id.type="kegg")
keggres <- gage(foldchanges, gsets=kegg.sets.hs$kg.sets, same.dir=TRUE)
lapply(keggres, head)

kegg.gs
# focal adhesion pathway (hsa04510)
library(pathview)
pv.out <- pathview(gene.data = foldchanges, pathway.id = "04510", species = "hsa", out.suffix = "ikaros", low=list(gene="#6666FF"), mid=list(gene="#CCCCCC"), high=list(gene="#FF0000"))
system("mv /home/anduril/hsa04510.ikaros.png /data_synology/christian")

