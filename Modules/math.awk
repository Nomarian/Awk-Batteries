#!/usr/bin/awk -f

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

# idk why but its there
function multiply(x,y,i){
 for (i=x;--y;) i+=x
 return i
}

# Little test of speed I use between languages.
function powerof(x,y,i){
 #for (i=x;--y;) i*=x
 for (i=x;--y;) i = multiply(x,i)
 return i
}

function factors(n,	limit,a){
 limit = int(sqrt(n))
 a = 1 " " n
 for (i=2;i<limit;i++)
  if (n%i==0) a = a " " i " " n/i
 return a # can't return an array, but strings are arrays so.
 # remember to split()
}

function factors(n,	limit,i){
 limit = int(sqrt(n))
 for (i=2;i<limit;i++) {
  if (n%i==0) { print " " i ":" n/i }
 }
}

# isprimenumber (but only checks for uneven numbers)
function isprimeu(n,	i,limit) {
 limit = int(sqrt(n))
 for (i=3;i <= limit;i+=2)
  if (n%i==0) return 0
 return 1
}

function primepos(n,	p){
 n -= ( (n==1) ? p=2 : p=3 ) - 1
 while (n) isprimeu(p+=2) && n--
 return p
}

function isprime(n) {
 if (n<3) return n==2
 if (n%2==0) return 0
 return isprimeu(n)
}

function floor(n) { return int(n) }


function primefactors(n,	p,c,a,an){
 if (n==1) return a[1] = n
 while ( ! isprime(n) ) {
  p = primepos(++c)
  if ( n%p==0 ) {
   a[++an] = p; n = n/p; c = 0
  }
 }
 a[++an] = n
}

function primefactors1(n,	p,c){
 if (n==1) {print n;return n}
 printf n " = "
 while ( ! isprime(n) ) {
  p = primepos(++c)
  if ( n % p ==0 ) {
   printf p " x "
   n = n/p; c = 0
  }
 }
 print n
}
