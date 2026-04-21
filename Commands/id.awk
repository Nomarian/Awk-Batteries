#!/usr/bin/awk -f

BEGIN {
 FS=":"
 user = ENVIRON["USER"]
 while (getline < "/etc/passwd")
  if ($1 == ENVIRON["USER"]) {
   uid=$3;gid=$4
   printf("uid=%i(%s) gid=%i(%s) groups=%i(%s)",uid,user,gid,user,gid,user)
   break
  }
 ARGV[ARGC++]="/etc/group"
}

{
 split($NF,a,/,/)
 for (i in a)
  if (a[i] == user)
	printf(",%i(%s)",$3,$1) 
}


END {print ""}
