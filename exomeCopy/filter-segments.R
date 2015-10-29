s <- read.delim("/mnt/projects/p2ry8-crlf2/results/exomeCopy/allpatients.compiled-segments.exomeCopy.tsv")

sf <- s
sf <- sf[sf$copy.count != 2,] # exclude normal state (i.e. copy number 2)
sf <- sf[!grepl("C", sf$overlap.samples),] # must not overlap with CNV in remission sample
sf <- sf[!grepl("^m", sf$sample.name) | grepl("(D|R\\d)[,$]", sf$overlap.samples),] # CNV of xenograft sample must overlap with at least one CNV of a primary (i.e. non-xenograft) sample

high.score <- sf$log.odds >= 50
conserved <- apply(sf, 1, function(x) { !is.na(x["overlap.samples"]) & grepl(sub("(C|D|R\\d?)", "", x["sample.name"], perl=T), x["overlap.samples"]) })
recurrent <- !is.na(sf$overlap.count.tumor) & sf$overlap.count.tumor >= 3

sf <- sf[high.score | (sf$nranges >= 2 & (conserved | recurrent)),]

write.table(sf, "/mnt/projects/p2ry8-crlf2/results/exomeCopy/allpatients.filtered-segments.exomeCopy.tsv.part", row.names=F, col.names=T, sep="\t", quote=F)