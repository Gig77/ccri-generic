use warnings FATAL => qw( all );
use strict;

use Getopt::Long;
use Vcf;

my ($sample_identifier, $vcf_in);
GetOptions
(
	"sample=s" => \$sample_identifier, # will be first column of output
	"vcf-in=s" => \$vcf_in  # VCF input file name
);
die "ERROR: --sample not specified" if (!$sample_identifier);
die "ERROR: --vcf-in not specified" if (!$vcf_in);

print STDERR "Processing file $vcf_in...\n";
my $vcf = Vcf->new(file => "$vcf_in");
$vcf->parse_header();
my (@samples) = $vcf->get_samples();

my $vcf_sample_id = "Sample1";
die "ERROR: Sample name $vcf_sample_id not found in file $vcf_in\n" if ($vcf_sample_id ne $samples[0]);

while (my $vcfline = $vcf->next_line())
{
	my $v = $vcf->next_data_hash($vcfline);
	
	my $ad_ref = $v->{gtypes}{$vcf_sample_id}{RD};
	my $ad_alt = $v->{gtypes}{$vcf_sample_id}{AD};
	
	print join("\t", ($sample_identifier, $v->{CHROM}, $v->{POS}, $v->{REF}, $v->{ALT}->[0], $ad_ref+$ad_alt, $ad_alt)), "\n";
}