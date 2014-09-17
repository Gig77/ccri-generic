options(warn=1)
library(GenomicRanges)
library(reshape)

files <- list.files(path="~/p2ry8-crlf2/results/exomeCopy", pattern="*.compiled-segments.tsv$", full.names=T)

d <- read.delim(files[1], stringsAsFactor=F)
for (i in 2:length(files)) {
	d <- rbind(d, read.delim(files[i], stringsAsFactor=F))
}
d <- d[!d$sample.name %in% c("242C", "GI8R", "MA5R"),] # ignore crappy sample 242

gr <- GRanges(seqnames=d$space, ranges=IRanges(start=d$start, end=d$end), sample.name=d$sample.name, copy.count=d$copy.count, log.odds=d$log.odds, nranges=d$nranges, targeted.bp=d$targeted.bp, genes=d$genes)

# find overlaps
o <- findOverlaps(gr, gr)
o <- o[o@queryHits != o@subjectHits]
o <- o[gr$copy.count[o@queryHits] != 2 & gr$copy.count[o@subjectHits] != 2]

# ignore overlaps with large segments in normal samples due to constitutional trisomy 21 
const.tri21 <- which(seqnames(gr)=="21" & grepl("C$", gr$sample.name, perl=T) & gr$copy.count > 2 & gr@ranges@width >= 1000000)
o <- o[!(o@queryHits %in% const.tri21) & !(o@subjectHits %in% const.tri21)]

# determine overlap in percent of shared exons
ex <- read.delim("~/generic/data/illumina/nexterarapidcapture_exome_targetedregions.nochr.bed", header=F)
er <- GRanges(seqnames=ex$V1, ranges=IRanges(start=ex$V2, end=ex$V3))
oex <- findOverlaps(gr, er)
segex <- cast(as.data.frame(oex), formula=queryHits~., value="subjectHits", fun.aggregate=function(x) { paste(x, collapse=",") })
names(segex) <- c("subjectHits", "subjectExons")
om <- merge(as.data.frame(o), segex)
names(segex) <- c("queryHits", "queryExons")
om <- merge(om, segex)
om <- om[order(om$queryHits, om$subjectHits),]
o@metadata[["pct_shared_exons"]] <- apply(om, 1, function(x) { qex <- unlist(strsplit(x["queryExons"], ",", fixed=T)) ; sex <- unlist(strsplit(x["subjectExons"], ",", fixed=T)) ; length(intersect(qex, sex)) / length(union(qex, sex)) })
o <- o[o@metadata[["pct_shared_exons"]] >= 0.3]

# to be considered same event, we require overlap of at least 30% (intersection divided by union)
#qr <- gr[o@queryHits]@ranges
#sr <- gr[o@subjectHits]@ranges
#o@metadata[["width"]] <- (pmin(end(qr), end(sr))-pmax(start(qr), start(sr))+1) / (pmax(end(qr), end(sr))-pmin(start(qr), start(sr))+1)
#o@metadata[["pct_shared_exons"]] <- (pmin(end(qr), end(sr))-pmax(start(qr), start(sr))+1) / (pmax(end(qr), end(sr))-pmin(start(qr), start(sr))+1)
#o <- o[o@metadata[["width"]] >= 0.3]

gr$overlap.samples <- as.character(NA)
gr$overlap.count <- as.integer(NA)
gr$overlap.count.tumor <- as.integer(NA)
library(plyr)
o.aggregated <- ddply(as.data.frame(o), .(queryHits), function(x) { 
			c(overlap.samples=paste(unique(gr$sample.name[x$subjectHits]), collapse=","), 
			  overlap.count=length(unique(gr$sample.name[x$subjectHits])),
			  overlap.count.tumor=sum(!grepl("C$", unique(gr$sample.name[x$subjectHits])))) 
  })
gr$overlap.samples[o.aggregated$queryHits] <- o.aggregated$overlap.samples
gr$overlap.count[o.aggregated$queryHits] <- o.aggregated$overlap.count
gr$overlap.count.tumor[o.aggregated$queryHits] <- o.aggregated$overlap.count.tumor

# write table
write.table(as.data.frame(gr), file="~/p2ry8-crlf2/results/exomeCopy/allpatients.compiled-segments.exomeCopy.tsv.part", quote=FALSE, sep="\t", row.names=FALSE, col.names=TRUE)

