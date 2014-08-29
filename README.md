bashful
=======

I've had these out as a gist for a while now, but figure its probably best to just keep them as an actual repo.  Useful for linux.  Note that yumremi is for Centos tho..

# Contents

## File: .bashrc
Primary `source` file.  
> NOTE to Mac users:  You'll want to rename this to be .profile instead ( I may actually add a .profile build in the future ).
>                     Also, you will either need to define the HOME environment key ( if it doesn't already exist ) or simply 
>                     replace $HOME with a full-path to your user's home folder ( i.e., /Users/bob/ )
>                     Finally, you'll want to remove the first 4 lines in this file that is checking for bashrc ( or update the 
>                     path information as needed ).


### minitar / miniuntar
This helper allows you to quickly tar/untar uzing bzip compression.  There are many ways to compress files and directories.  The method this helper uses typically does the best overall for me.

> Ex (minitar):    minitar myCompressedFolder.tar.gz /path/to/folder/to/compress
> Ex (miniuntar):  miniuntar myCompressedFolder.tar.gz

### ulist
Displays a list of usernames that have been created

### OS Distribution and Version Information
### distro
Displays information that can be used to determine what OS ( a.k.a, flavor ) is installed on the server.  This is a good way of identifying wether CentOS, Redhat, Ubuntu, etc. is the primary OS type.

### kernelver
Displays the current kernel version being used.

### kernelgccver
Displays the current kernel version being used, along with the installed GCC version.

### pkglist
Displays a list of installed packages.  Currently supports YUM and RPM - just comment out the one you don't need, and uncomment the one you do.


## File: tools/filesystem.sh

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


## File: tools/iptables.sh
Useful for the paranoid (yours included).
