#!/usr/bin/awk -f

function help(){
 print "seq stop"
 print "seq start stop"
 print "seq start stop step"
}

BEGIN {
 if (ARGC==1 || ARGC==0 || ARGC>4 ) {help(); exit 1}

 step=1
 if (ARGC==2) { start=1;	stop=ARGV[1]; }
 if (ARGC==3) { start=ARGV[1];	stop=ARGV[2]; }
 if (ARGC==4) { start=ARGV[1];	stop=ARGV[2];	step=ARGV[3] }

 for (i=start;i<=stop;i+=step) print i
 
 exit 0
}
