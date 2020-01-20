#!/usr/bin/awk -f

BEGIN {
 RS="\n\n"
}

# This is a maybe? or maybe a getline in BEGIN?
#!ib {if (NF) { ib-- } else {next } }

{
 # first line is the counter
 # second line is the time
 # the rest is text
 fulltext = "" # gotta overwrite for each item
 anf = split($0,a,"\n")
 counter = a[1]
 fulltime = a[2]
 for (i=3;i<=anf;i++) { fulltext = fulltext a[i] "\n" }
 delete a
}

{
 printf("%s\n%s\n%s\n",counter,fulltime,fulltext)
}
