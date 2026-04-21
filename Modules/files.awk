
# -------- Modules/files.awk

#function cleanfullpath(dir){
# gsub(/\/\.\/|\/.$/,		"/",	dir) # /./ -> /
# gsub(/\/+/,				"/",	dir) # // -> /
# gsub(/[^\/]+\/\.\.\/+/,	"",		dir) # /1/dir/../ -> /1/
## gsub(//]+\/\.\.\/+/,	"",		dir) # /1/dir/../ -> /1/
# return dir
#}

function cleanfullpath(dir){

# inside the path
  gsub("/\\./","/",dir)
  gsub("[^/]+/\\.\\./","",dir)

 gsub(/\/+/,	"/",	dir) # // -> /

# outside the path
 gsub("^\\./|^\\.\\./|[^/]+/\\.\\.$|/\\.$","",dir)

 return dir
}

# mawk says this is a bug
function dirname(_dirname_){ 
  sub(/\/[^/]+$/,"",_dirname_)
  return _dirname_
}

function basename(_name_,_suffix_) {
 gsub(/^\/|[^/]+\//,"",_name_)
 if (_suffix_) {
   _suffix_	= index(_name_,_suffix_)-1
   _name_	= substr(_name_,1,_suffix_)
 }
 return _name_
}
