
# ----------- parse.awk
# Sets regex so you can concatenate and create your regex
# values are inexact, concatenate ^ and $ to the r

# x/[\\"]/i/\\/

function str2regex(s){
 gsub("%.","\\.",s) # dots
# gsub("%%","%",s) # unnecessary, matching directly
 gsub("%d","0-9",s) # digits
 gsub("%l","a-z",s) # lowercase letters
 gsub("%u","A-Z",s) # uppercase letters
 gsub("%x","0-9a-zA-F",s) # hex digits
 # include a variable (must be literal)
 # like @ because forth fetch?
 return s
}

BEGIN { # try using (regex) ?
 #( Numbers )#
 rdigit		= "[0-9]"	# digit
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
 hex		= "[0-9a-fA-F]"
 
# Matches ipv4 string
 ripv4		= r8bit "\\." r8bit "\\." r8bit "\\." r8bit

 ripv6		= hex "?"
 ripv6		= ripv6 ripv6 ripv6 ripv6
 ripv6		= ripv6 ":" ripv6 ":" ripv6 ":" ripv6 ":" ripv6 ":" ripv6 ":" ripv6 ":" ripv6

}

# you can print a variable and get the literal regex that you can use in your code
# this could be an array called regexes


