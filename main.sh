# Sherman's main entrypoint
echo "Starting sherman"

source $HOME/sherman-the-shell-config/constants.sh
source $SHERMAN/utils.sh
source $SHERMAN/reload.sh

# Existing config
export EDITOR='nvim'
source "$HOME/.cargo/env"
export PATH="/opt/homebrew/opt/bison/bin:$PATH"
export PATH="/Users/calebowens/bin:$PATH"
export PATH="/Users/calebowens/.yarn/bin:$PATH"
export PATH="/opt/homebrew/Cellar/jemalloc/5.3.0/bin:$PATH"
export PATH="/opt/homebrew/opt/gradle@7/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm

# My interesting stuff
alias tx='tmuxinator'

# Docker aliases
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dce="docker compose exec"
alias dcr="docker compose run"

function gnb() {
  local ORIGIN="origin/main"
  if [ "$2" != "" ]
  then
    ORIGIN=$2
  fi
  git fetch $ORIGIN
  git checkout -b $1 $ORIGIN
  git push -u origin $1
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

function dbash() {
  while true
  do
  docker compose exec $1 bash
  echo "quit me quick!"
  sleep 1
  done
}

function blitzdb() {
  docker compose down
  docker compose run --rm web bash -c "\
  rails db:drop &&\
  rails db:create &&\
  rails db:migrate &&\
  rails db:seed &&
  exit"
  docker compose up -d
}

function blitzdbschema() {
  local ORIGIN="origin/main"
  if [ "$1" != "" ]
  then
    ORIGIN=$1
  fi
  local FORKPOINT=$(git merge-base --fork-point ORIGIN)

  docker compose down

  # Enter parent branch
  git stash
  git checkout $FORKPOINT

  docker compose run --rm web bash -c "\
  rails db:drop &&\
  rails db:create &&\
  rails db:schema:load"

  # Exit parent branch
  git checkout -
  git stash pop

  docker compose run --rm web bash -c "\
  rails db:migrate &&\
  rails db:seed"
  docker compose up -d
}

function diff_pr() {
  local ORIGIN="origin/main"
  if [ "$1" != "" ]
  then
    ORIGIN=$1
  fi
  local FORKPOINT=$(git merge-base --fork-point $ORIGIN)

  git diff --staged $FORKPOINT --stat
  git diff --staged $FORKPOINT
}

alias tymstaging="cx ssh -s 'teachmonster OOG' -e staging gecko"
alias tymprod="cx ssh -s 'teachmonster OOG' -e production cougar"

alias rip="rip --graveyard ~/.local/share/Trash"
