
function rebuild() { tree=""
 for (i=0;i<=ws;i++)
  if ( brancha[i] ) tree = tree brancha[i]
 leaf = brancha[ws]
}

{
 lws = ws

 s=$0; gsub(/^ +/,"",s) # this could be sped up?
 ws = length($0)-length(s)

 if (ws<lws) { # deletion
  for (branchws in brancha) # brancha[ws] = name
   if (branchws<ws) {
    delete brancha[branchws]
    rebuild()
   }
 } else { # addition/replace
  if ($1 !~ /^#/ && NF==1 && $1 ~ /:$/) {
   brancha[ws] = $1 # add new ws to branch
   rebuild()
  }
 }
}
