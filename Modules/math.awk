


#( round.awk --- do normal rounding
#
# Arnold Robbins, arnold@skeeve.com, Public Domain
# August, 1996

function round(x,   ival, aval, fraction)
{
   ival = int(x)    # integer part, int() truncates

   # see if fractional part
   if (ival == x)   # no fraction
      return ival   # ensure no decimals

   if (x < 0) {
      aval = -x     # absolute value
      ival = int(aval)
      fraction = aval - ival
      if (fraction >= .5)
         return int(x) - 1   # -2.5 --> -3
      else
         return int(x)       # -2.3 --> -2
   } else {
      fraction = x - ival
      if (fraction >= .5)
         return ival + 1
      else
         return ival
   }
}

# round.awk )#

function isprimeu(n,	i, limit) { # Odd prime check
 limit = int(sqrt(n))
 for (i=3;i <= limit;i+=2)
  if (n%i==0) return 0
 return 1
}

function isprime(n) { # is n prime?
 if (n==2) return 1
 if (n<2 || n%2==0) return 0
 return isprimeu(n)
}

# returns prime number n (as in nth prime number)
function primepos(n,	p){
 for (n-=(p=2+(n>1))-1;n;isprimeu(p) && n--)
  p+=2
 return p
}

