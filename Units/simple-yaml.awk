
# if you need to edit something, some versions of awk will wipe out the whitespace
# so run addws() whenever you edit

# Example
# gawk -f ./yaml.awk -e 'tree == "foo:bar:" && $1=="baz:" {sub(/val/,"bar")} {print}'

# you can also use $2, but you have to run addws to fix the record
# gawk -f ./yaml.awk -e 'tree == "foo:bar:" && $1=="baz:" {$2="bar";addws()} {print}'

# its portable, but written in a way so that you can use -i inplace, no {next} are used
# gawk -i inplace -f ./yaml.awk -e 'tree == "foo:bar:" && $1=="baz:" {$2="bar";addws()} {print}'

function rebuild() { tree=""
 for (i=0;i<=ws;i++)
  if ( brancha[i] ) tree = tree brancha[i]
 leaf = brancha[ws]
}

function addws(n,	s){ # add some whitespace
 i=ws
 while(i--) $0= " " $0
}

{
 lws = ws

 s=$0; gsub(/^ +/,"",s) # this could be sped up?
 ws = length($0)-length(s)
}

NF {
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
