# Load or configure programmes
echo "Loading programme's specific configurations"

# Set shell
export EDITOR='nvim'

# Pull in rust (cargo) binaries
source "$HOME/.cargo/env"

# GNU Bison - I don't remember why I need this
export PATH="/opt/homebrew/opt/bison/bin:$PATH"

# A local bin file - I don't remember using this
export PATH="/Users/calebowens/bin:$PATH"

# Load yarn packages in to PATH
export PATH="/Users/calebowens/.yarn/bin:$PATH"

# Load nvm shims
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm

# Load sdkman shims
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
