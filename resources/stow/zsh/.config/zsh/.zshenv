_zsh_env_dir_="$(readlink -m ${ZDOTDIR}/zshenv.d/)"

[ -r "${ZDOTDIR}/zshenv" ] && . "${ZDOTDIR}/zshenv"

if [ -d "${_zsh_env_dir_}" ]; then

  for _src_ in "${_zsh_env_dir_}"/*.zsh; do
    [ -r "${_src_}" ] && . "${_src_}"
  done

  unset _src_
fi

unset _zsh_env_dir_
