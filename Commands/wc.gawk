#!/usr/bin/awk -f

# NOTE: counts lines differently than gnu wc

BEGIN { OFS="\t" }

BEGINFILE { words=chars=0 }

{
 words += NF
 chars += length($0 RT)
}

ENDFILE {
 print " " FNR,words,chars,FILENAME
 tw+=words;tc+=chars
}

END {
 if (FNR!=NR)
  print " " NR,tw,tc,"total"
}
