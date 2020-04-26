
function hex2num(hex) {
 if (hex !~ "^0x") hex="0x" hex
 return strtonum(hex)
}
