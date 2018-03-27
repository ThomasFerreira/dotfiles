_nl_=$'\n'
_zsh_rc_dir_="$(readlink -m ${ZDOTDIR}/zshrc.d)"

[ -r "${ZDOTDIR}/zshrc" ] && . "${ZDOTDIR}/zshrc"

if [ -d "${_zsh_rc_dir_}" ]; then

  for _src_ in "${_zsh_rc_dir_}"/*.zsh; do
    [ -r "${_src_}" ] && . "${_src_}"
  done

  unset src
fi

unset _zsh_rc_dir_
unset _nl_
