
#BEGIN {
# word="\w"
# line="\n"
#}

#function words(_string_){
# # returns word Count
# words = gsub(/\w/,"&",_string)
#}

#function lines(_string_,){
# # useful if changed RS
# return gsub(line,"&",_string_)
#}

#function chars(_chars_) {
# return length(_chars_ RS)
#}

function reversestr(string,	a, b, i){
 b = split(string,a,"")
 string = ""
 for (i=b;i>0;i--) string = string a[i]
 return string
}

# This function is meant to be used when you want to use match
# but don't want to mess with RSTART and RLENGTH
function substrmatch(_str_,_regex_,	_RSTART_,_RLENGTH_){
 _RSTART_	= RSTART
 _RLENGTH_	= RLENGTH
 if ( match(_str_,_regex_) ) {
   _str_=substr(_str_,RSTART,RLENGTH)
  } else {
   _str_=""
 }
 RSTART		= _RSTART_
 RLENGTH	= _RLENGTH_
 return _str_
}

#{
# words += NF
# chars += length($0 ORS)
#}

#END {
# printf(" %i\t%i\t%i\t%s\n", NR, words, chars, FILENAME)
#}
