library(exomeCopy)

target.file <- "~/generic/data/illumina/truseq_exome_targeted_regions.hg19.bed.chr"
#bam.files <- list.files(path="~/hdall/data/bam", pattern=".bam$", full.names=T)
bam.files <- list.files(path="~/hdall/data/bam", pattern=".*(314|399|430|446|460|545|564|592|715|786|792|818|X|Y).*.bam$", full.names=T)
sample.names <- paste0("S", sub(".*/bam/(.+).merged.*", "\\1", bam.files))
reference.file <- "~/generic/data/hg19/ucsc.hg19.fasta"

target.df <- read.delim(target.file, header = FALSE)
target <- GRanges(seqname = target.df[, 1], IRanges(start = target.df[,2] + 1, end = target.df[, 3]))
counts <- RangedData(space = seqnames(target), ranges = ranges(target))

for (i in 1:length(bam.files)) {
	counts[[sample.names[i]]] <- countBamInGRanges(bam.files[i], target)
}
save(counts, file="~/exomeCopy/counts.hdall.RData")

#----

#load("~/exomeCopy/counts.hdall.RData", verbose=T)

counts[["GC"]] <- getGCcontent(target, reference.file)
counts[["GC.sq"]] <- counts$GC^2
counts[["bg"]] <- generateBackground(sample.names[grep("rem", sample.names)], counts, median)
counts <- counts[counts[["bg"]] > 0,] # remove regions with zero coverage in normal

counts[["log.bg"]] <- log(counts[["bg"]] + 0.1)
counts[["width"]] <- width(counts)

fit.list <- lapply(c("S715_dia"), function(sample.name) {
	lapply(seqlevels(target), function(seq.name) {
		exomeCopy(counts[seq.name], sample.name, X.names = c("log.bg", "GC", "GC.sq", "width"), S = 0:4, d = 2)
	})
})

compiled.segments <- compileCopyCountSegments(fit.list)
write.table(compiled.segments, file="~/exomeCopy/compiled.segments.tsv", quote=FALSE, sep="\t", row.names=FALSE, col.names=TRUE)
