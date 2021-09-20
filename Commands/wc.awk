#!/usr/bin/awk -f

BEGIN { OFS="\t" }

!lfn { lfn=FILENAME;lnr++}

lfn != FILENAME { # mimics BEGINFILE
 print " " NR-lnr,words,chars,lfn
 lnr=NR # NR-lnr gives the last FNR
 tw+=words;tc+=chars # total
 words=chars=0 # reset
 lfn=FILENAME # lfn = last filename
}

{
 words += NF
 chars += length($0 ORS) # bug last line is counted
 # no way to know if the last line has a character
}

# cannot mimic ENDFILE

END {
 print " " FNR,words,chars,FILENAME
 print " " NR,tw+words,tc+chars,"total"
}
