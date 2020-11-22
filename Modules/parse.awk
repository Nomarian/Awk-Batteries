
# ----------- parse.awk
# Sets regex so you can concatenate and create your regex
# values are inexact, concatenate ^ and $ to the r
# literals, beware of html
# caseinsensitivity, [Aa][Bb][Cc]
# repetitions, (although it would be nice to get rid of +?* and just use
# the {} syntax, we have to do it backwards
# so 5 ,5 5, 3,5 , 
# 5		set set set set set
# 5,	set set set set set+
# ,5	set? set? set? set? set?
# 3,5	set set set set? set?
# ,		set*
# what about -1 or 0?

# x/[\\"]/i/\\/

# adds a \ to every single regex character found in s, returns a regex
# basically a x/(replacechar)/ c/\\\1/
function regex_literal(s,	x,before){
 _RSTART_=RSTART;_RLENGTH_=RLENGTH
 while (s){
  if ( match(s,/[\?\.\[\]\(\)\\\*\^\$\|\+\-]/) ) { # match any regex special character
   # go to character and prepend a \\ before it
   # get everything before the character
   # the first substr gets the string before the character
   # the second is the character
   x = x substr(s,1,RSTART-1) "\\" substr(s,RSTART,RLENGTH)
   s = substr(s,RSTART+RLENGTH) # advance input of s
  } else { # no match, return the rest
   x = x s # concatenate x with the rest of s
   s = "" # erase s to terminate loop
  }
 }
 print x ~ s
 RSTART=_RSTART_;RLENGTH=_RLENGTH_
 return x
}

# This will convert a semi lua parse dialect into an awk regex
function str2regex(s,	i,r,p,_RSTART_,RLENGTH_,c){
 _RSTART_=RSTART;_RLENGTH_=RLENGTH

 # Elements are the regex
 # the value is the character set
 # p can only be one char
# p["%p"]	= "" # punctuation characters
 p["a"]	= "A-Za-z"
 p["c"]	= "\x00-\x1f\x7f" # control characters.
 p["g"]	= "!-~"
 p["s"]	= " \t\r\n"
 p["w"]	= "A-Za-z0-9"
 p["d"]	= "0-9" # digits
 p["u"]	= "A-Z" # uppercase letters
 p["l"]	= "a-z" # lowercase letters
 p["x"]	= "0-9a-zA-F" # hex digits
 p["q"]	= "\""	# Double Quote
 p["Q"]	= "'"	# Single Quote

 p["%"] = "%"	# a literal %
 p["^"] = "\\^"
 p["$"] = "\\$"
 p["("] = "\\("
 p[")"] = "\\)"
 p["["] = "\\["
 p["]"] = "\\]"
 p["\\"] = "\\\\"
 p["h"] = "\\\\" # for backslas_h_?
 p["H"] = "/" # slas_H_?
 p["+"] = "\\+"
 p["?"] = "\\?"
 p["*"] = "\\*"
 p["|"] = "\\|"
 p["{"] = "\\{"
 p["}"] = "\\}"
 p["."] = "\\."
 p["."] = "\\."
 
 i = s # i is for input

 # special additions: literals, 
 # {} is not portable, so we convert as best we can.
 # if (ripv6){4} will recreate whatever was in the group 4 times
 # its a matter of saving the set, be it string or group, and outputting it
 # x amount of times with ? or +
 # of course, a ()* is not possible probably
 # we advance input until it runs out. transforming whatever is necessary
 while ( i ){
 # The examiner should support literals and {}
 # you could specify below, if its %{}<>
#  if ( match(i,/[%\<\>]/) ) { # Examine special char
  if ( match(i,/%/) ) { # Examine special char
   c = substr(i,RSTART,1)
   if ( c == "%" ) {
    r = r substr(i,1,RSTART-1) # save whatever was before the hit
    i = substr(i,RSTART+1) # advance input, skip special char
    if ( substr(i,1,1) in p ) { # database hit, perform a sort of gsub
     r = r p[ substr(i,1,1) ]
    } else { # not in db, grab as literal char
     r = r substr(i,1,1)
    }
    i = substr(i,2) # Advancing input and skipping special char
   } else { # probably a literal?
# NOT DONE
#    if ( c ~ "[<>]" ) {
#    } else { # its a repeat
#    }
   }
  } else { # no match. advance input to the end
   r= r i # concatenate whatever of the input is left
   i=0
  }
 }


 RSTART=_RSTART_;RLENGTH=_RLENGTH_
 return r
}

 # include a variable (must be literal)
 # not possible in awk
 # like @ because forth fetch?

BEGIN { # try using (regex) ?
 #( Numbers )#
 rdigit		= str2regex("[%d%v]")	# digit
 rdigits	= rdigit "+"	# just, digits
 ruint		= "[0-9]|[1-9][0-9]+"	# unsigned integer
 rint		= "[+-]?[1-9]|[+-]?[1-9][0-9]+|0"	# Signed? integer
 rinteger	= "[+-][1-9]|[+-][1-9][0-9]+|0"		# Signed integer
 rudec		= "[0-9]?\\.?[0-9]+|[1-9][0-9]+\\.?[0-9]+"	# unsigned decimal
 rdec		= "0|[+-]?[1-9]?\\.?[0-9]+|[+-]?[1-9][0-9]+\\.?[0-9]+"	# signed? decimal
 rdecimal	= "0|[+-][1-9]?\\.?[0-9]+|[+-][1-9][0-9]+\\.?[0-9]+"	# signed decimal

# TODO
 # rfloat	= "[+-]?[0-9]*\.?[0-9]+e[0-9]+"	# e notation
 # rfloat	= # -2.3e3 
 # rfloat	= # e notation
 # rufloat, rfloat

 rnum		= rdec # ambiguous pointer to regex for number
 rnumber	= rdecimal # always points to the most advanced regex for numbers

#( Strings )#
 rstr		= "\"[^\"]*\""		# "string"
 rstresc	= "\"([^\"\\\\]*(\\\\\\\")[^\"\\\\]*)+\"" # "String\"with\"escapes"
 rstringesc	= rstr "|" rstresc # "string" or "String\"with\"escapes"

# this is an example, in case you want to ^ or $
# rstringesc	= stresc "|" rstr # "String\"with\"escapes"

 rstrmq		= "\"([^\"]*\"\"[^\"]*)+\"" # "this""is a string" multi-quote
 rstrcsv	= "[^,]+"
 rstringcsv	= rstr "|" rstrmq "|" rstrcsv
 
 #rstringrc	= "'([^']*''[^']*)+'" # rc shell style
 rstringrc	= "'[^']*('')*[^']*'" # rc shell style

 r8bit		= "(2[0-5][0-5]|1[0-9][0-9]|[0-9][0-9]?)" # 0-255
 rhex		= "[0-9a-fA-F]"
 
# Matches ipv4 string
 ripv4		= r8bit "\\." r8bit "\\." r8bit "\\." r8bit

 ripv6		= hex "?"
 ripv6		= ripv6 ripv6 ripv6 ripv6
 ripv6		= ripv6 ":" ripv6 ":" ripv6 ":" ripv6 ":" ripv6 ":" ripv6 ":" ripv6 ":" ripv6

}

# you can print a variable and get the literal regex that you can use in your code
# this could be an array called regexes



# ----------- regex.awk
# Sets regex so you can concatenate and create your regex
# values are inexact, concatenate ^ and $ to r

# x/[\\"]/i/\\/

BEGIN { # try using (regex) ?
 #( Numbers )#
 r["digit"]		= str2regex("[%d]")	# digit
 r["digits"]	= rdigit "+"	# just, digits
 r["uint"]	= "[0-9]|[1-9][0-9]+"	# unsigned integer
 r["int"]	= "[+-]?[1-9]|[+-]?[1-9][0-9]+|0"	# Signed? integer
 r["integer"]	= "[+-][1-9]|[+-][1-9][0-9]+|0"		# Signed integer
 r["udec"]	= "[0-9]?\\.?[0-9]+|[1-9][0-9]+\\.?[0-9]+"	# unsigned decimal
 r["dec"]	= "0|[+-]?[1-9]?\\.?[0-9]+|[+-]?[1-9][0-9]+\\.?[0-9]+"	# signed? decimal
 r["decimal"]	= "0|[+-][1-9]?\\.?[0-9]+|[+-][1-9][0-9]+\\.?[0-9]+"	# signed decimal

# TODO
 # rfloat	= "[+-]?[0-9]*\.?[0-9]+e[0-9]+"	# e notation
 # rfloat	= # -2.3e3 
 # rfloat	= # e notation
 # rufloat, rfloat

 r["num"]	= rdec # ambiguous pointer to regex for number
 r["number"]	= rdecimal # always points to the most advanced regex for numbers

#( Strings )#
 q		= "\""
 r["q"]		= q
 r["Q"]		= "[^" q "]" # No quotes
 r["string"]	= q r["Q"] "*" q		# "string"

 r["stresc"]	= q "([^\"\\\\]*(\\\\\\\")[^\"\\\\]*)+" q # "String\"with\"escapes"
# There's a dizzying amount of slashes here, it's ridiculous
 # r["escapedstring"]	= q "(" r["Q"] "|" "|"  ")*" q # "String\"with\"escapes"
 # r["stringesc"]	= r["string"] "|" r["stresc"] # "string" or "String\"with\"escapes"

# this is an example, in case you want to ^ or $
# rstringesc	= stresc "|" rstr # "String\"with\"escapes"
# r["stringrc"]	= "'([^']*''[^']*)+'" # rc shell style
# r["stringrc"]	= "'[^']*('')*[^']*'" # rc shell style

 re		 = "(" r["string"] "|" r["Q"] ")*"
 r["StringOdd"]	 = "^" re q r["Q"] "*$"	# dangling quote
# r["stringodd"]	 = re q r["Q"] "*"	# dangling quote
 r["StringEven"] = "^" re "$" # "contains an "" even "number" of quotes"

 r["8bit"]	= "(2[0-5][0-5]|1[0-9][0-9]|[0-9][0-9]?)" # 0-255
 r["hex"]	= "[0-9a-fA-F]"
 
 r["ipv4"] = r["8bit"] "\\." r["8bit"] "\\." r["8bit"] "\\." r["8bit"]

# Matches ipv6 string
 re = r["hex"] "?"
 re = re re re re # re{4}, but oawk has no repetitions
 re = re ":" re ":" re ":" re ":" re ":" re ":" re ":" re
 r["ipv6"] = re; re=""

# Matches any ip
 r["ip"] = r["ipv4"] "|" r["ipv6"]

 re = ""
 for (i in r) print i ": " r[i]
}

function printexport(s){ # prints with escapes for use in strings \"
 gsub(/"/,"\\\"",s)
 print s
}

