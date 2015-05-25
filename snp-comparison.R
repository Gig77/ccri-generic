library(optparse)

option_list <- list(
		make_option("--sample-id", type="character", help="Sample ID"),
		make_option("--tumor-vcf", type="character", help="VarScan2 VCF file from tumor"),
		make_option("--normal-vcf", type="character", help="VarScan2 VCF file from matched normal"),
		make_option("--output-file", type="character", help="name of output file")
)
opt <- parse_args(OptionParser(option_list=option_list))

#opt <- data.frame('sample-id' = "839R", 'tumor-vcf' = "varscan/839R.varscan.dbsnp.vcf", 'normal-vcf' = "varscan/839C.varscan.dbsnp.vcf", 'output-file' = "snp-comparison/839R.loh-segments.tsv", stringsAsFactors=F, check.names=F)   

# normal VCF
n.vcf <- read.table(opt$'normal-vcf', header=F, sep="\t", stringsAsFactors=F)
n.vcf <- n.vcf[n.vcf[,1] %in% c(1:22, "X", "Y") & grepl("rs", n.vcf[,3]),]
n.dp <- unlist(lapply(strsplit(n.vcf[,10], ":"), "[", 4))
n.pval <- as.numeric(unlist(lapply(strsplit(n.vcf[,10], ":"), "[", 8)))
n.snps <- n.vcf$V3[n.pval<=1e-20]

# tumor VCF
t.vcf <- read.table(opt$'tumor-vcf', header=F, sep="\t", stringsAsFactors=F)
t.vcf <- t.vcf[t.vcf[,1] %in% c(1:22, "X", "Y") & grepl("rs", t.vcf[,3]),]
t.dp <- unlist(lapply(strsplit(t.vcf[,10], ":"), "[", 4))
t.pval <- as.numeric(unlist(lapply(strsplit(t.vcf[,10], ":"), "[", 8)))
t.snps <- t.vcf$V3

result <- data.frame(sample=opt$'sample-id', num_snps=length(n.snps), pct_snps_conserved=length(intersect(t.snps, n.snps))/length(n.snps)*100)
write.table(result, file=opt$'output-file', row.names=F, col.names=T, quote=F, sep="\t")
