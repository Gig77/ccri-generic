library("biomaRt")
mart <- useMart(biomart="ENSEMBL_MART_ENSEMBL", host="grch37.ensembl.org", path="/biomart/martservice" ,dataset="hsapiens_gene_ensembl") # GRCh37, v75

genes <- getBM(filters=c("biotype", "with_hgnc"), values=list("protein_coding", TRUE), attributes=c("ensembl_gene_id", "hgnc_symbol", "chromosome_name", "gene_biotype", "transcript_length", "percentage_gc_content"), mart=mart)

topN <- 300
gmt = data.frame(name=character(0), desc=character(0), genes=character(0), stringsAsFactors = FALSE)

# longest/shortest genes
genes.length <- aggregate(transcript_length~hgnc_symbol, genes, max)
genes.length <- genes.length[order(genes.length$transcript_length),]
gmt[nrow(gmt)+1,] <- c(paste0("HSAPIENS_TOP", topN, "_SHORTEST_PROTEINS"), "", paste(genes.length$hgnc_symbol[1:topN], collapse="\t"))
gmt[nrow(gmt)+1,] <- c(paste0("HSAPIENS_TOP", topN, "_LONGEST_PROTEINS"), "", paste(rev(genes.length$hgnc_symbol[(nrow(genes.length)-topN+1):nrow(genes.length)]), collapse="\t"))

# genes with highest/lowest GC content
genes.gc <- aggregate(percentage_gc_content~hgnc_symbol, genes, mean)
genes.gc <- genes.gc[order(genes.gc$percentage_gc_content),]
gmt[nrow(gmt)+1,] <- c(paste0("HSAPIENS_TOP", topN, "_LOWEST_GC_CONTENT"), "", paste(genes.gc$hgnc_symbol[1:topN], collapse="\t"))
gmt[nrow(gmt)+1,] <- c(paste0("HSAPIENS_TOP", topN, "_HIGHEST_GC_CONTENT"), "", paste(rev(genes.gc$hgnc_symbol[(nrow(genes.gc)-topN+1):nrow(genes.gc)]), collapse="\t"))

# mitochondrial genes
genes.mt <- getBM(filters=c("chromosome_name", "with_hgnc"), values=list("MT", TRUE), attributes=c("ensembl_gene_id", "hgnc_symbol", "gene_biotype"), mart=mart)
gmt[nrow(gmt)+1,] <- c("HSAPIENS_MITOCHONDRIAL_GENOME", "", paste(genes.mt$hgnc_symbol, collapse="\t"))

write.table(gmt, file="/mnt/projects/generic/data/ccri/ccri_custom_gene_sets.gmt", quote=F, sep="\t", row.names=F, col.names=F, na="")
