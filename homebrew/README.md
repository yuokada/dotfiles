# Homebrew packages

`Brewfile` は Apple Silicon と Intel Mac の両方で使用する、トップレベルの
パッケージ一覧です。推移的依存関係は Homebrew に解決させます。言語ランタイムと
Quarkus はリポジトリ直下の `mise.toml` で管理します。

## セットアップ

依存関係を確認し、不足しているものをインストールします。

```shell
brew bundle check --file=homebrew/Brewfile || \
  brew bundle install --file=homebrew/Brewfile
mise install
```

## パッケージの更新

Homebrew 自体と Brewfile に記載したパッケージを更新します。

```shell
brew update
brew outdated
brew bundle install --file=homebrew/Brewfile
brew cleanup
```

更新後は Brewfile と環境を検証します。

```shell
brew bundle check --file=homebrew/Brewfile
ruby -c homebrew/Brewfile
```

## Brewfile の変更

formula や cask は `brew bundle add` と `brew bundle remove` で変更できます。

```shell
brew bundle add --file=homebrew/Brewfile ripgrep
brew bundle add --cask --file=homebrew/Brewfile wezterm
brew bundle remove --file=homebrew/Brewfile ripgrep
brew bundle remove --cask --file=homebrew/Brewfile wezterm
```

コマンド実行後は、エントリを適切なセクションへ移動して並び順を整えます。
ランタイムやプロジェクトごとにバージョンを切り替えるツールは Brewfile ではなく
`mise.toml` に追加します。

## スナップショットの再生成

Brewfile は `brew bundle dump` で生成できます。現在のインストール状態と比較する場合は、
Brewfile を直接上書きせず、一時ファイルへ出力します。生成結果には推移的依存関係や、
一時的にインストールしたツールも含まれるため、差分から必要なトップレベルの項目だけを
取り込みます。

```shell
snapshot="$(mktemp)"
brew bundle dump --force --file="${snapshot}"
diff -u homebrew/Brewfile "${snapshot}"
```

不要なパッケージの候補は次のコマンドで確認できます。

```shell
brew bundle cleanup --file=homebrew/Brewfile
```

`--force` を付けると実際に削除され、Homebrew の trust 設定も Brewfile に合わせて
更新されます。出力を確認せずに実行しないでください。

## Intel Homebrew からの移行

旧 Intel Homebrew (`/usr/local`) が残っている Apple Silicon Mac では、削除前に
Intel 側の状態を一時ファイルへ保存できます。

```shell
arch -x86_64 /usr/local/bin/brew bundle dump \
  --force --file=/tmp/intel.Brewfile
```

必要なトップレベルの項目を `homebrew/Brewfile` に移し、Apple Silicon 側で
`brew bundle install` を実行してから旧環境を削除します。
