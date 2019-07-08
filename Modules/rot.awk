#!/usr/bin/awk -f

# TODO: Usage should be both a file or a parameter/argument

BEGIN {
 split("abcdefghijklmnopqrstuvwxyz",alphabet,"")
 for(char in alphabet) { # Sets alphabet[character] instead of [int]
  alphabet[ alphabet[char] ] = char
  alphabet[ toupper( alphabet[char] ) ] = char
 }
 #print srot13("Oh My!") should yield: Bu Zl!
 # symbols are ignored and not rotated
}

function crot(char,rot, pos){ # Character Rotater
  if ( char !~ /^[A-Za-z]$/ ) {return char}
  
  pos = ( alphabet[char] + rot ) % 26
  if (pos == 0) pos = 26
  
  if (char ~ /^[A-Z]$/) { return toupper(alphabet[pos]) }
  return alphabet[pos]
}

function srot(string,rot, a,i) { # String Rotater
  split(string,a,"")
  for(i in a){ s = s crot(a[i],rot) }
  return s 
}

function crot13(char){ return crot(char,13) }

function srot13(string, a,s){ return srot(string,13) }


