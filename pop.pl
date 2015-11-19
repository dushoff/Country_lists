use strict;
use 5.10.0;

undef $/;

say "";

my $f = <>;

foreach (split /<tr>\s*/, $f){
	# Eliminates parts not in the main table
	next unless /flagicon/;

	my ($rr, $cr, $pr, @notes) = split /<td>/;

	my ($ctry) = $cr =~ /title="([^"]*)/; 
	$ctry =~ s/\s*\(.*//;
	$ctry =~ s/,//g;

	$pr =~ s/<.*//s;
	$pr =~ s/,//g;
	say "$ctry, $pr";
}

