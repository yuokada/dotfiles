# 実用 **コンパクト版チートシート**

## 前提

* prefix：`Ctrl-b`（これを押してからコマンド）

---

## セッション操作

```
tmux new -s name      # 新規セッション
tmux ls               # 一覧
tmux attach -t name   # 再接続
Ctrl-b d              # デタッチ
tmux kill-session -t name
```

👉 セッションは再接続できるのが最大特徴 ([phoenixNAP | Global IT Services][1])

---

## ウィンドウ

```
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

```
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

```
Ctrl-b [   # copy mode
space      # 選択開始
Enter      # コピー
Ctrl-b ]   # ペースト
q          # 終了
```

👉 vim風操作が可能 ([Pluralsight][3])

---

## よく使う最小セット（これだけ覚えればOK）

```
Ctrl-b c   # window作成
Ctrl-b %   # 縦分割
Ctrl-b "   # 横分割
Ctrl-b ←→  # 移動
Ctrl-b d   # detach
tmux attach
```

---

## オンラインチートシート（見やすい）

* [tmux cheatsheet.com](https://tmuxcheatsheet.com/?utm_source=chatgpt.com)
* [Pluralsight cheat sheet](https://www.pluralsight.com/resources/blog/cloud/tmux-cheat-sheet?utm_source=chatgpt.com)


[1]: https://phoenixnap.com/kb/tmux-cheat-sheet?utm_source=chatgpt.com "tmux Cheat Sheet: Commands and Shortcuts Explained"
[2]: https://tmuxcheatsheet.com/?utm_source=chatgpt.com "Tmux Cheat Sheet & Quick Reference | Session, window ..."
[3]: https://www.pluralsight.com/resources/blog/cloud/tmux-cheat-sheet?utm_source=chatgpt.com "tmux Cheat Sheet | Session, Window & Pane Shortcuts"
