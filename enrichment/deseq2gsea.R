options(warn=1)
library(optparse)

option_list <- list(
		make_option("--deseq2-input-file", type="character", help="tab-separated file with differentially regulated genes from DESeq2"),
		make_option("--rnk-output-file", type="character", help="output file in .rnk format for GSEA analysis"),
		make_option("--min-pvalue", type="numeric", help="minimum p-value for up- or down-regulated genes"),
		make_option("--min-adjpvalue", type="numeric", help="minimum adjusted p-value for up- or down-regulated genes")
)
opt <- parse_args(OptionParser(option_list=option_list))

g <- read.delim(opt$'deseq2-input-file')

g <- g[!is.na(g$pvalue) & !is.na(g$hgnc_symbol) & g$hgnc_symbol != "",]

if (!is.null(opt$'min-pvalue')) {
	g <- g[g$pvalue <= opt$'min-pvalue',]
}

if (!is.null(opt$'min-adjpvalue')) {
	g <- g[!is.na(g$padj) & g$padj <= opt$'min-adjpvalue',]
}

g$rank <- ifelse(g$baseMean.experiment > g$baseMean.control, -log(g$pvalue,10), log(g$pvalue,10))

g <- g[order(g$rank,decreasing=T),c("hgnc_symbol", "rank")]

write.table(g, opt$'rnk-output-file', col.names=F, row.names=F, sep="\t", quote=F)