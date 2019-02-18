#!/usr/bin/awk -f

{ a[NR]=$0 }

END {
 for ( NR>10 ? i=NR-9 : i=1 ;i<=NR;i++)
	print a[i]
}
