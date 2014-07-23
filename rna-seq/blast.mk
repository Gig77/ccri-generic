.PHONY: blast
blast: $(foreach S, $(SAMPLES), blast/$S.unmapped-reads.species-hits.tsv)

blast/%.unmapped-reads.species-hits.tsv: gsnap/%.gsnap.bam ~/tools/ncbi-blast-2.2.29+/db ~/tools/ncbi-blast-2.2.29+/bin/blastn
	-~/tools/samtools-0.1.19/samtools view -f 4 -s 22.01 $< \
		| head -200 \
		| awk '{OFS="\t"; print ">"$$1"\n"$$10}' - \
		| BLASTDB=~/tools/ncbi-blast-2.2.29+/db ~/tools/ncbi-blast-2.2.29+/bin/blastn -task megablast -db nt -query /dev/stdin -remote \
			-outfmt "7 qacc sacc length pident staxids sscinames scomnames sskingdoms" \
		| tee blast/$*.unmapped-reads.blast.out \
		| grep -vP "^#" \
		| cut -f 1,5,6,7,8 | sort | uniq \
		| cut -f 2,3,4,5 | sort | uniq -c \
		| sort -k 1,1nr > $@.part
	mv $@.part $@	
