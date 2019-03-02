#!/usr/bin/awk -f

# sponge.awk
# If you want to write to a file, pipe to tee.awk

BEGIN { FS=RS=OFS=ORS="" }
END {print}
