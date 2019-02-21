#!/usr/bin/awk -f

function dirname(_dirname_){ 
  sub(/\/[^/]+$/,"",_dirname_)
  return _dirname_
}
