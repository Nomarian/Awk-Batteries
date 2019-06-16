
function getworda(string){ # Will return N in FS, use word[N] to fetch the found
 if (word[1] != NR) {
  delete word
  word[1]=NR
 }
 
 for (i=1;i<=NF;i++)
  if ($i == string) {
   word[length(word)+1] = $i
   return i
  }
}

function getword(string){ # Will return N in FS
 for (i=1;i<=NF;i++)
  if ($i == string) return i
 # handy for finding arbitrary fields: print $(getword("one")+1)
}

