#!/usr/bin/awk -f

# usage: tee [files]

BEGIN {

 if (ARGV[1] == "-a" ) append++

 files[++nfiles] = "/dev/stdout"
 for (i=append ? 2 : 1;i<=ARGC-1;i++)
  files[++nfiles]=ARGV[i]
 
 FS=OFS=""

 if (append) {
  while (getline < "/dev/stdin") {
   for (i=1;i<=nfiles;i++)
    print $0 >> files[i]
  }
 } else {
  while (getline < "/dev/stdin") {
   for (i=1;i<=nfiles;i++)
    print $0 > files[i]
  }
 }
 exit 0
}
