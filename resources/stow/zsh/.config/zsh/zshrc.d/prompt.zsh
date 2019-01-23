PROMPT=$'-[ %n@%m:%~ ]-${vcs_info_msg_0_}\n%(?.%F{green}.%F{red})%B%#%b%f '

setopt prompt_subst

autoload -U add-zsh-hook
autoload -U vcs_info

zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' stagedstr " %F{yellow}%BS%b%f"
zstyle ':vcs_info:*' unstagedstr " %F{red}%BU%b%f"
zstyle ':vcs_info:*' formats "${_nl_}( %s )-[ %F{green}%b%f - %i ] %u%c"
zstyle ':vcs_info:*' actionformats "${_nl_}( %s | %a )-[ %F{green}%b%f - %i ]%u%c"

function preexec_prompt() {
  [[ $3 == clear ]] || [[ $3 == clear\ * ]] && _CLEARED_PROMPT_="YES"
  echo ""
}

function precmd_prompt() {

  [[ "${_CLEARED_PROMPT_}" == "NO" ]] && echo "" || _CLEARED_PROMPT_="NO"
}

function precmd_wtitle() {
  print -Pn '\e]2;'
  [[ "${TERM}" == rxvt* ]] && print -Pn 'Term: %n@%m' || print -Pn '%n'
  print -Pn ' (%~)\a'
}

function preexec_wtitle() {
  print -Pn '\e]2;'
  [[ "${TERM}" == rxvt* ]] && print -Pn 'Term: %n@%m' || print -Pn '%n'
  print -n " ${(q)1}"
  print -Pn ' (%1~)\a'
}

add-zsh-hook -Uz precmd vcs_info

add-zsh-hook -Uz precmd precmd_prompt
add-zsh-hook -Uz preexec preexec_prompt

if [[ "${TERM}" == (rxvt*|screen*|tmux*) ]]; then
  add-zsh-hook -Uz precmd precmd_wtitle
  add-zsh-hook -Uz preexec preexec_wtitle
fi
