library(exomeCopy)

target.file <- "/mnt/projects/generic/data/illumina/nexterarapidcapture_exome_targetedregions.nochr.bed"
bam.files <- list.files(path="/mnt/projects/p2ry8-crlf2/data/bam", pattern="*.bam$", full.names=T)
bam.files <- bam.files[!grepl("(abra|715C|715D|715C|715R_)", bam.files)]
sample.names <- paste0(sub(".*variant_calling_process_sample_(.+)_realigned.*", "\\1", bam.files))
reference.file <- "/mnt/projects/generic/data/broad/human_g1k_v37.fasta"

target.df <- read.delim(target.file, header = FALSE)
target <- GRanges(seqname = target.df[, 1], IRanges(start = target.df[,2] + 1, end = target.df[, 3]))
#target <- c(target, gaps(target))
#target <- target[order(target)]

# load counts
load("counts.RData")
#load("counts.withgaps.RData")
#counts <- counts.withgaps
#rm(counts.withgaps)

# only remission samples
sample.names.bg <- sample.names[grep("C$", sample.names)]

# exclude trisomy 21 cases; 242 is poor quality; exclude hyperdiploid 715,460,564,545 (different batch, used TruSeq not Nextera)
sample.names.bg <- sample.names.bg[!sample.names.bg %in% c("AL9890C", "GL11356C", "365C", "400C", "802C", "DS10898C", "GI13C", "HV57C", "HW11537C", "SE15285C", "VS14645C", "1089C", "360C", "506C", "887C", "957C", "961C", "DL2C", "N7C", "242C", "715C", "460C", "564C", "545C")]

# split by sex
sex <- read.delim("/mnt/projects/p2ry8-crlf2/results/patient_sex.tsv")
sample.names.bg.male <- sample.names.bg[sample.names.bg %in% paste0(sex$patient[sex$sex=="m"], "C")] 
sample.names.bg.female <- sample.names.bg[sample.names.bg %in% paste0(sex$patient[sex$sex=="f"], "C")] 

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
counts[["log.bg.var"]] <- log(counts[["bg.var"]] + 0.1)
counts[["bg.male"]] <- generateBackground(sample.names.bg.male, counts, median)
counts[["log.bg.male"]] <- log(counts[["bg.male"]] + 0.1)
counts[["bg.var.male"]] <- generateBackground(sample.names.bg.male, counts, var) 
counts[["log.bg.var.male"]] <- log(counts[["bg.var.male"]] + 0.1) 
counts[["bg.female"]] <- generateBackground(sample.names.bg.female, counts, median)
counts[["log.bg.female"]] <- log(counts[["bg.female"]] + 0.1)
counts[["bg.var.female"]] <- generateBackground(sample.names.bg.female, counts, var) 
counts[["log.bg.var.female"]] <- log(counts[["bg.var.female"]] + 0.1) 
counts[["width"]] <- width(counts)

#counts[["S360C"]][seqnames(counts)=="21"] <- counts.bkp[["S360C"]][seqnames(counts)=="21"]
#counts[["S365C"]][seqnames(counts)=="21"] <- counts.bkp[["S365C"]][seqnames(counts)=="21"]
#counts[["S400C"]][seqnames(counts)=="21"] <- counts.bkp[["S400C"]][seqnames(counts)=="21"]
#counts[["S506C"]][seqnames(counts)=="21"] <- counts.bkp[["S506C"]][seqnames(counts)=="21"]
#counts[["SGI13C"]][seqnames(counts)=="21"] <- counts.bkp[["SGI13C"]][seqnames(counts)=="21"]
#counts[["SHV57C"]][seqnames(counts)=="21"] <- counts.bkp[["SHV57C"]][seqnames(counts)=="21"]

names(counts@values@unlistData@listData) <- gsub("X", "", names(counts@values@unlistData@listData))
save(counts, file="counts.bg.RData")

