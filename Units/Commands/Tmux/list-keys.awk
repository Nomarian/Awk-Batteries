
# use tmux list-keys | awk -f ./thisfile

{
 t=3+($2=="-r")
 table=$(t++)
 key=$(t++)
 cmd=$(t++)
 for (i=1;i<t;i++)
  $i=""
 $0=$0 # Should reload FS
 # $0 is args
}

debug { # -v debug=1 to print the table
 print "table: " table "\tkey: " key "\t command: " cmd "\targs: " $0
}
