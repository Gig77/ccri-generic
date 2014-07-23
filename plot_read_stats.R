options(warn=1)
library("RColorBrewer")
library(optparse)

option_list <- list(
		make_option("--input", type="character", help="input file with data"),
		make_option("--y-max", type="numeric", help="maximum value y-axis"),
		make_option("--output", type="character", help="output file (PDF)")
)
opt <- parse_args(OptionParser(option_list=option_list))

#debugging
#opt <- data.frame(input="~/sponge/results/qc/allpatients.stats.txt", output="~/sponge/results/qc/allpatients.stats.pdf", 'y-max'=40, stringsAsFactors=F, check.names=F) # for test purposes

sample2lab <- list(
		
		# iamp
		"18529_GTCCGC_C4VVVACXX_1_20140704B_20140704" = "18529",
		"18530_TAGCTT_C4VVVACXX_1_20140704B_20140704" = "18530",
		"18531_AGTTCC_C4VVVACXX_1_20140704B_20140704" = "18531",
		"18532_CGATGT_C4VVVACXX_1_20140704B_20140704" = "18532",
		"18533_ATCACG_C4VVVACXX_1_20140704B_20140704" = "18533",
		"18534_TGACCA_C4VVVACXX_1_20140704B_20140704" = "18534",
		"18535_TTAGGC_C4VVVACXX_1_20140704B_20140704" = "18535",
		"18536_ACAGTG_C4VVVACXX_1_20140704B_20140704" = "18536",
		
		# chrisi
		"18370_AATAGC_C4E7NACXX_8_20140603B_20140603" = "18370",
		"18371_TTAACT_C4E7NACXX_8_20140603B_20140603" = "18371",
		"18372_AATGAA_C4E7NACXX_8_20140603B_20140603" = "18372",
		"18373_GATTGT_C4E7NACXX_8_20140603B_20140603" = "18373",
		"18374_ATAAGA_C4E7NACXX_8_20140603B_20140603" = "18374",
		"18375_GCCACA_C4E7NACXX_8_20140603B_20140603" = "18375",
		"18376_ACATTA_C4993ACXX_5_20140509B_20140509" = "18376",
		"18377_GGTGAG_C4993ACXX_5_20140509B_20140509" = "18377",
		"18378_CGAAGG_C4993ACXX_5_20140509B_20140509" = "18378",
		"18379_AAGACA_C4993ACXX_5_20140509B_20140509" = "18379",
		"18380_TAATCG_C4993ACXX_5_20140509B_20140509" = "18380",
		"18381_CGCAAC_C4993ACXX_5_20140509B_20140509" = "18381",
		
		# fikret
		"C3JP8ACXX_07-644-T_14s001414-1-1_Rifatbegovic_lane214s001414_sequence" = "644-T",   
		"C3JP8ACXX_08-644-M_14s001415-1-1_Rifatbegovic_lane214s001415_sequence" = "644-M",   
		"C3JP8ACXX_09-644-D_14s001416-1-1_Rifatbegovic_lane214s001416_sequence" = "644-D",
		"C3JP8ACXX_10-919-T_14s001417-1-1_Rifatbegovic_lane214s001417_sequence" = "919-T",
		"C3JP8ACXX_11-919-M_14s001418-1-1_Rifatbegovic_lane214s001418_sequence" = "919-M",
		"C3JP8ACXX_12-919-D_14s001419-1-1_Rifatbegovic_lane214s001419_sequence" = "919-D",
		
		# modicell
		"C308GACXX_01_14s000452-1-1_Heitger_lane114s000452_sequence" = "14s000452",
		"C308GACXX_02_14s000453-1-1_Heitger_lane114s000453_sequence" = "14s000453",
		
		# sponge
		"BSF_0102_C49ATACXX_30" = "30",
		"BSF_0102_C49ATACXX_3_Amir1792" = "Amir1792",
		"BSF_0102_C49ATACXX_3_Amir25" = "Amir25",
		"BSF_0102_C49ATACXX_3_Bmir1792" = "Bmir1792",
		"BSF_0102_C49ATACXX_3_Bmir25" = "Bmir25",
		"BSF_0102_C49ATACXX_3_ACXCR4" = "ACXCR4",
		"BSF_0102_C49ATACXX_3_Amir20" = "Amir20",
		"BSF_0102_C49ATACXX_3_BCXCR4" = "BCXCR4",
		"BSF_0102_C49ATACXX_3_Bmir20" = "Bmir20",
		"BSF_0102_C49ATACXX_3_BmirComb" = "BmirComb"
)

pdf(opt$output, width=10)

d <- read.delim(opt$input, row.names=1, check.names=F)
d <- d[sapply(rownames(d), function(x) !is.null(sample2lab[[x]])),]
rownames(d) <- sapply(rownames(d), function(x) sample2lab[[x]])

#cols <- c("black", "white", brewer.pal(8, "Set1")[3:8])
#cols <- brewer.pal(8, "Accent")
cols <- c("#332288", "#88CCEE", "#117733", "#DDCC77", "#CC6677", "#AA4499", "#44AA99", "#882255")

barplot(t(d)/1000000, beside=T, xaxt='n', yaxt='n', ylim=c(0, opt$'y-max'))
abline(h=seq(0, opt$'y-max', by=5), col="gray", lty=2)
barplot(t(d)/1000000, beside=T, col=cols, ylab="number of reads x 1,000,000", xlab="samples", yaxt='n', ylim=c(0, 35), add=T)
box()
axis(side=2, at=seq(0, opt$'y-max', by=1), labels=NA, tck=-0.01)
axis(side=2, at=seq(0, opt$'y-max', by=5))
legend("topright", bg="white", colnames(d), fill=cols, ncol=4, cex=0.8)

dev.off()