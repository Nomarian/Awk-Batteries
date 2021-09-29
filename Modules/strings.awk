
BEGIN {
 for (i=127;--i;)
  ascii[i] = sprintf("%c", i)'
# word="\w"
# line="\n"
}

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

function strReverse(string,	a, i){
 i = split(string,a,"")
 for (string = "";i;) string = string a[i--]
 return string
}

function isPalindrome(s) { # t/f
 return strReverse(s) == s
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

# Mimics grep -o
# prints only for now, could probably return an array, or a string divided by SUBSEP
function grepo(s,r,		t1,t2,c){
 t1=RSTART;t2=RLENGTH;c=0
 while (match(s,r)){ c++
  print substr(s,RSTART,RLENGTH)
  sub(r,"",s)
 }
 RSTART=t1;RLENGTH=t2
 return c
 # match, substr, sub, keep s, 
}
