#!/usr/bin/awk -f

BEGIN {
 if (ARGC != 3) {print "Wrong Args\ngrep.awk pattern file";exit 1}
 REGEX=ARGV[1]
 FILE=ARGV[ARGC-1]

 while(getline < FILE){
	if ($0 ~ REGEX) print $0
 } 
}

