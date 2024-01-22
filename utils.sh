function sherman_heading() {
  echo "\n\n$1\n"
}

function clear_shermandir() {
  sherman_heading "Clearing shermandir"

  rm -r $SHERMAN/.sherman
  mkdir $SHERMAN/.sherman
}

