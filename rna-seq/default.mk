.PHONY: all-default clean-default

all-default: gsnap htseq qc blast fastqc
clean-default: clean-htseq clean-qc clean-blast clean-fastqc

include ~/generic/scripts/rna-seq/gsnap.mk
include ~/generic/scripts/rna-seq/htseq.mk
include ~/generic/scripts/rna-seq/qc.mk
include ~/generic/scripts/rna-seq/blast.mk
include ~/generic/scripts/rna-seq/fastqc.mk
