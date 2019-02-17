#!/usr/bin/awk -f

{a[NR]=$0}

END {
 asort(a)
 for (i=1;i<=NR;i++)
  print a[i]
}
