options(warn=1)
library(optparse)

sample2lab <- list(
		"18529_GTCCGC_C4VVVACXX_1_20140704B_20140704.subsamples.count" = "18529",
		"18530_TAGCTT_C4VVVACXX_1_20140704B_20140704.subsamples.count" = "18530",
		"18531_AGTTCC_C4VVVACXX_1_20140704B_20140704.subsamples.count" = "18531",
		"18532_CGATGT_C4VVVACXX_1_20140704B_20140704.subsamples.count" = "18532",
		"18533_ATCACG_C4VVVACXX_1_20140704B_20140704.subsamples.count" = "18533",
		"18534_TGACCA_C4VVVACXX_1_20140704B_20140704.subsamples.count" = "18534",
		"18535_TTAGGC_C4VVVACXX_1_20140704B_20140704.subsamples.count" = "18535",
		"18536_ACAGTG_C4VVVACXX_1_20140704B_20140704.subsamples.count" = "18536",
		
		"18370_AATAGC_C4E7NACXX_8_20140603B_20140603.subsamples.count" = 18370,
		"18371_TTAACT_C4E7NACXX_8_20140603B_20140603.subsamples.count" = 18371,
		"18372_AATGAA_C4E7NACXX_8_20140603B_20140603.subsamples.count" = 18372,
		"18373_GATTGT_C4E7NACXX_8_20140603B_20140603.subsamples.count" = 18373,
		"18374_ATAAGA_C4E7NACXX_8_20140603B_20140603.subsamples.count" = 18374,
		"18375_GCCACA_C4E7NACXX_8_20140603B_20140603.subsamples.count" = 18375,
		"18376_ACATTA_C4993ACXX_5_20140509B_20140509.subsamples.count" = 18376,
		"18377_GGTGAG_C4993ACXX_5_20140509B_20140509.subsamples.count" = 18377,
		"18378_CGAAGG_C4993ACXX_5_20140509B_20140509.subsamples.count" = 18378,
		"18379_AAGACA_C4993ACXX_5_20140509B_20140509.subsamples.count" = 18379,
		"18380_TAATCG_C4993ACXX_5_20140509B_20140509.subsamples.count" = 18380,
		"18381_CGCAAC_C4993ACXX_5_20140509B_20140509.subsamples.count" = 18381,

		"C3JP8ACXX_07-644-T_14s001414-1-1_Rifatbegovic_lane214s001414_sequence.subsamples.count" = "644-T",   
		"C3JP8ACXX_08-644-M_14s001415-1-1_Rifatbegovic_lane214s001415_sequence.subsamples.count" = "644-M",   
		"C3JP8ACXX_09-644-D_14s001416-1-1_Rifatbegovic_lane214s001416_sequence.subsamples.count" = "644-D",
		"C3JP8ACXX_10-919-T_14s001417-1-1_Rifatbegovic_lane214s001417_sequence.subsamples.count" = "919-T",
		"C3JP8ACXX_11-919-M_14s001418-1-1_Rifatbegovic_lane214s001418_sequence.subsamples.count" = "919-M",
		"C3JP8ACXX_12-919-D_14s001419-1-1_Rifatbegovic_lane214s001419_sequence.subsamples.count" = "919-D"

)

option_list <- list(
		make_option("--input-dir", type="character", help="input directory with count data"),
		make_option("--min-reads", type="numeric", help="minimum number of reads per gene"),
		make_option("--y-max", type="numeric", help="y-axis maximum value"),
		make_option("--output", type="character", help="output file (PDF)")
)
opt <- parse_args(OptionParser(option_list=option_list))

#opt <- data.frame('input-dir'="~/fikret/results/htseq", 'min-reads'= 3, 'y-max' = 35000, 'output-file'="~/fikret/results/htseq/coverage-saturation-curve.pdf", stringsAsFactors=F, check.names=F)

files <- list.files(path=opt$'input-dir', pattern=".subsamples.count$")
files <- files[sapply(files, function(x) !is.null(sample2lab[[x]]))]

pdf(opt$'output')

plot(NA, xlim=c(1,10), ylim=c(1,opt$'y-max'), ylab=sprintf("No. of transcripts with >= %d reads", opt$'min-reads'), xlab="fraction of reads sampled", xaxt="n")
axis(1, at=1:10, labels=c("10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%"))
label <- character()
for (i in 1:length(files)) {
	counts <- read.delim(paste0(opt$'input-dir', "/", files[i]))
	numgenes <- sapply(counts[,-1], function(x) sum(x >= opt$'min-reads'))
	points(1:length(numgenes), numgenes, type="b", lty=i%%6+1, col=i, pch=i)
	label[i] <- ifelse(is.null(sample2lab[[files[i]]]), files[i], sample2lab[[files[i]]])
}
legend("topleft", label, lty=1:length(label)%%6+1, col=1:length(label), pch=1:length(label), ncol=2)

dev.off()
