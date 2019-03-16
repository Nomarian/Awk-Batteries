
# ----------- parse.awk
# Sets regex so you can concatenate and create your regex
# values are inexact, concatenate ^ and $ to the r

# x/[\\"]/i/\\/

BEGIN {
 rdigit		= "[0-9]"	# digit
 ruint		= rdigit "+"	# unsigned integer
 rint		= "[+-]?" ruint	# Positives and Negatives
 rudec		= rdigit "*\\.?" ruint	# Unsigned Decimal
 rdec		= "[+-]?" rudec	# Signed Decimal
 rstr		= "\"[^\"]*\""		# "string"
 rstring	= "\"([^\"\\\\]*(\\\\\\\")[^\"\\\\]*)+\"" # "String\"with\"escapes"
 # TODO
 # rhex
 # rfloat	= "[+-]?[0-9]*\.?[0-9]+e[0-9]+"	# e notation
 # rfloat	= # -2.3e3 
 # rfloat	= # e notation

}

# you can print a variable and get the literal regex that you can use in your code
