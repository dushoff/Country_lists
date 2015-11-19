# Country_lists
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: pop.csv 

##################################################################


# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md todo.mkd
include stuff.mk

##################################################################

## Abbreviations

# Download an abbreviations file from the ISO, and mosh it into a .csv

iso.html:
	wget -O $@ "http://www.addressdoctor.com/en/countries-data/iso-country-codes.html"

Sources += iso.pl
iso.csv: iso.html iso.pl
	$(PUSH)

# Make a personal country file by editing iso.csv
Sources += abb.csv

# Replace countries in a data file with their abbreviations
Sources += abb.pl
%.abb.csv: %.csv abb.csv abb.pl
	$(PUSH)

# Replace countries in a data file with a "short name" (the first in abb.csv)
Sources += short.pl
short.csv: abb.csv short.pl
	$(PUSH)

%.short.csv: %.csv short.csv abb.pl
	$(PUSH)

pop.short.csv: abb.pl

######################################################################

### Download and scrape populations from Wikipedia (ugly)

Sources += pop.pl pop.supp.csv

pop.html:
	wget -O $@ "http://en.wikipedia.org/wiki/List_of_countries_by_population"

pop.auto.csv: pop.html pop.pl
	$(PUSH)

pop.csv: pop.auto.csv pop.supp.csv
	cat $^ > $@

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/perl.def
-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
