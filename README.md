# dotfiles

.vimrc, zshrc , init.el and etc

## Prezto

https://github.com/sorin-ionescu/prezto

- http://oinume.hatenablog.com/entry/improve-my-terminal-with-zsh-prezto
- http://oinume.hatenablog.com/entry/improve-my-terminal-with-tmux
- http://qiita.com/iri/items/2f9a39b9c47320f4c225

## Tmux

Requires tmux >= 3.2 (recommended: 3.6a+)

- Prefix key in this repo: `C-b` (tmux default)
- Plugin manager: `tpm`
- Session restore: `tmux-resurrect` + `tmux-continuum`
- `tmuxinator` configs were removed from this repository

### Key bindings references

- tmux wiki: https://github.com/tmux/tmux/wiki
- tmux manual (key bindings): https://man7.org/linux/man-pages/man1/tmux.1.html

### Update tmux plugins

Inside tmux:

- `prefix + I`: install missing plugins
- `prefix + U`: update installed plugins

From shell:

```bash
~/.tmux/plugins/tpm/bin/update_plugins all
```

see also: [rothgar/awesome\-tmux: A list of awesome resources for tmux](https://github.com/rothgar/awesome-tmux)
