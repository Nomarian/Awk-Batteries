
# ---------- Modules/csv.awk

function qcheck(s){ # true if quote has not been terminated
# return s ~ /"/ && s !~ /^([^"]|"[^"]*")*$/
 return s ~ /^("[^"]*"|[^"])*"[^"]*$/
}


function csvsplit(string,array,		i,_start_,_length_){ # Will split string into array
# returns -1 if quote is unterminated !/""/
 if ( string ~ /"/ && string !~ /^([^"]|"[^"]*")*$/ ) return -1
 # replace with r["StringOdd"]?

 _start_ = RSTART; _length_ = RLENGTH

 if ( string ~ /^([^",]*|"([^",]|"")*")*$|^(([^",]*|"([^",]|"")*")*,([^",]*|"([^",]|"")*")*)+$/ ) {
	i = split(string,array,/,/) # split may be faster?
  } else {
   while( match(string,/^([^",]|"([^"]|"")*")*,/) ){
	array[++i]	= substr(string,RSTART,RLENGTH-1)
	string		= substr(string,RSTART+RLENGTH)
   }
	array[++i] = string
	# i = csvmatchsplitter(string,array) # Replace with just this?
 }

 RSTART = _start_; RLENGTH = _length_
 return i
}

function csvmatchsplitter(string,array,		i,_start_,_length_){ # Will split string into array
 if ( string ~ /"/ && string !~ /^([^"]|"[^"]*")*$/ ) return -1 # TODO: /"""/ ?

 _start_ = RSTART; _length_ = RLENGTH
 i=0

 while( match(string,/^([^",]|"([^"]|"")*")*,/) ){
  array[++i]	= substr(string,RSTART,RLENGTH-1)
  string	= substr(string,RSTART+RLENGTH)
 }
 if (i) array[++i] = string

 RSTART = _start_; RLENGTH = _length_
 return i
}

# if (qcheck(s) && csvmatchsplitter(s))

## TODO:
# # csv_equivalency_check, NF must be the same for all records
# # maybe gsub(/[\n]/,"\\n",csvrecord?)

# /^(,?[^",]*,?|,?"([^",]|"")*")*$/ # regex101?
# /^(,?([^",]|"([^",]|"")*")*,?)*$/ #catastrophic backtracking?!