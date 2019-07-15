
function _dirname_(file){ 
  sub(/\/[^/]+$/,"",file)
  return file
}

function _basename_(_name_,_suffix_) {
 gsub(/^\/|[^/]+\//,"",_name_)
 if (_suffix_) {
   _suffix_	= index(_name_,_suffix_)-1
   _name_	= substr(_name_,1,_suffix_)
 }
 return _name_
}

function makesizes(bytes,array){
 # for loop that is stored in a 
 # while loop that stores everything in an array, until it reaches 0
 # better to use a while loop instead, and maybe later make pb and so on

 split("0 0 0 0",array," ")
 for (i=1;i<=length(array);i++) {
  bytes /= 1024
  if (bytes<1) break
  array[i] = bytes
 }

 sizekb	=array[1]
 sizemb	=array[2]
 sizegb	=array[3]
 sizetb	=array[4]
}

BEGIN {
 FS="\r"
}

{ # This depends on the formats file... maybe?
 operms		= $1
 huperms	= $2
 humanperms	= $2
 permission	= $2
 permissions	= $2
 blocks		= $3
 ByteBlocks	= $4
 DeviceNum	= $5
 DeviceHex	= $6
 rawhex		= $7
 filetype	= $8
 groupid	= $9
 gid		= $9
 groupname	= $10
 hardlinks	= $11
 inode		= $12
 mount		= $13
 file		= $14
 FileName	= $15
 optimalIO	= $16
 sizeb		= $17
 majordevicetype	= $18
 minordevicetype	= $19
 uid		= $20
 uname		= $21
 hbirth		= $22
 birth		= $23
 haccess	= $24
 access		= $25
 hmod		= $26
 mod		= $27
 hchange	= $28
 change		= $29
 inodetotal	= $30
 maxfilelength	= $31
 fublocksize	= $32

 $0=file # for quick searching with //

# Synonyms
 username=uname
 

# Extensions
 
 makesizes(sizeb)
 filename	= _basename_(file)
 if (filetype == "directory") {
	dirname = file
  } else {
	dirname	= _dirname_(file)
 }
}

# TODO
 # Must change formats to be in alphabetical order, reflect that change here as well
# move formats to formats.awk, format makes the awkmodule
# function erase(){ deleteit = deleteit file } SANITIZE FOR rm!
# END { "rm " deletit }
