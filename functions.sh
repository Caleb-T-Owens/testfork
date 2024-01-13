# Holds functions for use in shells
echo "Loading user functions"

# This is a function which will keep trying to tap into the docker container
function dbash() {
  while true
  do
  docker compose exec $1 bash
  echo "quit me quick!"
  sleep 1
  done
}
