use strict;
use 5.10.0;

my ($vname, $aname) = @ARGV;

my %map;
my %codes;

open (A, $aname);
while(<A>){
	next if /^\s*#/;
	next if /^\s*$/;
	chomp;

	my ($code, @txt) = split /,\s*/;

	die "Repeated code $code"
		if defined $codes{$code};
	$codes{$code} = 1;

	foreach my $txt (@txt){
		$txt =~ y/A-Z/a-z/;
		$txt =~ s/'//;
		die "Repeated key $txt"
			if defined $map{$txt};
		$map{$txt} = $code;
	}
}

my %vcodes;
my $missing=0;
my $ambiguous=0;

open (V, $vname);
while(<V>){
	chomp;
	my ($txt, @vals) = split /,\s*/;
	next unless $txt;
	$txt =~ s/^\s*//;
	my $match = $txt;
	$match =~ y/A-Z/a-z/;
	$match =~ s/'//;

	# We want to allow two records for the same country; but not two names (to screen for ambiguities in coding)
	my $code;
	if (!defined ($code=$map{$match})){
		say STDERR "Did not match $txt";
		$missing++;
	} elsif (defined $vcodes{$code} and $vcodes{$code} ne $txt){
		print STDERR
			"Repeated code $code matches $vcodes{$code} and $txt";
		$ambiguous++;
	}

	$vcodes{$code} = $txt;
	print "$code, ";
	say join ", ", @vals;
}
die "$missing missing and $ambiguous ambiguous" if $missing || $ambiguous;
