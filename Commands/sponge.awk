#!/usr/bin/awk -f 

BEGIN {
 usage="usage: sponge [file]"
 if (ARGC > 2)	{ print usage; exit 1 }

 if (ARGC == 1) {
  file="/dev/stdout"
 } else {
  file=ARGV[1]
 }

 FS=RS=OFS=ORS=""

 getline < "/dev/stdin"
 print $0 > file
 exit 0
}
