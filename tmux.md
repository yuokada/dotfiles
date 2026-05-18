# 実用 **コンパクト版チートシート**

## 前提

* prefix：`Ctrl-b`（これを押してからコマンド）

---

## セッション操作

```shell
tmux new -s name      # 新規セッション
tmux ls               # 一覧
tmux attach -t name   # 再接続
Ctrl-b d              # デタッチ
tmux kill-session -t name
```

👉 セッションは再接続できるのが最大特徴 ([phoenixNAP | Global IT Services][1])

---

## セッション保存・復元

```text
Ctrl-b S   # 手動保存（tmux-resurrect）
Ctrl-b R   # 復元（tmux-resurrect）
```

```text
tmux-continuum:
- 60分ごとに自動保存
- 起動時に自動復元（有効化済み）
```

👉 この設定は `tmux-resurrect` + `tmux-continuum` 前提（導入は README 参照）

---

## ウィンドウ

```text
Ctrl-b c   # 新規
Ctrl-b n   # 次
Ctrl-b p   # 前
Ctrl-b w   # 一覧
Ctrl-b ,   # 名前変更
Ctrl-b &   # 削除
```

👉 タブ的な概念 ([Tmux Cheat Sheet][2])

---

## ペイン（分割）

```text
Ctrl-b %   # 垂直分割
Ctrl-b "   # 水平分割
Ctrl-b ↑↓←→  # 移動
Ctrl-b o   # 次のペイン
Ctrl-b z   # 最大化
Ctrl-b x   # 閉じる
```

👉 ペイン分割がtmuxのコア機能 ([Pluralsight][3])

---

## コピー / スクロール

```text
Ctrl-b [   # copy mode
space      # 選択開始
Enter      # コピー
Ctrl-b ]   # ペースト
q          # 終了
```

👉 vim風操作が可能 ([Pluralsight][3])

---

## よく使う最小セット（これだけ覚えればOK）

```text
Ctrl-b c   # window作成
Ctrl-b %   # 縦分割
Ctrl-b "   # 横分割
Ctrl-b ←→  # 移動
Ctrl-b d   # detach
tmux attach
```

---

## オンラインチートシート（見やすい）

* [tmux cheatsheet.com](https://tmuxcheatsheet.com/)
* [Pluralsight cheat sheet](https://www.pluralsight.com/resources/blog/cloud/tmux-cheat-sheet)

---

## FAQ（セッション保存・復元）

### Q. 再起動後でも復元できる？

はい。`@continuum-restore 'on'` が有効なら、再起動後に `tmux` 起動時に復元されます。
手動復元は `Ctrl-b R` です。

### Q. 複数セッションを保存できる？

はい。tmux サーバー上の複数セッションをまとめて保存・復元できます。

### Q. 保存済みセッション一覧はどう見る？

```shell
ls -1 ~/.tmux/resurrect/
ls -lt ~/.tmux/resurrect/*.txt
grep '^session' ~/.tmux/resurrect/last | awk '{print $2}'
```

### Q. 復元するセッションを指定できる？

標準の `tmux-resurrect` では、保存状態全体の復元が基本です（セッション単位の選択復元は非対応）。

実用上の回避策:

1. 全体復元後に不要セッションを削除
2. 復元前に `~/.tmux/resurrect/last`（または対象スナップショット）を編集して復元

[1]: https://phoenixnap.com/kb/tmux-cheat-sheet "tmux Cheat Sheet: Commands and Shortcuts Explained"
[2]: https://tmuxcheatsheet.com/ "Tmux Cheat Sheet & Quick Reference | Session, window ..."
[3]: https://www.pluralsight.com/resources/blog/cloud/tmux-cheat-sheet "tmux Cheat Sheet | Session, Window & Pane Shortcuts"
