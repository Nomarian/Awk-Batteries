
# ----------- regex.awk
# Sets regex so you can concatenate and create your regex
# values are inexact, concatenate ^ and $ to r

# x/[\\"]/i/\\/

BEGIN { # try using (regex) ?
 #( Numbers )#
 r["digit"]	= "[0-9]"	# digit
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
}

function printexport(s){ # prints with escapes for use in strings \"
 gsub(/"/,"\\\"",s)
 print s
}