source <(antibody init)

# where is antibody keeping its stuff?
ANTIBODY_HOME="$(antibody home)"

# set the theme to something, or blank if you use a non omz theme
ZSH_THEME=

# tell omz where it lives
export ZSH="$ANTIBODY_HOME"/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh

# quit bugging me!
DISABLE_AUTO_UPDATE="true"

# omz!
antibody bundle robbyrussell/oh-my-zsh

antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle mafredri/zsh-async
antibody bundle sindresorhus/pure

prompt_newline='%666v'
PROMPT=" $PROMPT"
