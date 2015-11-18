use strict;
use 5.10.0;

while(<>){
	next if /^\s*#/;
	next if /^\s*$/;
	chomp;
	my ($code, $short, @txt) = split /,\s*/;
	print "$short, ";
	say (join ", ", ($short, @txt));
}
