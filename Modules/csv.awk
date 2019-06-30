
# ---------- csv.awk

function qcheck(s){ # true if quote has not been terminated
 return s ~ /"/ && s !~ /^([^"]|"[^"]*")*$/
}


function csvsplit(string,array,	i){ # Will split string into array
# returns Number of fields or -1 if failure

# Will return -1 if it finds an unterminated string "" 
 if ( string ~ /"/ && string !~ /^([^"]|"[^"]*")*$/ ) return -1

 if ( string ~ /^("[^",]*"|[^"]*)*("[^"]*,[^"]*")("[^",]*"|[^"]*)*$/ ) { # Basically /","/
   while( match(string,/^([^",]|"([^"]|"")*")*,/) ){
	array[++i]	= substr(string,RSTART,RLENGTH-1)
	string		= substr(string,RSTART+RLENGTH)
   }
	array[++i] = string
  } else {
	i = split(string,array,/,/)
 }
 return i
}

## TODO:
# # csv_equivalency_check, NF must be the same for all records
# # maybe gsub(/[\n]/,"\\n",csvrecord?)
