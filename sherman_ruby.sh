if [[ ! -d $SHERMAN/.sherman/ruby ]]
then
  echo "Setting up sherman ruby"

  mkdir -p $SHERMAN/.sherman/ruby

  pushd $SHERMAN_RUBYDIR

  for file in *
  do
    ln -s "$SHERMAN_RUBYDIR/$file" "$SHERMAN/.sherman/ruby/sherman_$file"
  done

  popd

  export PATH="$SHERMAN/.sherman/ruby:$PATH"
fi
