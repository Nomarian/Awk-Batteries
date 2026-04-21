#!/usr/bin/gawk -E

BEGIN {
 ARGC -= ARGC>1 # ARGC cannot be 1 or 0
 for (i=1;i<ARGC;i++) printf("%s ",ARGV[i])
 print ARGV[ARGC]
 exit 0
}
