#!/usr/bin/awk -f

{ a[NR]=$0 }

END {
 for (i = NR > 10 ? NR-9 : 1;i<=NR;i++)
	print a[i]
}
