# Get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo " $ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Checks if there are commits ahead from remote
function git_prompt_ahead_count() {
  summary=$(git branch -vv 2> /dev/null | egrep '^\*')
  if echo "$summary" | egrep -q 'ahead [0-9]+'; then
    cnt=$(echo $summary | sed 's/.*ahead \([0-9]*\).*/\1/')
    echo "$ZSH_THEME_GIT_PROMPT_AHEAD_PREFIX$cnt$ZSH_THEME_GIT_PROMPT_AHEAD_SUFFIX"
  fi
}

function virtualenv_prompt_info(){
  if [[ -n $VIRTUAL_ENV ]]; then
    echo "${VIRTUALENV_PREFIX}${${VIRTUAL_ENV}:t}${VIRTUALENV_SUFFIX}"
  fi
}

# Disable prompt mangling in virtual_env/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1

PROMPT='%{$fg_bold[blue]%}%c$(git_prompt_ahead_count)$(parse_git_dirty)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}∂%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_AHEAD_PREFIX=" %{$fg[blue]%}+"
ZSH_THEME_GIT_PROMPT_AHEAD_SUFFIX="%{$reset_color%}"
VIRTUALENV_PREFIX=" %{$fg_no_bold[green]%}"
VIRTUALENV_SUFFIX="%{$reset_color%}"
