# Sherman's main entrypoint
echo "Starting sherman"

source $HOME/sherman-the-shell-config/constants.sh
source $SHERMAN/utils.sh
source $SHERMAN/reload.sh
source $SHERMAN/aliases.sh
source $SHERMAN/private_aliases.sh
source $SHERMAN/programmes.sh

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
