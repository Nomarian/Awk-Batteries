
A wrapper around find and stat so you can use awk

Example: { main.rc directory/files '' }
The last arg is a gawk expression

you must use byrons rc shell
ln main.rc to your $PATH
edit in main.rc the dir = to wherever the script is in your path

Look at format.awk for the variables used that you can call within awk
