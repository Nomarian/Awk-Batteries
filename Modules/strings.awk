
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

#{
# words += NF
# chars += length($0 ORS)
#}

#END {
# printf(" %i\t%i\t%i\t%s\n", NR, words, chars, FILENAME)
#}
