
# Not useful, just awk idiosyncrasies

function isnumber(s){
 if (s==0) return 1
 return s/1
}

function isstring(s){
 if (s==0) return 0
 return !(s/1)
}

