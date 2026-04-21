#!/usr/bin/awk -f

# 7z l -slt -ba file | awk

BEGIN { RS="\n\n";FS="\n"}

{
	length = split($0,a,/ = ?|\n/) # Super simple
	for (i=1;i<NF;i++){
		l = index($i, " =")
		a[substr($i, 1, l-1)] = substr($i, l+3)
	}
}

# you just do a["Path"]=="thisfile"
