# dotfiles

macOS と Linux で使う個人用のシェル、Git、Vim、tmux 設定です。ランタイムと
CLI のバージョン管理には [mise](https://mise.jdx.dev/) を使用します。

## セットアップ

リポジトリを任意の場所へ clone し、リンク作成スクリプトを実行します。

```shell
git clone https://github.com/yuokada/dotfiles.git
cd dotfiles
./synlinks.sh
```

既存の dotfile は上書きしません。`not replaced` と表示されたファイルは内容を
確認し、必要なら手動で退避してから再実行してください。

macOS のパッケージは Homebrew Bundle で導入できます。

```shell
brew bundle --file homebrew/Brewfile
mise install
```

Prezto を使う場合は、先に公式リポジトリを clone します。

```shell
git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
```

Prezto がなくても Zsh の補完、履歴、mise は利用できます。

## 構成

- `zsh/`: Zsh と Prezto の設定
- `git/`: Git 設定とグローバル ignore
- `vim/`: プラグインに依存しない Vim 設定
- `.tmux.conf`: tmux 3.6a 以降向け設定
- `homebrew/`: Apple Silicon 用と旧 Intel Mac 用の Brewfile
- `mise.toml`: CLI とランタイムのバージョン
- `old/`: 参照用に残した旧設定（インストール対象外）

tmux の操作は [tmux.md](tmux.md) を参照してください。TPM のプラグインは tmux
内で `prefix + I` を押すと導入できます。

## 検証

```shell
pre-commit run --all-files
mise run ci
```

GitHub Actions でも Markdown、シェル構文、設定ファイル、mise 管理ツールを検証します。
