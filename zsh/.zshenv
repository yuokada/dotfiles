# Keep PATH setup available to login, interactive, and non-interactive shells.
typeset -U path PATH
path=(
  "${HOME}/bin"
  "${HOME}/.local/bin"
  "${HOME}/.local/share/mise/shims"
  "${path[@]}"
)
