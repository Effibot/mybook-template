#!/bin/bash

# Custom aliases for container internal user's shell
#
# Roberto Masocco <robmasocco@gmail.com>
# Alessandro Tenaglia <alessandro.tenaglia42@gmail.com>
#
# January 27, 2022

alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias ls="lsd"
alias l="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"
alias lsa="ls -lhaS"
alias clc='clear'
alias cd..='cd ..'
alias valgrind-check='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind.out'
alias docker='sudo docker'
