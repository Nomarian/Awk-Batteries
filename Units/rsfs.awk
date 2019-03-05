
# RSFS.awk
# Will import RS and FS from ENVIRON if its set

BEGIN {
 if (ENVIRON["FS"]) FS=ENVIRON["FS"]
 if (ENVIRON["RS"]) RS=ENVIRON["RS"]
}
