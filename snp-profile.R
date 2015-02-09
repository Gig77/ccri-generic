library(optparse)
library(DNAcopy)

option_list <- list(
		make_option("--sample-id", type="character", help="Sample ID"),
		make_option("--tumor-coverage", type="character", help="coverage data for tumor sample"),
		make_option("--normal-coverage", type="character", help="coverage data for normal sample"),
		make_option("--tumor-vcf", type="character", help="VarScan2 VCF file from tumor"),
		make_option("--normal-vcf", type="character", help="VarScan2 VCF file from matched normal"),
		make_option("--disomic-chromosome", type="character", help="use coverage ratio of this chromosome for baseline shift (optional)"),
		make_option("--output-file", type="character", help="name of output file")
)
opt <- parse_args(OptionParser(option_list=option_list))

#opt <- data.frame('sample-id' = "715", 'tumor-coverage' = "coverage-genome/715R.coverage-genome.tsv", 'normal-coverage' = "coverage-genome/715C.coverage-genome.tsv", 'tumor-vcf' = "varscan/715R.varscan.dbsnp.vcf", 'normal-vcf' = "varscan/715C.varscan.dbsnp.vcf", 'output-file' = "snp-profile/715R.snp-profile.pdf", stringsAsFactors=F, check.names=F)   

# read coverage data
t.cov <- read.delim(opt$'tumor-coverage', header=F, colClasses=c("factor", "integer", "numeric"))
colnames(t.cov) <- c("chr", "pos", "count")
n.cov <- read.delim(opt$'normal-coverage', header=F, colClasses=c("factor", "integer", "numeric"))
colnames(n.cov) <- c("chr", "pos", "count")
m.cov <- merge(n.cov, t.cov, by=c("chr", "pos"))
m.cov$ratio <- log((m.cov[,"count.y"] / sum(m.cov[,"count.y"])) / (m.cov[,"count.x"] / sum(m.cov[,"count.x"])), 2)
m.cov$ratio <- m.cov$ratio - ifelse(!is.null(opt$'disomic-chromosome'), mean(m.cov$ratio[m.cov$chr == opt$'disomic-chromosome' & is.finite(m.cov$ratio)]), 0)
m.cov$ratio[m.cov$ratio > 1.5] <- 1.5
m.cov$ratio[m.cov$ratio < -1.5] <- -1.5
m.cov$chr <- as.factor(gsub("chr", "", as.character(m.cov$chr)))

# segment coverage
cna.cov <-CNA(genomdat = m.cov[,"ratio"], chrom = m.cov[,"chr"], maploc = m.cov[,"pos"], data.type = 'logratio')
cna.smooth <- smooth.CNA(cna.cov)
seg.cov <- segment(cna.smooth, alpha = 0.001, verbose=0, min.width=2)

# tumor VCF
t.vcf <- read.table(opt$'tumor-vcf', header=F, sep="\t", stringsAsFactors=F)
t.vcf <- t.vcf[t.vcf[,1] %in% c(1:22, "X", "Y") & grepl("rs", t.vcf[,3]),]
t.dp <- unlist(lapply(strsplit(t.vcf[,10], ":"), "[", 4))
t.pval <- as.numeric(unlist(lapply(strsplit(t.vcf[,10], ":"), "[", 8)))
t.af <- as.numeric(gsub("\\%", "", unlist(lapply(strsplit(t.vcf[,10], ":"), "[", 7)))) / 100

t.snps <- data.frame(chr=factor(t.vcf[,1], levels=c(1:22, "X", "Y")), pos=as.numeric(t.vcf[,2]), af=t.af, dbsnp=t.vcf[,3])
t.snps <- t.snps[t.pval<1e-6,]

# normal VCF
if (!is.null(opt$'normal-vcf')) {
	n.vcf <- read.table(opt$'normal-vcf', header=F, sep="\t", stringsAsFactors=F)
	n.vcf <- n.vcf[n.vcf[,1] %in% c(1:22, "X", "Y") & grepl("rs", n.vcf[,3]),]
	n.af <- as.numeric(gsub("\\%", "", unlist(lapply(strsplit(n.vcf[,10], ":"), "[", 7)))) / 100
	n.pval <- as.numeric(unlist(lapply(strsplit(n.vcf[,10], ":"), "[", 8)))
	
	# remove homozygous SNPs
	homsnp <- n.vcf[n.af>=0.8,3]
	keep <- (t.snps$dbsnp %in% n.vcf$V3) & (!t.snps$dbsnp %in% homsnp)
	print(sprintf("%d homozygous SNPs removed", sum(!keep)))
	t.snps.het <- t.snps[keep,]
	print(sprintf("Number of heterozygous SNPs: %d", nrow(t.snps.het)))
} else {
	print("No normal VCF specified. Removing all _putative_ homozygous SNPs with AF below threshold.")
	t.snps.het <- t.snps[t.snps$af < 0.8,]
}

# segment mirrored AF
t.snps.het$maf <- abs(t.snps.het$af - 0.5) + 0.5
cna.maf <-CNA(genomdat = t.snps.het[,"maf"], chrom = t.snps.het[,"chr"], maploc = t.snps.het[,"pos"], data.type = 'logratio')
cna.smooth <- smooth.CNA(cna.maf)
seg.maf <- segment(cna.smooth, alpha = 0.001, verbose=0, min.width=2)

# plot function coverage
plot.coverage <- function(data, segs) {
	plot(data[,"pos"], data[,"ratio"], ylim=c(-1.5,1.5), xaxt='n', yaxt='n', type="n")
	rect(par("usr")[1], par("usr")[3], par("usr")[2], par("usr")[4], col=rgb(0.99,0.99,0.99))
	points(data[,"pos"], data[,"ratio"], ylim=c(-1.5,1.5), cex=0.3, col="darkblue", lwd=0.5)
	axis(2, at=c(-1, 0, 1))
	abline(0, 0)
	for (i in which(abs(segs$seg.mean) >= 0.2)) {
		lines(c(segs$loc.start[i], segs$loc.end[i]),c(segs$seg.mean[i],segs$seg.mean[i]),type="l", col="orange", lty=1, lwd=2, yaxt='n')
	}
	abline(h=c(-1, log2(2/3), log2(3/2), 1), lty=2)
}

# plot function maf
plot.maf <- function(data, segs, xlim, title=title) {
	if (nrow(data) > 0) {
		plot(data[,"pos"], data[,"af"], ylim=c(0,1), xlim=xlim, cex=0.3, xaxt='n', yaxt='n', main=title, type='n')
		rect(par("usr")[1], par("usr")[3], par("usr")[2], par("usr")[4], col=rgb(0.99,0.99,0.99))
		points(data[,"pos"], data[,"af"], ylim=c(0,1), cex=0.3, col="darkblue", lwd=0.5)
	}
	else {
		plot(0, 0, ylim=c(0,1), cex=0.3, xaxt='n', yaxt='n', main=title)
		rect(par("usr")[1], par("usr")[3], par("usr")[2], par("usr")[4], col=rgb(0.97,0.97,0.97))
	}
	for(i in which(segs$seg.mean >= 0.6)) {
		lines(c(segs$loc.start[i], segs$loc.end[i]),c(segs$seg.mean[i],segs$seg.mean[i]),type="l", col="orange", lty=1, lwd=2)
		lines(c(segs$loc.start[i], segs$loc.end[i]),c(1-segs$seg.mean[i],1-segs$seg.mean[i]),type="l", col="orange", lty=1, lwd=2)
	}
	axis(2, at=c(0, 0.25, 1/3, 0.5, 2/3, 0.75, 1), labels=c("0", "", "", "0.5", "", "", "1"))
	abline(h=0.5)
	abline(h=c(1/3, 0.25, 2/3, 0.75), lty=2)
}

pdf(opt$'output-file', width=15, height=10)
layout(matrix(c(1,3,5,7,9,2,4,6,8,10,11,13,15,17,19,12,14,16,18,20,21,23,25,27,29,22,24,26,28,30,31,33,35,37,39,32,34,36,38,40,41,43,45,47,49,42,44,46,48,50),10,5,byrow=T));
par(oma=c(0, 0, 2, 0))
for (c in c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "X", "Y")) {
	par(mar=c(0,2,1,0.5))
	plot.maf(t.snps.het[t.snps.het$chr==c,], seg.maf$output[seg.maf$output$chrom==c,], xlim=c(0,max(m.cov$pos[m.cov$chr==c])), title=c)
	par(mar=c(0.2,2,0.2,0.5))
	plot.coverage(m.cov[m.cov$chr==c,], seg.cov$output[seg.cov$output$chrom==c,])
}
mtext(opt$'sample-id', outer=TRUE, cex=1.5)
dev.off()
