#!/usr/bin/awk -f

# usage: stdin | tee [files]

BEGIN {
 FS=OFS=""
 ARGV[ARGC] = "/dev/stdout"
 
 while (getline < "/dev/stdin")
  for (i=1;i<=ARGC;i++)
    print $0 > ARGV[i]

 exit 0
}
