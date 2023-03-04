# ==========================================================
# Plugins
# ==========================================================

# Load the Antigen plugin manager
source $HOME/.zsh/antigen.zsh
source ~/.env-vars

antigen use oh-my-zsh

# OMZ packages
antigen bundle command-not-found
antigen bundle jsontools

antigen bundle zsh-users/deno

# Syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions


# Load the theme
antigen theme robbyrussell

source ~/.zsh/catppuccin-zsh-syntax-highlighting.zsh # Fancy syntax highlighting

antigen apply

# ==========================================================
# Aliases
# ==========================================================


# bun completions
[ -s "/Users/tim/.bun/_bun" ] && source "/Users/tim/.bun/_bun"

 # Al# Vim -> NeoVim
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias misspell="~/bin/misspell"
alias ngrok="~/ngrok"

# Source zsh
alias reload="exec zsh"

# ==========================================================
# Paths
# ==========================================================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


export PATH="/usr/local/sbin:$PATH"


# Google application credentials 
# expo extract
export GOOGLE_APPLICATION_CREDENTIALS="/Users/tim/Projects/expo-extract/expo-extract-auth.json"

# Path for flutter CLI tool
 export PATH="$PATH:$HOME/flutter/bin"

# pnpm
export PNPM_HOME="/Users/tim/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"


# Bun
export BUN_INSTALL="/Users/tim/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Changes lazygit default config directory
export XDG_CONFIG_HOME="$HOME/.config"

# Deno
export DENO_INSTALL="/Users/tim/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Python
export PYTHONPATH="/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7" # Path of python3 packages

# tabtab source for packages
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # Not really sure what this is.

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tim/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/tim/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tim/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/tim/google-cloud-sdk/completion.zsh.inc'; fi
