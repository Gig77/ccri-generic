library(exomeCopy)

target.file <- "~/generic/data/illumina/nexterarapidcapture_exome_targetedregions.nochr.bed"
bam.files <- list.files(path="~/p2ry8-crlf2/data/bam", pattern="*.bam$", full.names=T)
bam.files <- bam.files[!grepl("(abra|715C|715D|715C|715R_)", bam.files)]
sample.names <- paste0("S", sub(".*/bam/(.+).duplicate.*", "\\1", bam.files))
reference.file <- "~/generic/data/broad/human_g1k_v37.fasta"
num.states = 4

target.df <- read.delim(target.file, header = FALSE)
target <- GRanges(seqname = target.df[, 1], IRanges(start = target.df[,2] + 1, end = target.df[, 3]))
counts <- RangedData(space = seqnames(target), ranges = ranges(target))

for (i in 1:length(bam.files)) {
	counts[[sample.names[i]]] <- countBamInGRanges(bam.files[i], target)
}
save(counts, file="~/exomeCopy/counts.p2ry8.RData")

sample.names.bg <- sample.names[grep("C$", sample.names)]
#sample.names.bg <- sample.names.bg[!sample.names.bg %in% c("S360C", "S365C", "S400C", "S506C", "SGI13C", "SHV57C")] # exclude trisomy 21 cases from background

# correct for trisomy 21 in some normals before generating background
counts.bkp <- counts

counts[["S360C"]][seqnames(counts)=="21"] <- round(counts[["S360C"]][seqnames(counts)=="21"] / 3 * 2)
counts[["S365C"]][seqnames(counts)=="21"] <- round(counts[["S365C"]][seqnames(counts)=="21"] / 3 * 2)
counts[["S400C"]][seqnames(counts)=="21"] <- round(counts[["S400C"]][seqnames(counts)=="21"] / 3 * 2)
counts[["S506C"]][seqnames(counts)=="21"] <- round(counts[["S506C"]][seqnames(counts)=="21"] / 3 * 2)
counts[["SGI13C"]][seqnames(counts)=="21"] <- round(counts[["SGI13C"]][seqnames(counts)=="21"] / 3 * 2)
counts[["SHV57C"]][seqnames(counts)=="21"] <- round(counts[["SHV57C"]][seqnames(counts)=="21"] / 3 * 2)

counts[["GC"]] <- getGCcontent(target, reference.file)
counts[["GC.sq"]] <- counts$GC^2
counts[["bg"]] <- generateBackground(sample.names.bg, counts, median)
counts[["log.bg"]] <- log(counts[["bg"]] + 0.1)
counts[["bg.var"]] <- generateBackground(sample.names.bg, counts, var) 
counts[["width"]] <- width(counts)

counts[["S360C"]][seqnames(counts)=="21"] <- counts.bkp[["S360C"]][seqnames(counts)=="21"]
counts[["S365C"]][seqnames(counts)=="21"] <- counts.bkp[["S365C"]][seqnames(counts)=="21"]
counts[["S400C"]][seqnames(counts)=="21"] <- counts.bkp[["S400C"]][seqnames(counts)=="21"]
counts[["S506C"]][seqnames(counts)=="21"] <- counts.bkp[["S506C"]][seqnames(counts)=="21"]
counts[["SGI13C"]][seqnames(counts)=="21"] <- counts.bkp[["SGI13C"]][seqnames(counts)=="21"]
counts[["SHV57C"]][seqnames(counts)=="21"] <- counts.bkp[["SHV57C"]][seqnames(counts)=="21"]

rm(counts.bkp)

# remove outliers; gives more robust parameter optimization results
counts <- counts[counts[["bg.var"]]>quantile(counts[["bg.var"]], 0.01) & counts[["bg.var"]]<quantile(counts[["bg.var"]], 0.99),]

# plot background distribution per chromosome
#pdf("bg.pdf", width=10)
#boxplot(log(counts[["bg"]])~as.factor(seqnames(counts)), main="log normalized median background")
#dev.off()

sample <- "SHV57R"

fit.list <- lapply(c(sample), function(sample.name) {
	lapply(seqlevels(target)[seqlevels(target)!="MT"], function(seq.name) {
	#lapply(c("7"), function(seq.name) {
		exomeCopy(counts[seq.name], sample.name, X.names = c("log.bg", "GC", "GC.sq", "width"), S = 0:num.states, d = 2)
		#exomeCopy(counts[seq.name], sample.name, fit.var=TRUE, X.names = c("log.bg", "GC", "GC.sq", "width"), Y.names = c("bg.var"), S = 0:num.states, d = 2) # does not work... throws error: Error in ifelse(fit.var, NULL, phi.hat) : replacement has length zero
	})
})

compiled.segments <- compileCopyCountSegments(fit.list)
write.table(compiled.segments, file=paste0("~/exomeCopy/compiled.segments.", sample, ".tsv"), quote=FALSE, sep="\t", row.names=FALSE, col.names=TRUE)

# plotting
#plot(fit.list[[1]][[20]], xlim=c(50116548,50600628)) # chr7, IKZF1
pdf(paste0("~/exomeCopy/", sample, ".pdf"), width=15, height=7)
for(i in c(1,12, 16, 17, 18, 19, 20, 21, 22, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 23, 24)) { 
	plot(fit.list[[1]][[i]], main=fit.list[[1]][[i]]@ranges@partitioning@NAMES, cex=0.2, ylim=c(0, 6), xlab='', ylab='', cex.main=2, cex.axis=1, col=c("red", "orange", "gray", "deepskyblue", "blue")) 
}
dev.off()


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

# fit not individual chromosomes separately as suggested by vignette, but use larger genomic junks
# gives better results, probably due to more accurate GC bias estimates
# however, we cannot do the whole genome in one junk, because of integer overflow (max=2^31-1) :-(
counts.combined.1 <- counts["1"]
for (chr in c("3", "5", "7", "9", "11", "13", "15", "17", "19", "21", "Y")) {
	counts.combined.1 <- combine_chr(counts.combined.1, counts[chr])
}
counts.combined.2 <- counts["2"]
for (chr in c("4", "6", "8", "10", "12", "14", "16", "18", "20", "22", "X")) {
	counts.combined.2 <- combine_chr(counts.combined.2, counts[chr])
}

sample <- "S360C"
for (sample in sample.names) {
	fit.all.1 <- exomeCopy(counts.combined.1["1"], sample, X.names = c("log.bg", "GC", "GC.sq", "width"), S = 0:6, d = 2)
	fit.all.2 <- exomeCopy(counts.combined.2["2"], sample, X.names = c("log.bg", "GC", "GC.sq", "width"), S = 0:6, d = 2)

	fit.split <- list()
	fit.rest <- fit.all.1
	for (chr in c("1", "3", "5", "7", "9", "11", "13", "15", "17", "19", "21", "Y")) {
		splitted <- split_fit(fit.rest, chr, max(end(counts[chr])))
		fit.split[[chr]] <- splitted[[1]]
		fit.rest <- splitted[[2]] 
	}
	fit.rest <- fit.all.2
	for (chr in c("2", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22", "X")) {
		splitted <- split_fit(fit.rest, chr, max(end(counts[chr])))
		fit.split[[chr]] <- splitted[[1]]
		fit.rest <- splitted[[2]] 
	}

	pdf(paste0("~/exomeCopy/", sample, ".combined.tri21excl.pdf"), width=15, height=7)
	for (chr in c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "X", "Y")) {
		plot(fit.split[[chr]], main=chr, cex=0.2, ylim=c(0, 6), xlab='', ylab='', cex.main=2, cex.axis=1, col=c("red", "orange", "gray", "deepskyblue", "blue", "blue2", "blue4")) 
	}
	dev.off()
}


#--------------------------

counts.combined <- counts["1"]
for (chr in c("2", "3", "4", "5", "6")) {
	counts.combined <- combine_chr(counts.combined, counts[chr])
}

sample <- "SB36C"
source("exomeCopy.somatic.R"); fit <- exomeCopy.custom(counts["14"], sample, X.names = c("log.bg", "GC", "GC.sq", "width"), S = 0:3, d = 2); plot(fit)

for (sample in sample.names) {
	fit.list <- lapply(seqlevels(target)[seqlevels(target)!="MT"], function(seq.name) {
		exomeCopy(counts[seq.name], sample, X.names = c("log.bg", "GC", "GC.sq", "width"), S = 0:6, d = 2)
	})

	pdf(paste0("~/exomeCopy/", sample, ".filtered.pdf"), width=15, height=7)
	for(i in c(1,12, 16, 17, 18, 19, 20, 21, 22, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 23, 24)) { 
		plot(fit.list[[i]], main=fit.list[[i]]@ranges@partitioning@NAMES, cex=0.2, ylim=c(0, 6), xlab='', ylab='', cex.main=2, cex.axis=1, col=c("red", "orange", "gray", "deepskyblue", "blue", "blue2", "blue4")) 
	}
	dev.off()
}
