.PHONY: qc
qc: $(foreach S, $(SAMPLES), qc/$S.samtools.flagstat) \
    qc/allpatients.stats.pdf \
    qc/allpatients.geneBodyCoverage.pdf \
    qc/allpatients.read-distribution.txt \
    qc/allpatients.splice_junction.pdf \
    qc/allpatients.splicing_events.pdf \
    qc/allpatients.infer_experiment.txt \
    qc/allpatients.read-quality.pdf \
    qc/allpatients.read-NVC.pdf

PYTHONPATH=/home/STANNANET/christian.frech/tools/RSeQC-2.3.9/lib/python2.7/site-packages

# ---

qc/%.samtools.flagstat: gsnap/%.gsnap.bam
	samtools flagstat $< 2>&1 1>$@.part | $(LOG)
	mv $@.part $@

# ---

# how to generate BED files from Ensembl GTF
# zcat ~/chrisi/data/ensembl/Homo_sapiens.GRCh37.75.etv6runx1.gtf.gz | perl -ne 'print "$1\t$2\t$3\t$4\n" if (/^(.*?)\t.*?\texon\t(.*?)\t(.*?)\t.*gene_name \"(.*?)\"/)' > ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.all.exons.bed
# zcat ~/chrisi/data/ensembl/Homo_sapiens.GRCh37.75.etv6runx1.gtf.gz | perl -ne 'print "$1\t$2\t$3\t$4\n" if (/^(.*?)\trRNA\texon\t(.*?)\t(.*?)\t.*gene_name \"(.*?)\"/)' > ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.rRNA.exons.bed
# zcat ~/chrisi/data/ensembl/Homo_sapiens.GRCh37.75.etv6runx1.gtf.gz | perl -ne 'print "$1\t$2\t$3\t$4\n" if (/^(.*?)\tlincRNA\texon\t(.*?)\t(.*?)\t.*gene_name \"(.*?)\"/)' > ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.lincRNA.exons.bed
# zcat ~/chrisi/data/ensembl/Homo_sapiens.GRCh37.75.etv6runx1.gtf.gz | perl -ne 'print "$1\t$2\t$3\t$4\n" if (/^(.*?)\tmiRNA\texon\t(.*?)\t(.*?)\t.*gene_name \"(.*?)\"/)' > ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.miRNA.exons.bed
# zcat ~/chrisi/data/ensembl/Homo_sapiens.GRCh37.75.etv6runx1.gtf.gz | perl -ne 'print "$1\t$3\t$4\t$5\n" if (/^(.*?)\t(Mt_rRNA|Mt_tRNA)\texon\t(.*?)\t(.*?)\t.*gene_name \"(.*?)\"/)' > ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.mtRNA.exons.bed
# zcat ~/chrisi/data/ensembl/Homo_sapiens.GRCh37.75.etv6runx1.gtf.gz | perl -ne 'print "$1\t$3\t$4\t$5\n" if (/^(.*?)\t(misc_RNA|snoRNA|snRNA)\texon\t(.*?)\t(.*?)\t.*gene_name \"(.*?)\"/)' > ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.miscRNA.exons.bed
# zcat ~/chrisi/data/ensembl/Homo_sapiens.GRCh37.75.etv6runx1.gtf.gz | perl -ne 'print "$1\t$3\t$4\t$5\n" if (/^(.*?)\t(nonsense_mediated_decay|non_stop_decay|polymorphic_pseudogene|processed_pseudogene|pseudogene|transcribed_processed_pseudogene|transcribed_unprocessed_pseudogene|translated_processed_pseudogene|unitary_pseudogene|unprocessed_pseudogene)\texon\t(.*?)\t(.*?)\t.*gene_name \"(.*?)\"/)' > ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.pseudogene.exons.bed
# zcat ~/chrisi/data/ensembl/Homo_sapiens.GRCh37.75.etv6runx1.gtf.gz | perl -ne 'print "$1\t$3\t$4\t$5\n" if (/^(.*?)\t(protein_coding)\texon\t(.*?)\t(.*?)\t.*gene_name \"(.*?)\"/)' > ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.protein_coding.exons.bed
# ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.other.exons.bed was created by subtracting the above features from ~/generic/data/ensembl/Homo_sapiens.GRCh37.75.all.exons.bed using '~/tools/bedtools-2.17.0/bin/subtractBed -A'

qc/allpatients.stats.pdf: qc/allpatients.stats.txt ~/generic/scripts/plot_read_stats.R
	Rscript ~/generic/scripts/plot_read_stats.R --input $< --output $@.part --y-max=40
	mv $@.part $@ 

qc/allpatients.stats.txt: $(foreach S, $(SAMPLES), qc/$S.stats.txt)
	echo -e "sample\ttotal\tpass QC\tmapped\texonic\tnon-rRNA\tprotein\tuniquely mapped\tnon-duplicates" > $@.part
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

# ---

qc/allpatients.geneBodyCoverage.pdf: $(foreach S, $(SAMPLES), qc/$S.geneBodyCoverage.pdf)
	gs -dBATCH -dNOPAUSE -q -dAutoRotatePages=/None -sDEVICE=pdfwrite -sOutputFile=$@.part $^
	mv $@.part $@

qc/%.geneBodyCoverage.pdf: gsnap/%.gsnap.filtered.bam ~/generic/data/rseqc/hg19_Ensembl.bed
	PYTHONPATH=$(PYTHONPATH) flock -x .lock ~/tools/RSeQC-2.3.9/bin/geneBody_coverage.py -i $< -r ~/generic/data/rseqc/hg19_Ensembl.bed -o qc/$*

# ---

qc/allpatients.DupRate_plot.pdf: $(foreach S, $(SAMPLES), qc/$S.DupRate_plot.pdf)
	gs -dBATCH -dNOPAUSE -q -dAutoRotatePages=/None -sDEVICE=pdfwrite -sOutputFile=$@.part $^
	mv $@.part $@

qc/%.DupRate_plot.pdf: gsnap/%.gsnap.filtered.bam
	PYTHONPATH=$(PYTHONPATH) flock -x .lock ~/tools/RSeQC-2.3.9/bin/read_duplication.py -i $< -o qc/$*

# ---

qc/allpatients.read-distribution.txt: $(foreach S, $(SAMPLES), qc/$S.read-distribution.txt)
	rm -f $@.part
	for S in $^ ; do echo $$S >> $@.part; cat $$S >> $@.part ; done
	mv $@.part $@

qc/%.read-distribution.txt: gsnap/%.gsnap.filtered.bam ~/generic/data/rseqc/hg19_Ensembl.bed
	PYTHONPATH=$(PYTHONPATH) flock -x .lock ~/tools/RSeQC-2.3.9/bin/read_distribution.py -i $< -r ~/generic/data/rseqc/hg19_Ensembl.bed > $@.part
	mv $@.part $@

# ---

qc/allpatients.read-quality.pdf: $(foreach S, $(SAMPLES), qc/$S.read-quality.pdf)
	gs -dBATCH -dNOPAUSE -q -dAutoRotatePages=/None -sDEVICE=pdfwrite -sOutputFile=$@.part $^
	mv $@.part $@

qc/%.read-quality.pdf: gsnap/%.gsnap.bam 
	samtools view -hbF 256 $< | PYTHONPATH=$(PYTHONPATH) ~/tools/RSeQC-2.3.9/bin/read_quality.py -i /dev/stdin -o qc/$*
	mv qc/$*.qual.boxplot.pdf $@

# ---

qc/allpatients.read-NVC.pdf: $(foreach S, $(SAMPLES), qc/$S.read-NVC.pdf)
	gs -dBATCH -dNOPAUSE -q -dAutoRotatePages=/None -sDEVICE=pdfwrite -sOutputFile=$@.part $^
	mv $@.part $@

qc/%.read-NVC.pdf: gsnap/%.gsnap.bam 
	samtools view -hbF 256 $< | PYTHONPATH=$(PYTHONPATH) ~/tools/RSeQC-2.3.9/bin/read_NVC.py -x -i /dev/stdin -o qc/$* -s $*
	mv qc/$*.NVC_plot.pdf $@

# ---

qc/allpatients.splice_junction.pdf: $(foreach S, $(SAMPLES), qc/$S.splice_junction.pdf)
	gs -dBATCH -dNOPAUSE -q -dAutoRotatePages=/None -sDEVICE=pdfwrite -sOutputFile=$@.part $^
	mv $@.part $@

qc/allpatients.splicing_events.pdf: $(foreach S, $(SAMPLES), qc/$S.splice_events.pdf)
	gs -dBATCH -dNOPAUSE -q -dAutoRotatePages=/None -sDEVICE=pdfwrite -sOutputFile=$@.part $^
	mv $@.part $@

qc/%.splice_events.pdf qc/%.splice_junction.pdf: gsnap/%.gsnap.filtered.bam ~/generic/data/rseqc/hg19_Ensembl.bed
	PYTHONPATH=$(PYTHONPATH) ~/tools/RSeQC-2.3.9/bin/junction_annotation.py -i $< -r ~/generic/data/rseqc/hg19_Ensembl.bed -o qc/$*

# ---

qc/allpatients.infer_experiment.txt: $(foreach S, $(SAMPLES), qc/$S.infer_experiment.txt)
	rm -f $@.part
	for S in $^ ; do echo $$S >> $@.part; cat $$S >> $@.part ; done
	mv $@.part $@

qc/%.infer_experiment.txt: gsnap/%.gsnap.filtered.bam ~/generic/data/rseqc/hg19_Ensembl.bed
	PYTHONPATH=$(PYTHONPATH) ~/tools/RSeQC-2.3.9/bin/infer_experiment.py -i $< -r ~/generic/data/rseqc/hg19_Ensembl.bed > $@.part
	mv $@.part $@

