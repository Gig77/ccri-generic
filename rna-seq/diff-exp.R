options(warn=1)
library(optparse)
library("DESeq2")
library("biomaRt")

set.seed(343)

option_list <- list(
		make_option("--control", type="character", help="list of htseq count files in control group, comma separated"),
		make_option("--experiment", type="character", help="list of htseq count files in experiment group, comma separated"),
		make_option("--output-tsv", type="character", help="output file name (TSV format)"),
		make_option("--output-xls", type="character", help="output file name (XLSX format)")
)
opt <- parse_args(OptionParser(option_list=option_list))

#debugging
#opt <- data.frame(control="18378:18378_CGAAGG_C4993ACXX_5_20140509B_20140509.count,18379:18379_AAGACA_C4993ACXX_5_20140509B_20140509.count", 
#		          experiment="18380:18380_TAATCG_C4993ACXX_5_20140509B_20140509.count,18381:18381_CGCAAC_C4993ACXX_5_20140509B_20140509.count",
#				  'output-tsv'="deseq/strobl-dox-empty-vs-etv6.deseq2.tsv",
#				  'output-xls'="deseq/strobl-dox-empty-vs-etv6.deseq2.xlsx",
#				  stringsAsFactors=F, check.names=F)

# prepare sample table for DESeq
#---
sample.files.ctl <- strsplit(opt$control, ",")[[1]] 
sample.files.exp <- strsplit(opt$experiment, ",")[[1]] 

sample.table <- data.frame(name=character(), file=character(), condition=character(), stringsAsFactors=F)
for(i in 1:length(sample.files.ctl)) {
	sample.name <- strsplit(sample.files.ctl[i], ":")[[1]][1]
	sample.file <- strsplit(sample.files.ctl[i], ":")[[1]][2]
	sample.table[nrow(sample.table)+1,] <- c(sample.name, sample.file, "control")
}
for(i in 1:length(sample.files.exp)) {
	sample.name <- strsplit(sample.files.exp[i], ":")[[1]][1]
	sample.file <- strsplit(sample.files.exp[i], ":")[[1]][2]
	sample.table[nrow(sample.table)+1,] <- c(sample.name, sample.file, "experiment")
}
sample.table$condition <- as.factor(sample.table$condition)

# find differentially expressed genes with DESeq2
#---
cds <- DESeqDataSetFromHTSeqCount(sampleTable = sample.table, directory="htseq", design=~condition)
cds <- estimateSizeFactors(cds)
#sizeFactors(cds)
counts.norm <- as.data.frame(counts(cds, normalized=T))
dds <- DESeq(cds)
res <- results(dds)
res.df <- as.data.frame(res)
res.df$id <- rownames(res.df)

# annotate genes with Ensembl biomart
#---
mart <- useMart(biomart="ensembl", dataset="hsapiens_gene_ensembl") # GRCh37, v75
genes <- getGene(res.df$id, "ensembl_gene_id", mart)
res.annotated <- merge(res.df, genes[,1:3], by.x="id", by.y="ensembl_gene_id", all.x=T) # add gene annotation
res.annotated <- res.annotated[,c(1,8,9,2,3,4,5,6,7)] # reorder columns
res.annotated <- merge(res.annotated, counts.norm, by.x="id", by.y="row.names", all.x=T)  # add normalized read counts to output

# write output
#---
res.annotated <- res.annotated[order(res.annotated$padj),]

write.table(res.annotated, file=opt$'output-tsv', col.names=T, row.names=F, sep="\t", quote=F)
if (!is.null(opt$'output-xls')) {
	options(java.parameters="-Xmx4g")
	library("XLConnect")
	wb <- loadWorkbook(opt$'output-xls', create = TRUE)
	createSheet(wb, name = "Sheet1")
	writeWorksheet(wb, res.annotated, sheet = "Sheet1", startRow = 1, startCol = 1)
	saveWorkbook(wb)
}