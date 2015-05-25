options(warn=1)
library("RColorBrewer")
library(optparse)
library(gtools)

option_list <- list(
		make_option("--input", type="character", help="input file with data"),
		make_option("--y-max", type="numeric", help="maximum value y-axis"),
		make_option("--output", type="character", help="output file (PDF)")
)
opt <- parse_args(OptionParser(option_list=option_list))
#opt <- data.frame(input="~/fikret/results/qc/allpatients.stats.txt", output="~/fikret/results/qc/allpatients.stats.pdf", 'y-max'=60, stringsAsFactors=F, check.names=F) # for test purposes

ymax <- ifelse(invalid(opt$'y-max'), 40, opt$'y-max')

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
		
		"C57C3ACXX_CV_C1_14s006573-1-1_Vesely_lane214s006573_sequence" = "C1",
		"C57C3ACXX_CV_C2_14s006574-1-1_Vesely_lane214s006574_sequence" = "C2",
		"C57C3ACXX_CV_C3_14s006575-1-1_Vesely_lane314s006575_sequence" = "C3",
		"C57C3ACXX_CV_C4_14s006576-1-1_Vesely_lane414s006576_sequence" = "C4",
		"C57C3ACXX_CV_C5_14s006577-1-1_Vesely_lane414s006577_sequence" = "C5",
		"C57C3ACXX_CV_C6_14s006578-1-1_Vesely_lane414s006578_sequence" = "C6",
		"C57C3ACXX_CV_C7_14s006579-1-1_Vesely_lane314s006579_sequence" = "C7",
		"C57C3ACXX_CV_C8_14s006580-1-1_Vesely_lane414s006580_sequence" = "C8",
		"C57C3ACXX_CV_C9_14s006581-1-1_Vesely_lane314s006581_sequence" = "C9",
		"C57C3ACXX_CV_C10_14s006582-1-1_Vesely_lane314s006582_sequence" = "C10",
		"C57C3ACXX_CV_C11_14s006583-1-1_Vesely_lane414s006583_sequence" = "C11",
		"C57C3ACXX_CV_C12_14s006584-1-1_Vesely_lane414s006584_sequence" = "C12",

		"C57C3ACXX_CV_A1_14s006561-1-1_Vesely_lane114s006561_sequence" = "A1",
		"C57C3ACXX_CV_A2_14s006562-1-1_Vesely_lane114s006562_sequence" = "A2",
		"C57C3ACXX_CV_A3_14s006563-1-1_Vesely_lane114s006563_sequence" = "A3",
		"C57C3ACXX_CV_A4_14s006564-1-1_Vesely_lane114s006564_sequence" = "A4",
		"C57C3ACXX_CV_A5_14s006565-1-1_Vesely_lane114s006565_sequence" = "A5",
		"C57C3ACXX_CV_A7_14s006566-1-1_Vesely_lane114s006566_sequence" = "A7",
		"C57C3ACXX_CV_A8_14s006567-1-1_Vesely_lane114s006567_sequence" = "A8",
		"C57C3ACXX_CV_A9_14s006568-1-1_Vesely_lane214s006568_sequence" = "A9",
		"C57C3ACXX_CV_A10_14s006569-1-1_Vesely_lane214s006569_sequence" = "A10",
		"C57C3ACXX_CV_A11_14s006570-1-1_Vesely_lane214s006570_sequence" = "A11",
		"C57C3ACXX_CV_A12_14s006571-1-1_Vesely_lane214s006571_sequence" = "A12",
		"C57C3ACXX_CV_A13_14s006572-1-1_Vesely_lane214s006572_sequence" = "A13",

		"C57C3ACXX_CV_D1_14s006585-1-1_Vesely_lane414s006585_sequence" = "D1",
		"C57C3ACXX_CV_D2_14s006586-1-1_Vesely_lane514s006586_sequence" = "D2",
		"C57C3ACXX_CV_D3_14s006587-1-1_Vesely_lane514s006587_sequence" = "D3",
		"C57C3ACXX_CV_D4_14s006588-1-1_Vesely_lane514s006588_sequence" = "D4",
		"C57C3ACXX_CV_D5_14s006589-1-1_Vesely_lane514s006589_sequence" = "D5",
		"C57C3ACXX_CV_D6_14s006590-1-1_Vesely_lane514s006590_sequence" = "D6",
		"C57C3ACXX_CV_D7_14s006591-1-1_Vesely_lane514s006591_sequence" = "D7",
		"C57C3ACXX_CV_D8_14s006592-1-1_Vesely_lane514s006592_sequence" = "D8",

		"C57C3ACXX_CV_S1_14s006593-1-1_Vesely_lane314s006593_sequence" = "S1",
		"C57C3ACXX_CV_S2_14s006594-1-1_Vesely_lane314s006594_sequence" = "S2",
		"C57C3ACXX_CV_S3_14s006595-1-1_Vesely_lane314s006595_sequence" = "S3",

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

d <- read.delim(opt$input, row.names=1, check.names=F)
d <- d[order(d$'uniquely mapped', decreasing=T),]
#d <- d[sapply(rownames(d), function(x) !is.null(sample2lab[[x]])),]
rownames(d) <- sapply(rownames(d), function(x) ifelse(!is.null(sample2lab[[x]]), sample2lab[[x]], x))

#cols <- c("black", "white", brewer.pal(8, "Set1")[3:8])
#cols <- brewer.pal(8, "Accent")
cols <- c("#332288", "#88CCEE", "#117733", "#DDCC77", "#CC6677", "#AA4499", "#44AA99", "#882255")

pdf(opt$output, width=10)

# all counts, grouped by sample; 8 sample per page; sorted by uniquely mapped reads in decreasing order
chunks <- split(rownames(d), ceiling(seq_along(rownames(d))/8))
for(i in 1:length(chunks)) {
	chunk <- d[chunks[[i]],]
	barplot(t(chunk)/1000000, beside=T, xaxt='n', yaxt='n', ylim=c(0, ymax))
	abline(h=seq(0, ymax, by=5), col="gray", lty=2)
	par(cex.axis=0.6)
	barplot(t(chunk)/1000000, beside=T, col=cols, ylab="number of reads x 1,000,000", xlab="sample", yaxt='n', ylim=c(0, 35), add=T)
	box()
	axis(side=2, at=seq(0, ymax, by=1), labels=NA, tck=-0.01)
	axis(side=2, at=seq(0, ymax, by=5))
	legend("topright", bg="white", colnames(chunk), fill=cols, ncol=4, cex=0.8)
}

# individual counts over all patients, samples ordered by decreasing read counts
barplot(main="Total reads", d[order(d$total, decreasing=T),"total"]/1000000, ylim=c(0, ymax), cex.names=0.5, names=rownames(d)[order(d$total, decreasing=T)], las=2, ylab="number of reads x 1,000,000", col=cols[1])
barplot(main="Pass QC reads", d[order(d$'pass QC', decreasing=T),"pass QC"]/1000000, ylim=c(0, ymax), cex.names=0.5, names=rownames(d)[order(d$'pass QC', decreasing=T)], las=2, ylab="number of reads x 1,000,000", col=cols[2])
barplot(main="Pass QC + mapped reads", d[order(d$'mapped', decreasing=T),"mapped"]/1000000, ylim=c(0, ymax), cex.names=0.5, names=rownames(d)[order(d$'mapped', decreasing=T)], las=2, ylab="number of reads x 1,000,000", col=cols[3])
barplot(main="Pass QC + mapped + exonic reads", d[order(d$'exonic', decreasing=T),"exonic"]/1000000, ylim=c(0, ymax), cex.names=0.5, names=rownames(d)[order(d$'exonic', decreasing=T)], las=2, ylab="number of reads x 1,000,000", col=cols[4])
barplot(main="Pass QC + mapped + exonic + non-rRNA reads", d[order(d$'non-rRNA', decreasing=T),"non-rRNA"]/1000000, ylim=c(0, ymax), cex.names=0.5, names=rownames(d)[order(d$'non-rRNA', decreasing=T)], las=2, ylab="number of reads x 1,000,000", col=cols[5])
barplot(main="Pass QC + mapped + exonic + non-rRNA + protein-coding reads", d[order(d$'protein', decreasing=T),"protein"]/1000000, ylim=c(0, ymax), cex.names=0.5, names=rownames(d)[order(d$'protein', decreasing=T)], las=2, ylab="number of reads x 1,000,000", col=cols[6])
barplot(main="Pass QC + mapped + exonic + non-rRNA + protein-coding + uniquely mapped reads", d[order(d$'uniquely mapped', decreasing=T),"uniquely mapped"]/1000000, ylim=c(0, ymax), cex.names=0.5, names=rownames(d)[order(d$'uniquely mapped', decreasing=T)], las=2, ylab="number of reads x 1,000,000", col=cols[7])
barplot(main="Pass QC + mapped + exonic + non-rRNA + protein-coding + uniquely mapped + non-duplicated reads", d[order(d$'non-duplicates', decreasing=T),"non-duplicates"]/1000000, ylim=c(0, ymax), cex.names=0.5, names=rownames(d)[order(d$'non-duplicates', decreasing=T)], las=2, ylab="number of reads x 1,000,000", col=cols[8])


dev.off()

