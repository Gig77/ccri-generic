options(warn=1)
library(optparse)

option_list <- list(
		make_option("--deseq2-input-file", type="character", help="tab-separated file with differentially regulated genes from DESeq2"),
		make_option("--rnk-output-file", type="character", help="output file in .rnk format for GSEA analysis"),
		make_option("--min-pvalue", type="numeric", help="minimum p-value for up- or down-regulated genes")
)
opt <- parse_args(OptionParser(option_list=option_list))

g <- read.delim(opt$'deseq2-input-file')
gf <- g[!is.na(g$pvalue) & g$pvalue <= opt$'min-pvalue' & !is.na(g$log2FoldChange) & !is.na(g$hgnc_symbol) & g$hgnc_symbol != "",]
#gf <- g[!is.na(g$pvalue) & g$pvalue <= opt$'min-pvalue' & !is.na(g$hgnc_symbol) & g$hgnc_symbol != "" & !is.na(g$log2FoldChange),]
gf <- gf[order(gf$log2FoldChange,decreasing=T),c("hgnc_symbol", "log2FoldChange")]
write.table(gf, opt$'rnk-output-file', col.names=F, row.names=F, sep="\t", quote=F)