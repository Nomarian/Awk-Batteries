#!/usr/bin/awk -f

{ a[NR]=$0 }

END {
 if (NR>10) {
	i=NR-9
  } else {
	i=1
 }

 for (;i<=NR;i++)
	print a[i]
}
