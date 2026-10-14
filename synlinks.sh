#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
readonly repo_dir

links=(
  "zsh/.zshenv:.zshenv"
  "zsh/.zshrc:.zshrc"
  "zsh/.zpreztorc:.zpreztorc"
  "git/.gitconfig:.gitconfig"
  "git/.gitignore_global:.gitignore_global"
  ".tmux.conf:.tmux.conf"
  "vim/.vimrc:.vimrc"
  "vim/.gvimrc:.gvimrc"
)

status=0
for link in "${links[@]}"; do
  source_path="${repo_dir}/${link%%:*}"
  target_path="${HOME}/${link#*:}"

  if [[ -L "${target_path}" && "$(readlink "${target_path}")" == "${source_path}" ]]; then
    printf 'already linked: %s\n' "${target_path}"
    continue
  fi

  if [[ -e "${target_path}" || -L "${target_path}" ]]; then
    printf 'not replaced: %s already exists\n' "${target_path}" >&2
    status=1
    continue
  fi

  ln -s "${source_path}" "${target_path}"
  printf 'linked: %s -> %s\n' "${target_path}" "${source_path}"
done

exit "${status}"
