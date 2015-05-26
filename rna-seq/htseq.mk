.PHONY: htseq
htseq: $(foreach S, $(SAMPLES), htseq/$S.count)

htseq/%.count: gsnap/%.gsnap.filtered.bam /mnt/projects/chrisi/data/ensembl/Homo_sapiens.GRCh37.75.etv6runx1.no-rRNA.gtf.gz
	mkdir -p htseq
	~/tools/HTSeq-0.6.1/scripts/htseq-count -f bam -t exon -s no $< /mnt/projects/chrisi/data/ensembl/Homo_sapiens.GRCh37.75.etv6runx1.no-rRNA.moloney.gtf.gz  | grep -vP "^__" > $@.part
	mv $@.part $@

htseq/coverage-saturation-curve.pdf: $(foreach S, $(SAMPLES), htseq/$S.subsamples.count) /mnt/projects/generic/scripts/plot_saturation_curve.R
	Rscript /mnt/projects/generic/scripts/plot_saturation_curve.R --input-dir htseq --min-reads 3 --y-max 30000 --output $@.part
	mv $@.part $@ 

htseq/%.subsamples.count: gsnap/%.gsnap.filtered.bam /mnt/projects/chrisi/data/ensembl/Homo_sapiens.GRCh37.75.etv6runx1.no-rRNA.gtf.gz htseq/%.count
	~/tools/samtools-0.1.19/samtools view -s 22.1 $< | ~/tools/HTSeq-0.6.1/scripts/htseq-count -f sam -t exon -s no - /mnt/projects/chrisi/data/ensembl/Homo_sapiens.GRCh37.75.etv6runx1.no-rRNA.gtf.gz > $@.part ; \
	for FRACT in 2 3 4 5 6 7 8 9 ; do \
		~/tools/samtools-0.1.19/samtools view -s 22.$$FRACT $< | ~/tools/HTSeq-0.6.1/scripts/htseq-count -f sam -t exon -s no - /mnt/projects/chrisi/data/ensembl/Homo_sapiens.GRCh37.75.etv6runx1.no-rRNA.gtf.gz > $@.part2 ; \
		paste $@.part <(cut -f 2 $@.part2) > $@.part3 ; mv $@.part3 $@.part ; rm $@.part2 ; \
	done
	echo -e "gene\t10%\t20%\t30%\t40%\t50%\t60%\t70%\t80%\t90%\t100%" | cat - <(paste $@.part <(cut -f 2 htseq/$*.count)) > $@
	rm $@.part

.PHONY: clean-htseq
clean-htseq:
	rm htseq/*
	rmdir htseq