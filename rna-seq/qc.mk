.PHONY: qc
qc: $(foreach S, $(SAMPLES), qc/$S.samtools.flagstat) \
    qc/allpatients.stats.txt \
    qc/allpatients.geneBodyCoverage.pdf \
    qc/allpatients.DupRate_plot.pdf \
    qc/allpatients.read-distribution.txt \
    qc/allpatients.splice_junction.pdf \
    qc/allpatients.splicing_events.pdf \
    qc/allpatients.infer_experiment.txt

qc/%.samtools.flagstat: gsnap/%.gsnap.bam
	samtools flagstat $< 2>&1 1>$@.part | $(LOG)
	mv $@.part $@

qc/allpatients.stats.txt: $(foreach S, $(SAMPLES), qc/$S.stats.txt)
	echo -e "sample\ttotal\tpass QC\tmapped\texonic\tnon-rRNA\tprotein\tprotein unique\tprotein unique de-duplicated\t" > $@.part
	cat $^ >> $@.part
	mv $@.part $@ 

qc/%.stats.txt: gsnap/%.gsnap.bam $(PROJECT_HOME)/data/bam/%.bam ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.all.exons.bed ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.all-minus-rRNA.exons.bed ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.protein_coding.exons.bed
	echo -ne $*"\t" > $@.part 
	echo -ne `samtools view -c $(PROJECT_HOME)/data/bam/$*.bam`"\t" >> $@.part  # total reads
	echo -ne `samtools view -c -F 512 $(PROJECT_HOME)/data/bam/$*.bam`"\t" >> $@.part  # pass filter (PF)
	echo -ne `samtools view -c -F 772 $<`"\t" >> $@.part # PF, mapped, only primary alignments
	echo -ne `samtools view -c -F 772 $< -L ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.all.exons.bed`"\t" >> $@.part # mapped exonic reads
	echo -ne `samtools view -c -F 772 $< -L ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.all-minus-rRNA.exons.bed`"\t" >> $@.part # mapped exonic non-rRNA reads
	echo -ne `samtools view -c -F 772 $< -L ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.protein_coding.exons.bed`"\t" >> $@.part # mapped exonic protein-coding reads
	echo -ne `samtools view -F 772 $< -L ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.protein_coding.exons.bed | grep "NH:i:1" | wc -l`"\t" >> $@.part # protein-coding, unique mapper
	echo -ne `samtools view -F 1796 $< -L ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.protein_coding.exons.bed | grep "NH:i:1" | wc -l`"\n" >> $@.part # protein-coding, unique mapper, non-duplicate
	mv $@.part $@ 

qc/allpatients.geneBodyCoverage.pdf: $(foreach S, $(SAMPLES), qc/$S.geneBodyCoverage.pdf)
	gs -dBATCH -dNOPAUSE -q -dAutoRotatePages=/None -sDEVICE=pdfwrite -sOutputFile=$@.part $^
	mv $@.part $@

qc/%.geneBodyCoverage.pdf: gsnap/%.gsnap.filtered.bam ~/generic/data/rseqc/hg19_Ensembl.bed
	~/tools/RSeQC-2.3.9/bin/geneBody_coverage.py -i $< -r ~/generic/data/rseqc/hg19_Ensembl.bed -o qc/$*.rseqc

qc/allpatients.DupRate_plot.pdf: $(foreach S, $(SAMPLES), qc/$S.DupRate_plot.pdf)
	gs -dBATCH -dNOPAUSE -q -dAutoRotatePages=/None -sDEVICE=pdfwrite -sOutputFile=$@.part $^
	mv $@.part $@

qc/%.DupRate_plot.pdf: gsnap/%.gsnap.filtered.bam
	~/tools/RSeQC-2.3.9/bin/read_duplication.py -i $< -o qc/$*.rseqc

qc/allpatients.read-distribution.txt: $(foreach S, $(SAMPLES), qc/$S.read-distribution.txt)
	rm -f $@.part
	for S in $^ ; do echo $$S >> $@.part; cat $$S >> $@.part ; done
	mv $@.part $@

qc/%.read-distribution.txt: gsnap/%.gsnap.filtered.bam ~/generic/data/rseqc/hg19_Ensembl.bed
	~/tools/RSeQC-2.3.9/bin/read_distribution.py -i $< -r ~/generic/data/rseqc/hg19_Ensembl.bed > $@.part
	mv $@.part $@

qc/allpatients.splice_junction.pdf: $(foreach S, $(SAMPLES), qc/$S.splice_junction.pdf)
	gs -dBATCH -dNOPAUSE -q -dAutoRotatePages=/None -sDEVICE=pdfwrite -sOutputFile=$@.part $^
	mv $@.part $@

qc/allpatients.splicing_events.pdf: $(foreach S, $(SAMPLES), qc/$S.splice_events.pdf)
	gs -dBATCH -dNOPAUSE -q -dAutoRotatePages=/None -sDEVICE=pdfwrite -sOutputFile=$@.part $^
	mv $@.part $@

qc/%.splice_events.pdf qc/%.splice_junction.pdf: gsnap/%.gsnap.filtered.bam ~/generic/data/rseqc/hg19_Ensembl.bed
	~/tools/RSeQC-2.3.9/bin/junction_annotation.py -i $< -r ~/generic/data/rseqc/hg19_Ensembl.bed -o qc/$*.rseqc

qc/allpatients.infer_experiment.txt: $(foreach S, $(SAMPLES), qc/$S.infer_experiment.txt)
	rm -f $@.part
	for S in $^ ; do echo $$S >> $@.part; cat $$S >> $@.part ; done
	mv $@.part $@

qc/%.infer_experiment.txt: gsnap/%.gsnap.filtered.bam ~/generic/data/rseqc/hg19_Ensembl.bed
	~/tools/RSeQC-2.3.9/bin/infer_experiment.py -i $< -r ~/generic/data/rseqc/hg19_Ensembl.bed > $@.part
	mv $@.part $@
	
