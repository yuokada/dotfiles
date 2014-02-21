;;; org-cua-dwim-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (org-cua-dwim-turn-on-org-cua-mode-partial-support)
;;;;;;  "org-cua-dwim" "org-cua-dwim.el" (21122 21637 0 0))
;;; Generated autoloads from org-cua-dwim.el

(autoload 'org-cua-dwim-turn-on-org-cua-mode-partial-support "org-cua-dwim" "\
This turns on org-mode cua-mode partial support; Assumes
shift-selection-mode is available.

\(fn)" t nil)

(add-hook 'org-mode-hook 'org-cua-dwim-turn-on-org-cua-mode-partial-support)

;;;***

;;;### (autoloads nil nil ("org-cua-dwim-pkg.el") (21122 21637 908781
;;;;;;  0))

;;;***

(provide 'org-cua-dwim-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; org-cua-dwim-autoloads.el ends here
