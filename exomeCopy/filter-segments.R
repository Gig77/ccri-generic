s <- read.delim("/mnt/projects/p2ry8-crlf2/results/exomeCopy/allpatients.compiled-segments.exomeCopy.tsv")
sf <- s
sf <- sf[sf$copy.count != 2,]
sf <- sf[!grepl("C", sf$overlap.samples),]

high.score <- sf$log.odds >= 50
conserved <- apply(sf, 1, function(x) { !is.na(x["overlap.samples"]) & grepl(sub("(C|D|R\\d?)", "", x["sample.name"], perl=T), x["overlap.samples"]) })
recurrent <- !is.na(sf$overlap.count.tumor) & sf$overlap.count.tumor >= 3

sf <- sf[high.score | (sf$nranges >= 2 & (conserved | recurrent)),]

write.table(sf, "/mnt/projects/p2ry8-crlf2/results/exomeCopy/allpatients.filtered-segments.exomeCopy.tsv.part", row.names=F, col.names=T, sep="\t", quote=F)