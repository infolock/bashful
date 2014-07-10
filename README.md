bashful
=======

I've had these out as a gist for a while now, but figure its probably best to just keep them as an actual repo.  Useful for linux.  Note that yumremi is for Centos tho..

# Contents

## filesystem.sh

### minitar / miniuntar
This helper allows you to quickly tar/untar uzing bzip compression.  There are many ways to compress files and directories.  The method this helper uses typically does the best overall for me.

> Ex (minitar):    minitar myCompressedFolder.tar.gz /path/to/folder/to/compress
> Ex (miniuntar):  miniuntar myCompressedFolder.tar.gz

### rmds
Recursively searches within the current working directory including all sub directories and removes the files .DS_Store, .apdisk or anything with a ._ prefix .   This command takes no params.


### find_in_files
Recursively searches within the current working directory including all sub directories and finds any files that contains the search text

> Ex:  find_in_files "username"

### fib
Perhaps my most used and favorite shortcut.  Searches your .bash_history for a given string.  Useful when you're looking for a previous command you ran, but for the love of God can't remember what it was exactly.

> Ex: fib x11vnc
> Ex: fib iptables


### webperms
Recursively applies chmod 644 to all files and chmod 755 to all directories from within the current folder.  Current working path folder's permissions aren't changed tho.


## iptables
Useful for the paranoid (yours included).
