.PHONY: gsnap
gsnap: $(foreach S, $(SAMPLES), gsnap/$S.gsnap.bam)

gsnap/%.gsnap.bam: $(PROJECT_HOME)/data/bam/%.bam
	~/tools/gmap-2014-05-15/src/gsnap \
			--db=g1k_v37_etv6runx1 \
			--dir=/data/christian/chrisi/data/current/gsnap/g1k_v37_etv6runx1 \
			--format=sam \
			--npaths=1000 \
			--quiet-if-excessive \
			--batch=4  \
			--quality-protocol=sanger \
			--print-snps \
			--nthreads=20 \
			--input-buffer-size=5000 \
			--use-splicing=g1k_v37.splicesites \
			--use-snps=g1k_v37.snp138 \
			--genome-unk-mismatch=0 \
			<(java -jar ~/tools/picard-tools-1.114/SamToFastq.jar INPUT=$< FASTQ=/dev/stdout) \
		| ~/tools/samtools-0.1.19/samtools view -Shb - \
		| ~/tools/samtools-0.1.19/samtools sort -m 1000000000 - $@ \
		2>&1 | $(LOG)

	java -Xmx2g -Djava.io.tmpdir=/data/tmp -jar ~/tools/picard-tools-1.114/MarkDuplicates.jar \
		INPUT=$@.bam \
		OUTPUT=$@.part \
		METRICS_FILE=picard/$*.mark_duplicates_metrics \
		VALIDATION_STRINGENCY=LENIENT \
		2>&1 | $(LOG)
		
	mv $@.part $@
	rm $@.bam
	~/tools/samtools-0.1.19/samtools index $@ 2>&1 | $(LOG)

gsnap/%.gsnap.filtered.bam: gsnap/%.gsnap.bam
	samtools view -h -F 772 $< | grep -P "(^@|NH:i:1)" | samtools view -Shb - > $@.part # PF, mapped, primary, unique; keep pcr duplicates
	mv $@.part $@
	~/tools/samtools-0.1.19/samtools index $@
