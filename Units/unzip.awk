
# for output of unzip -l

BEGIN {
 getline
 $1=""
 archive=$0
 sub(/^ +/,"",archive)
 getline; getline
}

{ LENGTH=DATE=TIME=FILE="" }

NF>3 {
 LENGTH=$1
 DATE=$2
 TIME=$3
 $1=$2=$3=""
 sub(/^ +/,"")
 FILE=$0
 $1=LENGTH; $2=DATE; $3=TIME; $4=FILE
}
