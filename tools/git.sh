#! /bin/sh

alias gco='git checkout'
alias gcb='git checkout -b'
alias grsts='git reset --soft'
alias grsth='git reset --hard'
alias gmv='git mv'
alias gbrn='git branch -m'
alias grnb='git branch -m'
alias gbl='git branch'
alias gcm='git add --all . && git commit -m'
alias glog='git log'
alias grlog='git reflog'
alias gdb='git branch -D'
alias ga='git add .'
# Show changed files given commit hash
alias glogx='git diff-tree --no-commit-id --name-only -r'

# Help
function ghelp {
    echo
    echo "git alias'"
    echo "----------"
    echo
    echo -e "\tShortcut     Git Command"
    echo -e "\t--------     -----------
    echo -e "\t ga           git add ."
    echo -e "\t gbl          git branch"
    echo -e "\t gbrn         git branch -m"
    echo -e "\t gcm          git add --all . && git commit -m"
    echo -e "\t gco          git checkout"
    echo -e "\t gcb          git checkout -b"
    echo -e "\t gdb          git branch -D"
    echo -e "\t glog         git log"
    echo -e "\t glogx        git diff-tree --no-commit-id --name-only -r"
    echo -e "\t gmv          git mv"
    echo -e "\t grlog        git reflog"
    echo -e "\t grnb         git branch -m"
    echo -e "\t grsts        git reset --soft"
    echo -e "\t grsth        git reset --hard"
}
