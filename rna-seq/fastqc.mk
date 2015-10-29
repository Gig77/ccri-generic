.PHONY: fastqc


fastqc: $(foreach S, $(SAMPLES), fastqc/$S_fastqc.html)
	
fastqc/%_fastqc.html: $(PROJECT_HOME)/data/bam/%.bam
	mkdir -p fastqc/$*.part
	/data_synology/software/FastQC-0.11.2/fastqc -o fastqc/$*.part -f bam $^
	mv fastqc/$*.part/* fastqc
	rmdir fastqc/$*.part
	
.PHONY: clean-fastqc
clean-fastqc:
	rm fastqc/*
	rmdir fastqc