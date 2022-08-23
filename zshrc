# ===========================================================================================================
# Plugins
# ===========================================================================================================

# Load the Antigen plugin manager
source $HOME/antigen.zsh

antigen use oh-my-zsh

# OMZ packages
antigen bundle command-not-found
antigen bundle jsontools

# Syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Load the theme
antigen theme robbyrussell

antigen apply



# ===========================================================================================================
# Paths
# ===========================================================================================================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


export PATH="/usr/local/sbin:$PATH"

export PATH="/usr/local/opt/valet-php@7.3/bin:$PATH"
export PATH="/usr/local/opt/valet-php@7.3/sbin:$PATH"
export PATH="/usr/local/opt/valet-php@7.2/bin:$PATH"
export PATH="/usr/local/opt/valet-php@7.2/sbin:$PATH"
export PATH="/usr/local/opt/valet-php@7.3/bin:$PATH"
export PATH="/usr/local/opt/valet-php@7.3/sbin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

# Path for flutter CLI tool
 export PATH="$PATH:$HOME/flutter/bin"
 
 # Alias for aStorms build tool for magento: pestle ( https://github.com/astorm/pestle )
 
 alias pestle="php $HOME/pestle.phar"

export PATH="/usr/local/opt/valet-php@7.3/bin:$PATH"
export PATH="/usr/local/opt/valet-php@7.3/sbin:$PATH"

# Vim -> NeoVim
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias misspell="~/bin/misspell"
alias ngrok="~/ngrok"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bun completions
[ -s "/Users/tim/.bun/_bun" ] && source "/Users/tim/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/tim/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/tim/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
