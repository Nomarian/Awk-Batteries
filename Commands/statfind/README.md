
## awkstat


A wrapper around find and stat so you can use awk


Example: { ./main.rc 'awk expression' --options-for-find }


### Requires

* Byron's rc shell
* gawk
* gnu stat


### Notes


edit $dir in main.rc to wherever this points to in path since it needs to read module.awk


Look at format.awk for the variables used that you can call within awk
