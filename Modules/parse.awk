# Sets regex so you can concatenate and create your regex
# values are inexact, concatenate ^ and $ to the r
BEGIN {
 rdigit		= /[0-9]/	# digit
 ruint		= /[0-9]+/	# unsigned integer
 rint		= /[+-]?[0-9]+/	# Positives and Negatives
 rudec		= /[0-9]*\.?[0-9]+/	# Unsigned Decimal
 rdec		= /[+-]?[0-9]*\.?[0-9]+/	# Signed Decimal
 rstr		= /"[^"]*"/		# lonely string
 rstring	= /"([^"\\]*(\\\")[^"\\]*)+"/ # String with escapes
 rstrings	= /"[^"]*"|"([^"\\]*(\\\")[^"\\]*)+"/ # Plain String or with escapes
 #rhex
 #
# TODO
# rfloat	= /[+-]?[0-9]*\.?[0-9]+e[0-9]+/	# e notation
# rfloat	= # -2.3e3 
# rfloat	= # e notation

}
