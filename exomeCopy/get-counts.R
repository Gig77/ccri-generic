library(exomeCopy)

target.file <- "~/generic/data/illumina/nexterarapidcapture_exome_targetedregions.nochr.bed"
bam.files <- list.files(path="~/p2ry8-crlf2/data/bam", pattern="*.bam$", full.names=T)
bam.files <- bam.files[!grepl("(abra|715)", bam.files)]
sample.names <- paste0(sub(".*variant_calling_process_sample_(.+)_realigned.*", "\\1", bam.files))
reference.file <- "~/generic/data/broad/human_g1k_v37.fasta"

target.df <- read.delim(target.file, header = FALSE)
target <- GRanges(seqname = target.df[, 1], IRanges(start = target.df[,2] + 1, end = target.df[, 3]))
counts <- RangedData(space = seqnames(target), ranges = ranges(target))

for (i in 1:length(bam.files)) {
	counts[[sample.names[i]]] <- countBamInGRanges(bam.files[i], target, read.width=100, remove.dup=FALSE)
}

names(counts@values@unlistData@listData) <- gsub("X", "", names(counts@values@unlistData@listData))
save(counts, file="~/p2ry8-crlf2/results/exomeCopy/counts.RData")

