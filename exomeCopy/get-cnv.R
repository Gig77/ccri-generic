options(warn=1)
library(optparse)
library(gtools)

option_list <- list(
		make_option("--sample", type="character", help="sample name")
		)
opt <- parse_args(OptionParser(option_list=option_list))
#opt <- data.frame(sample="DL2C", stringsAsFactors=F)

if (invalid(opt$sample)) stop("sample not specified")

library(exomeCopy)

# ======================================
# combine individual chromosome to single virtual chromosome to improve optimization; 
# otherwise, CN estimates are off for single chromosomes with strong GC bias (e.g. chr13 in patient HV57R
#=======================================

combine_chr <- function(rd1, rd2) {
	print(paste0("Merging ", names(rd2), ": ", max(end(rd1))))
	tmp <- rd2
	ranges(tmp) <- shift(ranges(tmp), max(end(rd1)))
	names(tmp) <- names(rd1)
	rbind(rd1, tmp)
}

split_fit <- function(fit, chr, size) {
	extract <- end(fit@ranges[[1]]) <= size

	fit_first <- fit
	fit_first@ranges[[1]] <- fit_first@ranges[[1]][extract]
	fit_first@O.norm <- fit_first@O.norm[extract] 
	fit_first@log.odds <- fit_first@log.odds[extract] 
	fit_first@path <- fit_first@path[extract]
	names(fit_first@ranges) <- chr

	fit_second <- fit
	fit_second@ranges[[1]] <- fit_second@ranges[[1]][!extract]
	fit_second@ranges[[1]] <- shift(fit_second@ranges[[1]], -size) 
	fit_second@O.norm <- fit_second@O.norm[!extract] 
	fit_second@log.odds <- fit_second@log.odds[!extract] 
	fit_second@path <- fit_second@path[!extract]
	
	list(fit_first, fit_second)
}

sex.list <- read.delim("~/p2ry8-crlf2/results/patient_sex.tsv")
patient <- gsub("(C|D|R|R2|R3)$", "", opt$sample, perl=T)
sex <- sex.list$sex[sex.list$patient==patient]

if (invalid(sex)) stop(sprintf("ERROR: could not determine sex of patient %s (sample %s). Check if there is an entry in sex file ~/p2ry8-crlf2/results/patient_sex.tsv", patient, opt$sample))

# load counts and background estimates
load("counts.bg.RData")

# remove outliers; gives more robust parameter optimization results
counts <- counts[counts[["bg.var"]]>quantile(counts[["bg.var"]], 0.01) & counts[["bg.var"]]<quantile(counts[["bg.var"]], 0.99),]
#counts <- counts[counts[["bg.var"]]>0.001 & counts[["bg.var"]]<0.2,]

# alternative: exclude sex chromosomes because they will have high variability due to sex differences of samples
#lower.var <- quantile(counts[!space(counts) %in% c("X", "Y"),][["bg.var"]], 0.01)
#upper.var <- quantile(counts[!space(counts) %in% c("X", "Y"),][["bg.var"]], 0.95)
#counts <- counts[space(counts) %in% c("X", "Y") | (counts[["bg.var"]] >= lower.var & counts[["bg.var"]] <= upper.var),]

# we do not fit individual chromosomes separately as suggested by vignette, but use larger genomic junks
# gives better results, probably due to more accurate GC bias estimates
# however, we cannot do the whole genome at once, because of integer overflow (max=2^31-1) :-(
counts.combined.1 <- counts["1"]
for (chr in c("2", "3", "4", "5", "7", "9", "11", "13", "15", "17", "19", "21")) {
	counts.combined.1 <- combine_chr(counts.combined.1, counts[chr])
}
counts.combined.2 <- counts["1"]
for (chr in c("2", "3", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22")) {
	counts.combined.2 <- combine_chr(counts.combined.2, counts[chr])
}

# fit model
#if (sex == "m") {
#	fit.all.1 <- exomeCopy(counts.combined.1["1"], opt$sample, X.names = c("log.bg.male", "GC", "GC.sq", "width"), S = 0:6, d = 2)
#	fit.all.2 <- exomeCopy(counts.combined.2["1"], opt$sample, X.names = c("log.bg.male", "GC", "GC.sq", "width"), S = 0:6, d = 2)
#} else if (sex == "f") { 
#	fit.all.1 <- exomeCopy(counts.combined.1["1"], opt$sample, X.names = c("log.bg.female", "GC", "GC.sq", "width"), S = 0:6, d = 2)
#	fit.all.2 <- exomeCopy(counts.combined.2["1"], opt$sample, X.names = c("log.bg.female", "GC", "GC.sq", "width"), S = 0:6, d = 2)
#} else {
#	stop(sprintf("Invalid sex %s", sex))
#}
fit.all.1 <- exomeCopy(counts.combined.1["1"], opt$sample, X.names = c("log.bg", "GC", "GC.sq", "width"), S = 0:6, d = 2)
fit.all.2 <- exomeCopy(counts.combined.2["1"], opt$sample, X.names = c("log.bg", "GC", "GC.sq", "width"), S = 0:6, d = 2)
if (sex == "m") {
	fit.X <- exomeCopy(counts["X"], opt$sample, X.names = c("log.bg.male", "GC", "GC.sq", "width"), S = 0:6, d = 2)  # d=1 causes troubles with pseudoautosomal regions on X masked on Y
	fit.Y <- exomeCopy(counts["Y"], opt$sample, X.names = c("log.bg.male", "GC", "GC.sq", "width"), S = 0:6, d = 1)
} else if (sex == "f") { 
	fit.X <- exomeCopy(counts["X"], opt$sample, X.names = c("log.bg.female", "GC", "GC.sq", "width"), S = 0:6, d = 2)
} else {
	stop(sprintf("Invalid sex %s", sex))
}
#fit.all.1 <- exomeCopy(counts.combined.1["1"], opt$sample, X.names = c("log.bg", "GC.sq", "width"), Y.names = c("log.bg.var"), fit.var = TRUE, S = 0:6, d = 2)
#fit.all.2 <- exomeCopy(counts.combined.2["1"], opt$sample, X.names = c("log.bg", "GC.sq", "width"), Y.names = c("log.bg.var"), fit.var = TRUE, S = 0:6, d = 2)

# split into chromosomes again
fit <- list()
fit[[opt$sample]] <- list()
fit.rest <- fit.all.1
for (chr in c("1", "2", "3", "4", "5", "7", "9", "11", "13", "15", "17", "19", "21")) {
	splitted <- split_fit(fit.rest, chr, max(end(counts[chr])))
	fit.rest <- splitted[[2]] 
	if (!chr %in% c("2", "4")) {
		fit[[opt$sample]][[chr]] <- splitted[[1]]
	}
}
fit.rest <- fit.all.2
for (chr in c("1", "2", "3", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22")) {
	splitted <- split_fit(fit.rest, chr, max(end(counts[chr])))
	fit.rest <- splitted[[2]] 
	if (!chr %in% c("1", "3")) {
		fit[[opt$sample]][[chr]] <- splitted[[1]]
	}
}
fit[[opt$sample]][["X"]] <- fit.X

if (sex == "m") {
	fit[[opt$sample]][["Y"]] <- fit.Y
}

# plot results
pdf(paste0(opt$sample, ".combined.pdf"), width=15, height=7)
for (chr in c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "X", "Y")) {

	if (sex == "f" && chr =="Y") {
		next
	}
	
	cols <- c("red", "orange", "gray", "deepskyblue", "blue", "blue2", "blue4")
	if (sex == "m" && chr %in% c("X", "Y")) {
		cols <- c("red", "gray", "deepskyblue", "blue", "blue2", "blue4", "blue4")
	}
	plot(fit[[opt$sample]][[chr]], main=chr, cex=0.2, ylim=c(0, 6), xlab='', ylab='', cex.main=2, cex.axis=1, col=cols) 
}
dev.off()

# get compiled segments
compiled.segments <- compileCopyCountSegments(fit)
compiled.segments$genes <- as.character(NA)

# annotate segments with overlapping gene names
if(file.exists("genes.GRCh37v75.biomart.RData")) {
	load("genes.GRCh37v75.biomart.RData")
} else {
	library("biomaRt")
	mart <- useMart(biomart="ensembl", dataset="hsapiens_gene_ensembl") # GRCh37, v75
	genes <- getBM(c("hgnc_symbol", "ensembl_gene_id", "chromosome_name", "start_position", "end_position"), mart=mart)
	save(genes, file="genes.GRCh37v75.biomart.RData")
}
gr.genes <- GRanges(seqnames=genes$chromosome_name, ranges=IRanges(start=genes$start_position, end=genes$end_position), names=genes$hgnc_symbol)

o <- findOverlaps(compiled.segments, gr.genes)
for(i in 1:nrow(compiled.segments)) { gnames <- values(gr.genes[o@subjectHits[o@queryHits==i]])$names; compiled.segments[["genes"]][i] <- paste(gnames[gnames!=""], collapse=",") }

# write table
write.table(compiled.segments, file=paste0(opt$sample, ".compiled-segments.tsv"), quote=FALSE, sep="\t", row.names=FALSE, col.names=TRUE)

