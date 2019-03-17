
# ----------- parse.awk
# Sets regex so you can concatenate and create your regex
# values are inexact, concatenate ^ and $ to the r

# x/[\\"]/i/\\/

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
}

# you can print a variable and get the literal regex that you can use in your code
# this could be an array called regexes
