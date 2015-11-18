# Country_lists
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: notarget

##################################################################


# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
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

######################################################################

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
