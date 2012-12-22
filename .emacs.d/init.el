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
;;(add-to-list 'load-path "~/.emacs.d/")


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

;; M-x install-elisp-from-emacswiki auto-async-byte-compile.el
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/tmp/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)


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

;; 矩形選択を簡単に
(cua-mode t)
(setq cua-enable-cua-keys nil) ;; 変なキーバインド禁止

;; 入力されるキーシーケンスを置き換える
;; ?\C-? はDELのキーシーケンス
(keyboard-translate ?\C-h ?\C-?)

;; color-themeの設定
(add-to-list 'load-path (expand-file-name "~/.emacs.d/packages/color-theme-6.6.0/"))
(when (require 'color-theme nil t)
   (color-theme-initialize)
   (color-theme-hober)
   (require 'color-theme-tango) 
   ;;(color-theme-tango)
   (require 'color-theme-solarized)
   ;;(color-theme-solarized-light)
)

;;(require 'color-theme-solarized) 

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
(setq auto-save-timeout 120)
;; オートセーブファイル作成までのタイプ間隔
(setq auto-save-interval 1024)

;; P213 view-mode
(setq view-read-only t)
;;(require 'key-chord)
;;(setq key-chord-two-keys-delay 0.04)
;;;; kj同時押しでview-mode切り替え
;;(key-chord-define-global "kj" 'view-mode)

;;(when (require 'viewer nil t)
  ;;(viewer-stay-in-setup)
;;  )

(when (require 'redo+ nil t)
;; C-' にredoを割り当てる
 (global-set-key (kbd "C-.") 'redo )
 (setq undo-limit 60000)
 (setq undo-strong-limit 900000)
 )


;; Original http://Oxcc.net/misc/auto-save/auto-save-buffer.el
;;(require 'auto-save-buffers)
;;(run-with-idle-timer 5 t 'auto-save-buffers)

;; python の設定
;; (add-hook 'python-mode-hook '(lambda () (font-lock-mode 1)))
(when (require 'python-mode nil t)
  (autoload 'python-mode "python-mode"))

;; "Major mode for editing Python programs" t)
;; (setq auto-mode-alist
;;(cons (cons "\\.py$" 'python-mode) auto-mode-alist))


;; anything
;; (auto-install-batch "anything")
(when (require 'anything nil t)
 (require 'anything-startup nil t)
 (require 'anything-match-plugin nil t)
 (require 'anything-show-completion nil t)

 (setq
  ;;
  anything-idle-delay 0.3
  anything-input-idle-delay 0.2
  anything-candidate-number-limit 100
  anything-quick-update t
  anything-enable-shortcuts 'alphabet)
  (when (require 'anything-config nil t)
    (setq anything-su-or-sudo "sudo"))
  (when (require 'anything-complete nil t)
    ;; lispシンボルの補完候補の再検索時間
    (anything-lisp-complete-symbol-set-timer 150))

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t )
    ;; describe-bindingsをAnythingに置き換える
    (descbinds-anything-install))
)

;; auto complete mode
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
    "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default)
  (setq ac-auto-start 3)
)


;;recentf.el
(when (require 'recentf-ext nil t)
  ;; 最近使ったファイルに加えないファイルをせいk表現で指定する
  (setq recentf-exclude '("/TAGS$" "/var/tmp/" "/tmp/") ))

;; tempfbuf.el
(when (require 'tempbuf nil t)
  (add-hook 'find-file-hooks 'turn-on-tempbuf-mode)
  (add-hook 'dired-mode-hook 'turn-on-tempbuf-mode))

;; wdired.el
(when (require 'wdired nil t)
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
  (global-set-key "\C-x\C-d" 'dired))
;; undo-tree
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;;C-m にnew-line-and-indent を割り当て
(global-set-key (kbd "C-m") 'newline-and-indent)

;; git 周りの設定
(when (executable-find "git")
  (require 'egg nil t))

;; Anything-c-moccurの設定
(when (require 'color-moccur nil t)
  )
(when (require 'anything-c-moccur nil t)
  (setq anything-c-moccur-anything-idle-delay 0.2
       ;`anything-idle-delay'
       anything-c-moccur-higligt-info-line-flag t
       ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
       anything-c-moccur-enable-auto-look-flag t
       ; 現在選択中の候補の位置を他のwindowに表示する
       anything-c-moccur-enable-initial-pattern t)
       ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする
  (global-set-key (kbd "C-M-o") 'anything-c-moccur-by-moccur))

;; wgrep
(when (require 'wgrep nil t))
;; undohist
(when (require 'undohist nil t )
  (undohist-initialize))
;; anthy
;;(load-library "anthy")

;; (auto-install-batch "sequential-command")
(when (require 'sequential-command-config) nil t
  (sequential-command-setup-keys))

;;reST Text
(when (require 'rst nil t)
  (setq auto-mode-alist
    (append '(("\\.rst$" . rst-mode)
	  ("\\.rest$" . rst-mode)) auto-mode-alist))
  ;; 背景が黒い場合はこうしないと見出しが見づらい
  (setq frame-background-mode 'dark)
  ;; 全部スペースでインデントしましょう
  (add-hook 'rst-mode-hook '(lambda() (setq indent-tabs-mode nil)))
)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(rst-level-face-base-light 50))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(rst-level-1-face ((t (:background "green" :foreground "LightSkyBlue"))) t)
 '(rst-level-2-face ((t (:background "green" :foreground "LightGoldenrod"))) t)
 '(rst-level-3-face ((t (:foreground "Cyan1"))) t)
 '(rst-level-4-face ((t (:foreground "chocolate1"))) t)
 '(rst-level-5-face ((t (:foreground "PaleGreen"))) t)
 '(rst-level-6-face ((t (:foreground "Aquamarine"))) t))



(put 'set-goal-column 'disabled nil)

;;auto-completeの設定のあとに書く
(when (require 'ac-python) nil t)
;; この設定しないとpython-modeで自動的にauto-completeが起動しない
(add-to-list 'ac-modes 'python-2-mode)
;;(require 'color-theme-solarized)