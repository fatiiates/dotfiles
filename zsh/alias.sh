#!/bin/bash

# System
alias ll='ls -lGaf'
alias rm='rm -i'

if [ -x "$(command -v exa)" ]; then
    alias ls="exa"
    alias la="exa --long --all --group"
fi

# Containerization
alias d='docker'
alias dc='docker compose'
alias k='kubectl'

# git
alias gad="git add"
alias gacp='f() { git add . && git commit -m "$1" && git push origin $(git branch --show-current); }; f'
alias gbn="git rev-parse --aliasev-ref HEAD"
alias gcd1="git clone --depth 1 https://github.com/"
alias gcl="git clean"
alias gclone="git clone "
alias gcmt="git commit -am "
alias gco="git checkout"
alias gcob="git checkout -b "
alias gcod="git checkout develop"
alias gcom="git checkout main"
alias get="git"
alias glg="git log"
alias glog="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias gpll="git pull"
alias gpristine="git reset --hard && git clean -fdx"
alias gpsh="git push"
alias gpsuo="git push --set-upstream origin (git rev-parse --aliasev-ref HEAD)"
alias grv="git remote -v"
alias gsh="git stash"
alias gst="git status -sb"
alias grmcache='git rm --cached $(git ls-files -c -i -X .gitignore)'

# go
alias gob="go build"
alias goc="go clean"
alias god="go doc"
alias gof="go fmt"
alias gofa="go fmt ./..."
alias gog="go get"
alias goi="go install"
alias gol="go list"
alias gop="cd \$GOPATH"
alias gopb="cd \$GOPATH/bin"
alias gops="cd \$GOPATH/src"
alias gor="go run"
alias got="go test"
alias gov="go vet"

# system
alias brewup="brew update && brew upgrade && brew cleanup"
alias la="ls -la"
alias ldot="ls -ld .*"
alias ll="ls -la"
alias lsa="ls -aG"
alias nv="nvim"
alias tarls="tar -tvf"
alias untar="tar -xv"
alias zdot="cd \$ZDOTDIR"
alias zz="exit"
alias clear='printf "\033c"'