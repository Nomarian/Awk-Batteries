
# GRON:
# $1 is the var and $2 is = $3 is value

# gron.awk:
# $n is jsonkeys and json values
# jk[] for keys
# jkl contains the length of jk
# TODO jkv jkvl

# TODO
# split jsonvalues (for arrays)
# only string has been tested

BEGIN {
 types["\""] = "text"
 types["{"] = "tree"
 types["["] = "array"
}


{ s=$0
 # jk=json keys;jkl=length
 jkl = split($1,jsonkeys,".")
 jsonkeyslength=jkl
 var = $1
 $1=$2=""

 type = types[substr($0,3,1)]
 type = type ? type : "idk"

 sub(/^ +["{[]/,""); sub(/["}\]];$/,"")
 val = $0

 if (ENVIRON["KEEPSTATE"]) JSON[var] = val
 
 # $n is jsonkeys followed by val
 # TODO if val is array, append to $fields
 for (NF=1;++NF<=jkl;)
  $NF = jsonkeys[NF]
 $(++NF)=val
}

# Examples
# $(jkl) == "href" { some action }
