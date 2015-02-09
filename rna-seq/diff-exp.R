options(warn=1)
library(optparse)
library("DESeq2")
library("biomaRt")

set.seed(343)

option_list <- list(
		make_option("--control", type="character", help="list of htseq count files in control group, comma separated"),
		make_option("--experiment", type="character", help="list of htseq count files in experiment group, comma separated"),
		make_option("--output-tsv", type="character", help="output file name (TSV format)"),
		make_option("--output-xls", type="character", help="output file name (XLSX format)"),
		make_option("--name-subst-pattern", type="character", help="regular expression to extract sample name from count file")
)
opt <- parse_args(OptionParser(option_list=option_list))

#debugging
#opt <- data.frame(experiment="C57C3ACXX_CV_C1_14s006573-1-1_Vesely_lane214s006573_sequence.count,C57C3ACXX_CV_C2_14s006574-1-1_Vesely_lane214s006574_sequence.count,C57C3ACXX_CV_C3_14s006575-1-1_Vesely_lane314s006575_sequence.count,C57C3ACXX_CV_C4_14s006576-1-1_Vesely_lane414s006576_sequence.count,C57C3ACXX_CV_C5_14s006577-1-1_Vesely_lane414s006577_sequence.count,C57C3ACXX_CV_C6_14s006578-1-1_Vesely_lane414s006578_sequence.count,C57C3ACXX_CV_C7_14s006579-1-1_Vesely_lane314s006579_sequence.count,C57C3ACXX_CV_C8_14s006580-1-1_Vesely_lane414s006580_sequence.count,C57C3ACXX_CV_C9_14s006581-1-1_Vesely_lane314s006581_sequence.count,C57C3ACXX_CV_C10_14s006582-1-1_Vesely_lane314s006582_sequence.count,C57C3ACXX_CV_C11_14s006583-1-1_Vesely_lane414s006583_sequence.count,C57C3ACXX_CV_C12_14s006584-1-1_Vesely_lane414s006584_sequence.count",
#				  control="C57C3ACXX_CV_S1_14s006593-1-1_Vesely_lane314s006593_sequence.count",
#				  'name-subst-pattern'= ".*CV_(.\\d+)_.*",
#				  'output-tsv'="deseq/ER-vs-immature.tsv.part",
#				  stringsAsFactors=F, check.names=F)
				  
# prepare sample table for DESeq
#---
sample.files.ctl <- strsplit(opt$control, ",")[[1]] 
sample.files.exp <- strsplit(opt$experiment, ",")[[1]] 

sample.table <- data.frame(name=character(), file=character(), condition=character(), stringsAsFactors=F)
for(i in 1:length(sample.files.exp)) {
	if (grepl(":", sample.files.exp[i])) {
		sample.name <- strsplit(sample.files.exp[i], ":")[[1]][1]
		sample.file <- strsplit(sample.files.exp[i], ":")[[1]][2]
	} else {
		sample.name <- strsplit(sample.files.exp[i], ".count")[[1]][1]
		if (!is.null(opt$'name-subst-pattern')) { sample.name <- gsub(opt$'name-subst-pattern', "\\1", sample.name, perl=T) }
		print(sprintf("Adding experiment sample %s %s", sample.name, sample.files.exp[i]))
		sample.file <- sample.files.exp[i]
	}
	sample.table[nrow(sample.table)+1,] <- c(sample.name, sample.file, "experiment")
}
for(i in 1:length(sample.files.ctl)) {
	if (grepl(":", sample.files.ctl[i])) {
		sample.name <- strsplit(sample.files.ctl[i], ":")[[1]][1]
		sample.file <- strsplit(sample.files.ctl[i], ":")[[1]][2]
	} else {
		sample.name <- strsplit(sample.files.ctl[i], ".count")[[1]][1]
		if (!is.null(opt$'name-subst-pattern')) { sample.name <- gsub(opt$'name-subst-pattern', "\\1", sample.name, perl=T) }
		print(sprintf("Adding control sample %s %s", sample.name, sample.files.ctl[i]))
		sample.file <- sample.files.ctl[i]
	}
	sample.table[nrow(sample.table)+1,] <- c(sample.name, sample.file, "control")
}
sample.table$condition <- as.factor(sample.table$condition)

# find differentially expressed genes with DESeq2
#---
cds <- DESeqDataSetFromHTSeqCount(sampleTable = sample.table, directory="htseq", design=~condition)
cds <- estimateSizeFactors(cds)
#sizeFactors(cds)
counts.norm <- as.data.frame(counts(cds, normalized=T))
dds <- DESeq(cds)
res <- results(dds, cooksCutoff=FALSE)
res.df <- as.data.frame(res)
res.df$id <- rownames(res.df)

# annotate genes with Ensembl biomart
#---
biomartfile <- "~/generic/data/ensembl/genes.GRCh37v75.biomart.RData"
if(file.exists(biomartfile)) {
	load(biomartfile)
} else {
	library("biomaRt")
	mart <- useMart(biomart="ensembl", dataset="hsapiens_gene_ensembl") # GRCh37, v75
	genes <- getGene(res.df$id, "ensembl_gene_id", mart)
	save(genes, file=biomartfile)
}
res.annotated <- merge(res.df, genes[,c("ensembl_gene_id", "hgnc_symbol", "description", "chromosome_name", "start_position", "end_position")], by.x="id", by.y="ensembl_gene_id", all.x=T) # add gene annotation
res.annotated <- res.annotated[,c(1,8,10,11,12,9,2,3,4,5,6,7)] # reorder columns
res.annotated <- merge(res.annotated, counts.norm, by.x="id", by.y="row.names", all.x=T)  # add normalized read counts to output

# compute group-wise means
if (length(sample.files.exp) > 1) {
	res.annotated$baseMean.experiment <- rowMeans(res.annotated[,sample.table$name[sample.table$condition=="experiment"]], na.rm=T) 
} else {
	res.annotated$baseMean.experiment <- res.annotated[,sample.table$name[sample.table$condition=="experiment"]] 
}

if (length(sample.files.ctl) > 1) {
	res.annotated$baseMean.control <- rowMeans(res.annotated[,sample.table$name[sample.table$condition=="control"]], na.rm=T)
} else {
	res.annotated$baseMean.control <- res.annotated[,sample.table$name[sample.table$condition=="control"]]
}

# write output
#---
colorder <- c("id", "hgnc_symbol", "description", "chromosome_name", "start_position", "end_position", "baseMean", "baseMean.experiment", "baseMean.control", "log2FoldChange", "lfcSE", "stat", "pvalue", "padj")
res.annotated <- res.annotated[order(res.annotated$padj),c(colorder, names(res.annotated)[!names(res.annotated) %in% colorder])]
write.table(res.annotated, file=opt$'output-tsv', col.names=T, row.names=F, sep="\t", quote=F)

if (!is.null(opt$'output-xls')) {
	options(java.parameters="-Xmx4g")
	library("XLConnect")
	wb <- loadWorkbook(opt$'output-xls', create = TRUE)
	createSheet(wb, name = "Sheet1")
	writeWorksheet(wb, res.annotated, sheet = "Sheet1", startRow = 1, startCol = 1)
	saveWorkbook(wb)
}
