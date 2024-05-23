# Sherman the best shell config

This is my personal shell configuration. Its probably not very useful for anyone else, but I thought I'd put it in
version control with a way of loading it up.

## How to bootstrap sherman

1. Clone sherman into $HOME/sherman-the-shell-config
2. Copy `zshrc.sh` into `$HOME/.zshrc`
3. Source zshrc `source $HOME/.zshrc`
4. Reload sherman `sherman_reload`

## Loading configuration changes

Run `sherman_reload`.

If you've made changes to any shell files, it is prudent to run `sherman_reload` twice to ensure that its boostrapped
correctly.
