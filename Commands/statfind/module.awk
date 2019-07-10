
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
 totalsizeb	= $17
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

# Extensions
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
