#!/usr/bin/awk -f

BEGIN {
 for (i in ENVIRON)
  printf("%s=%s\n",i,ENVIRON[i])
 exit 0
}
