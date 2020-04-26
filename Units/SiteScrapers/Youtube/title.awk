
#( youtube title )#
# uses regex

/<meta property="og:title" content="[^"]+">/ {
 s = $0
 sub(/^.+content=\"/,"",s)
 match(s,/(\"[^\"]*\"|[^\"])*/) # This is r["StringEven"]
 title = substr(s,RSTART,RLENGTH)
}
