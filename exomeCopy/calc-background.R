library(exomeCopy)

target.file <- "~/generic/data/illumina/nexterarapidcapture_exome_targetedregions.nochr.bed"
bam.files <- list.files(path="~/p2ry8-crlf2/data/bam", pattern="*.bam$", full.names=T)
bam.files <- bam.files[!grepl("(abra|715)", bam.files)]
sample.names <- paste0("S", sub(".*/bam/(.+).duplicate.*", "\\1", bam.files))
reference.file <- "~/generic/data/broad/human_g1k_v37.fasta"

target.df <- read.delim(target.file, header = FALSE)
target <- GRanges(seqname = target.df[, 1], IRanges(start = target.df[,2] + 1, end = target.df[, 3]))

# load counts
load("counts.p2ry8.RData")

sample.names.bg <- sample.names[grep("C$", sample.names)]
sample.names.bg <- sample.names.bg[!sample.names.bg %in% c("S360C", "S365C", "S400C", "S506C", "SGI13C", "SHV57C")] # exclude trisomy 21 cases from background

# correct for trisomy 21 in some normals before generating background
#counts.bkp <- counts

#counts[["S360C"]][seqnames(counts)=="21"] <- round(counts[["S360C"]][seqnames(counts)=="21"] / 3 * 2)
#counts[["S365C"]][seqnames(counts)=="21"] <- round(counts[["S365C"]][seqnames(counts)=="21"] / 3 * 2)
#counts[["S400C"]][seqnames(counts)=="21"] <- round(counts[["S400C"]][seqnames(counts)=="21"] / 3 * 2)
#counts[["S506C"]][seqnames(counts)=="21"] <- round(counts[["S506C"]][seqnames(counts)=="21"] / 3 * 2)
#counts[["SGI13C"]][seqnames(counts)=="21"] <- round(counts[["SGI13C"]][seqnames(counts)=="21"] / 3 * 2)
#counts[["SHV57C"]][seqnames(counts)=="21"] <- round(counts[["SHV57C"]][seqnames(counts)=="21"] / 3 * 2)

counts[["GC"]] <- getGCcontent(target, reference.file)
counts[["GC.sq"]] <- counts$GC^2
counts[["bg"]] <- generateBackground(sample.names.bg, counts, median)
counts[["log.bg"]] <- log(counts[["bg"]] + 0.1)
counts[["bg.var"]] <- generateBackground(sample.names.bg, counts, var) 
counts[["width"]] <- width(counts)

#counts[["S360C"]][seqnames(counts)=="21"] <- counts.bkp[["S360C"]][seqnames(counts)=="21"]
#counts[["S365C"]][seqnames(counts)=="21"] <- counts.bkp[["S365C"]][seqnames(counts)=="21"]
#counts[["S400C"]][seqnames(counts)=="21"] <- counts.bkp[["S400C"]][seqnames(counts)=="21"]
#counts[["S506C"]][seqnames(counts)=="21"] <- counts.bkp[["S506C"]][seqnames(counts)=="21"]
#counts[["SGI13C"]][seqnames(counts)=="21"] <- counts.bkp[["SGI13C"]][seqnames(counts)=="21"]
#counts[["SHV57C"]][seqnames(counts)=="21"] <- counts.bkp[["SHV57C"]][seqnames(counts)=="21"]

# remove outliers; gives more robust parameter optimization results
counts <- counts[counts[["bg.var"]]>quantile(counts[["bg.var"]], 0.01) & counts[["bg.var"]]<quantile(counts[["bg.var"]], 0.99),]

save(counts, file="counts.bg.p2ry8.RData")

