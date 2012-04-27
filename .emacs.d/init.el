;;C:\meadow\.emacs.d\init.el or $HOME/.emacs
;;
;; 日本語環境の設定
;;
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
;;buffer-file-coding-system
(setq buffer-file-coding-system 'utf-8)
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

;; 行番号を常に表示する
(global-linum-mode t)

;; 現在行に色をつける
(global-hl-line-mode 1)

;; ファイル内のカーソール位置を記憶させる
(setq-default save-place t)
(require 'saveplace)

;; 色
;;(set-face-background 'hl-line "darkolivegreen")

;; 対応するカッコを表示させる
(show-paren-mode 1)

;; モードラインに時刻を表示させる
(display-time)
;; 行番号・桁番号の設定
(line-number-mode t)
(column-number-mode t)

;; リージョンに色をつける
(transient-mark-mode 1)

;; GCを減らして軽くする デフォルトの10倍
(setq  gc-cons-threshold (* 10 gc-cons-threshold))

;;; ログの記録行数を増やす
(setq message-log-max 10000)
;;; 履歴を100まで保存する
(setq history-length 1000)

;;; yes と入力するのは面倒なのでyでokにする
;;(defalias 'yes-or-no-p 'y-or-no-p)

;; M-x install-elisp-from-emacswiki auto-async-byte-compile.el
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/tmp/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;; auto-install
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install"))
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
;; 起動時にEmacsWikiのページ名を補完候補に加える
(auto-install-update-emacswiki-package-name t)
;; install-elisp.el互換モードにする
(auto-install-compatibility-setup)
;; ediff関連のバッファを1つのフレームにまとめる
;;(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; package.elの設定
(when
  (require 'package nil t)
  (add-to-list 'package-archives
        '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("ELPA". "http://tromey.com/elpa/"))
  (package-initialize)
  )
;; Fileメニューに履歴表示
(require 'recentf)
(setq recentf-auto-cleanup 'never)
(recentf-mode 1)

;;(auto-insert-mode)
;;(setq auto-insert-directory "~/.emacs.d/auto-insert/" )
(define-auto-insert "\\.py" "template.py" )

;; 矩形選択を簡単に
(cua-mode t)
;;(setq cua-enable-cua-keys nil) ;; 変なキーバインド禁止

;; 入力されるキーシーケンスを置き換える
;; ?\C-? はDELのキーシーケンス
(keyboard-translate ?\C-h ?\C-?)

;; color-themeの設定
(when (require 'color-theme nil t)
    ;;(color-theme-initialize)
    (color-theme-hober)
    )

;; オートセーブファイル・バックアップファイルの設定
;; バックアップファイル作成場所をシステムのTempディレクトリに変更する
(setq backup-directory-alist
 `((".*" , temporary-file-directory)))
;; オートセーブファイル作成場所をシステムのTempディレクトリに変更する
(setq auto-save-file-name-transforms
 `((".*" , temporary-file-directory t)))

(add-to-list 'backup-directory-alist
 (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
 `(("." ,(expand-file-name "~/.emacs.d/backups/") t)))

;; オートセーブファイル作成までの秒間隔
(setq auto-save-timeout 15)
;; オートセーブファイル作成までのタイプ間隔
(setq auto-save-interval 120)

;; P213 view-mode
(setq view-read-only t)
;;(require 'key-chord)
;;(setq key-chord-two-keys-delay 0.04)
;;;; kj同時押しでview-mode切り替え
;;(key-chord-define-global "kj" 'view-mode)

;;(when (require 'viewer nil t)
  ;;(viewer-stay-in-setup)
;;  )

;;(when (require 'redo+ nil t)
;; ;; C-' にredoを割り当てる
;; (global-set-key (kbd "C-.") 'redo ))

;; Original http://Oxcc.net/misc/auto-save/auto-save-buffer.el
;;(require 'auto-save-buffers)
;;(run-with-idle-timer 5 t 'auto-save-buffers)

;; python の設定
;; (add-hook 'python-mode-hook '(lambda () (font-lock-mode 1)))
;; (autoload 'python-mode "python-mode"
;; "Major mode for editing Python programs" t)
;; (setq auto-mode-alist
;;(cons (cons "\\.py$" 'python-mode) auto-mode-alist))

