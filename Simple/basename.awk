#!/usr/bin/awk -f

BEGIN {
 if (ARGC==1) exit 1

 name=ARGV[1]
 gsub(/^\/|[^/]+\//,"",name)
 if (ARGC==3) {
  suffix = index(name,ARGV[2]) - 1
  name = substr(name,1,suffix)
 }

 print name
 exit 0
}
