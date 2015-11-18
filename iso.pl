use 5.10.0;
use strict;

while(<>){
	last if /--------------------------------------------/;
}

while(<>){
	last if m|/pre|;
	s/\t/   /g;
	chomp;
	my ($three, $two, $txt) = split /   +/;
	$txt =~ s/,.*//;
	$txt =~ s/\s*\(.*//;
	print "$three, $txt\n";
}

