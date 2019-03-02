#!/usr/bin/awk -f

# Good for Simple/, but reestructuring the loops would yield faster results

BEGIN {
 usage="usage: tee [files]"

 if (ARGV[1] == "-a" ) append++

 files[++nfiles] = "/dev/stdout"
 for (i=append ? 2 : 1;i<=ARGC-1;i++)
  files[++nfiles]=ARGV[i]
 
 FS=OFS=""

 while (getline < "/dev/stdin") {
  for (i=1;i<=nfiles;i++)
   if (append) {
    print $0 >> files[i]
   } else {
    print $0 > files[i]
   }
 }
 exit 0
}
