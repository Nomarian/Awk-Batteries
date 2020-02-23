
# lexer for tmux list-keys

# use tmux list-keys | awk -f ./thisfile -e 'table=="root"'
# variables: table,key,cmd,args
# it leaves $0 intact

{
 t=3+($2=="-r")
  table=$(t++)
  key=$(t++)
  cmd=$(t++)

# Sets args
 tmp=$0
 for (i=1;i<t;i++)
  $i=""
 sub(/^[ \t]*/,"")
 sub(/[ \t]*$/,"")
 args=$0

 $0=tmp
}

debug { # -v debug=1 to print the table
 print "table: " table "\tkey: " key "\t command: " cmd
 if (args) print "\targs: " args
}
