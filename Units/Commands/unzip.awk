
# handy unit for unzip -l

function trimspaces(){ sub(/[ \t]+/,"") }

{filetype=column=archive=size=date=time=filename="";s=$0}

/^Archive:/ { column="Archive"
 $1="";trimspaces(); archive=$0
 $0=s
}

$1 == "Length" { column="header" }

$1 == "---------" { column= "divider"; divides++ }

$1 ~ /[0-9]+/ && NF>2 { column="file"
 size=$1;$1=""
 date=$2;$2=""
 time=$3;$3=""
 trimspaces()
 filename=$0
 if ( filename ~ "/$" ) { filetype = "directory" } else { filetype = "file" }
 $0=s
}

# This should be on END?
$1 ~ /[0-9]+/ && NF==3 { column="total";totalsize=$1;totalfiles=$2 }
