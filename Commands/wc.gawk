#!/usr/bin/awk -f

BEGIN { OFS="\t" }

{
 words += NF
 chars += length($0 ORS)
}

ENDFILE { print " " NR,words,chars,FILENAME }
