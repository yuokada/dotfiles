
((digest . "75e816a14fa1440c3fa7634dd2598def") (undo-list nil ("	" . 422) (#("    " 0 4 (fontified t face font-lock-string-face)) . 373) (423 . 424) nil (419 . 423) nil (apply yas/snippet-revive 323 420 [cl-struct-yas/snippet ([cl-struct-yas/field 1 (327 . #<marker in no buffer>) (334 . #<marker in no buffer>) nil nil nil t [cl-struct-yas/field 2 (335 . #<marker in no buffer>) (339 . #<marker in no buffer>) nil ([cl-struct-yas/mirror (377 . #<marker in no buffer>) (414 . #<marker in no buffer>) "
      (let* 
        ((indent
            (concat \"\\n\" (make-string (current-column) 32)))
           (args
            (mapconcat
             '(lambda (x)
                (if (not (string= (nth 0 x) \"\"))
                    (concat \"- \" (char-to-string 96) (nth 0 x)
                            (char-to-string 96) \":\")))
             (mapcar
              '(lambda (x)
                 (mapcar
                  '(lambda (x)
                     (replace-regexp-in-string \"[[:blank:]]*$\" \"\"
                      (replace-regexp-in-string \"^[[:blank:]]*\" \"\" x)))
                  x))
              (mapcar '(lambda (x) (split-string x \"=\"))
                      (split-string text \",\")))
             indent)))
      (if (string= args \"\")
          (make-string 3 34)
        (mapconcat
         'identity
         (list \"\" \"Arguments:\" args (make-string 3 34))
         indent)))
    " [cl-struct-yas/exit (419 . #<marker in no buffer>) nil]]) nil t [cl-struct-yas/field 3 (349 . #<marker in no buffer>) (372 . #<marker in no buffer>) nil nil nil t [cl-struct-yas/mirror (377 . #<marker in no buffer>) (414 . #<marker in no buffer>) "
      (let* 
        ((indent
            (concat \"\\n\" (make-string (current-column) 32)))
           (args
            (mapconcat
             '(lambda (x)
                (if (not (string= (nth 0 x) \"\"))
                    (concat \"- \" (char-to-string 96) (nth 0 x)
                            (char-to-string 96) \":\")))
             (mapcar
              '(lambda (x)
                 (mapcar
                  '(lambda (x)
                     (replace-regexp-in-string \"[[:blank:]]*$\" \"\"
                      (replace-regexp-in-string \"^[[:blank:]]*\" \"\" x)))
                  x))
              (mapcar '(lambda (x) (split-string x \"=\"))
                      (split-string text \",\")))
             indent)))
      (if (string= args \"\")
          (make-string 3 34)
        (mapconcat
         'identity
         (list \"\" \"Arguments:\" args (make-string 3 34))
         indent)))
    " [cl-struct-yas/exit (419 . #<marker in no buffer>) nil]]]]] [cl-struct-yas/field 2 (335 . #<marker in no buffer>) (339 . #<marker in no buffer>) nil ([cl-struct-yas/mirror (377 . #<marker in no buffer>) (414 . #<marker in no buffer>) "
      (let* 
        ((indent
            (concat \"\\n\" (make-string (current-column) 32)))
           (args
            (mapconcat
             '(lambda (x)
                (if (not (string= (nth 0 x) \"\"))
                    (concat \"- \" (char-to-string 96) (nth 0 x)
                            (char-to-string 96) \":\")))
             (mapcar
              '(lambda (x)
                 (mapcar
                  '(lambda (x)
                     (replace-regexp-in-string \"[[:blank:]]*$\" \"\"
                      (replace-regexp-in-string \"^[[:blank:]]*\" \"\" x)))
                  x))
              (mapcar '(lambda (x) (split-string x \"=\"))
                      (split-string text \",\")))
             indent)))
      (if (string= args \"\")
          (make-string 3 34)
        (mapconcat
         'identity
         (list \"\" \"Arguments:\" args (make-string 3 34))
         indent)))
    " [cl-struct-yas/exit (419 . #<marker in no buffer>) nil]]) nil t [cl-struct-yas/field 3 (349 . #<marker in no buffer>) (372 . #<marker in no buffer>) nil nil nil t [cl-struct-yas/mirror (377 . #<marker in no buffer>) (414 . #<marker in no buffer>) "
      (let* 
        ((indent
            (concat \"\\n\" (make-string (current-column) 32)))
           (args
            (mapconcat
             '(lambda (x)
                (if (not (string= (nth 0 x) \"\"))
                    (concat \"- \" (char-to-string 96) (nth 0 x)
                            (char-to-string 96) \":\")))
             (mapcar
              '(lambda (x)
                 (mapcar
                  '(lambda (x)
                     (replace-regexp-in-string \"[[:blank:]]*$\" \"\"
                      (replace-regexp-in-string \"^[[:blank:]]*\" \"\" x)))
                  x))
              (mapcar '(lambda (x) (split-string x \"=\"))
                      (split-string text \",\")))
             indent)))
      (if (string= args \"\")
          (make-string 3 34)
        (mapconcat
         'identity
         (list \"\" \"Arguments:\" args (make-string 3 34))
         indent)))
    " [cl-struct-yas/exit (419 . #<marker in no buffer>) nil]]]] [cl-struct-yas/field 3 (349 . #<marker in no buffer>) (372 . #<marker in no buffer>) nil nil nil t [cl-struct-yas/mirror (377 . #<marker in no buffer>) (414 . #<marker in no buffer>) "
      (let* 
        ((indent
            (concat \"\\n\" (make-string (current-column) 32)))
           (args
            (mapconcat
             '(lambda (x)
                (if (not (string= (nth 0 x) \"\"))
                    (concat \"- \" (char-to-string 96) (nth 0 x)
                            (char-to-string 96) \":\")))
             (mapcar
              '(lambda (x)
                 (mapcar
                  '(lambda (x)
                     (replace-regexp-in-string \"[[:blank:]]*$\" \"\"
                      (replace-regexp-in-string \"^[[:blank:]]*\" \"\" x)))
                  x))
              (mapcar '(lambda (x) (split-string x \"=\"))
                      (split-string text \",\")))
             indent)))
      (if (string= args \"\")
          (make-string 3 34)
        (mapconcat
         'identity
         (list \"\" \"Arguments:\" args (make-string 3 34))
         indent)))
    " [cl-struct-yas/exit (419 . #<marker in no buffer>) nil]]]) [cl-struct-yas/exit (419 . #<marker in no buffer>) nil] 0 #<overlay in no buffer> [cl-struct-yas/field 3 (349 . #<marker in no buffer>) (372 . #<marker in no buffer>) nil nil nil t [cl-struct-yas/mirror (377 . #<marker in no buffer>) (414 . #<marker in no buffer>) "
      (let* 
        ((indent
            (concat \"\\n\" (make-string (current-column) 32)))
           (args
            (mapconcat
             '(lambda (x)
                (if (not (string= (nth 0 x) \"\"))
                    (concat \"- \" (char-to-string 96) (nth 0 x)
                            (char-to-string 96) \":\")))
             (mapcar
              '(lambda (x)
                 (mapcar
                  '(lambda (x)
                     (replace-regexp-in-string \"[[:blank:]]*$\" \"\"
                      (replace-regexp-in-string \"^[[:blank:]]*\" \"\" x)))
                  x))
              (mapcar '(lambda (x) (split-string x \"=\"))
                      (split-string text \",\")))
             indent)))
      (if (string= args \"\")
          (make-string 3 34)
        (mapconcat
         'identity
         (list \"\" \"Arguments:\" args (make-string 3 34))
         indent)))
    " [cl-struct-yas/exit (419 . #<marker in no buffer>) nil]]] nil nil]) nil (369 . 372) nil (349 . 369) nil (#("
    Arguments:
    - `hog`:
    \"\"\"" 0 23 (fontified t face font-lock-string-face) 23 24 (fontified t face font-lock-string-face) 24 26 (fontified t face font-lock-string-face) 26 35 (fontified t face font-lock-string-face) 35 36 (fontified t syntax-table (15) face font-lock-string-face)) . 391) ((marker . 411) . -16) ((marker . 411) . -16) ((marker . 420) . -1) ((marker . 420) . -1) ((marker) . -36) ((marker . 403) . -29) ((marker . 403) . -29) (354 . 391) (338 . 339) (#("
    Arguments:
    - `ho`:
    \"\"\"" 0 23 (fontified t face font-lock-string-face) 23 24 (fontified t face font-lock-string-face) 24 25 (fontified t face font-lock-string-face) 25 34 (fontified t face font-lock-string-face) 34 35 (fontified t syntax-table (15) face font-lock-string-face)) . 389) ((marker) . -35) ((marker . 403) . -28) ((marker . 403) . -28) ((marker . 389) . -16) ((marker . 389) . -16) ((marker . 374) . -1) ((marker . 374) . -1) (353 . 389) (337 . 338) (#("
    Arguments:
    - `h`:
    \"\"\"" 0 23 (fontified t face font-lock-string-face) 23 24 (fontified t face font-lock-string-face) 24 33 (fontified t face font-lock-string-face) 33 34 (fontified t syntax-table (15) face font-lock-string-face)) . 387) ((marker) . -34) ((marker) . -27) ((marker) . -27) ((marker) . -16) ((marker) . -16) ((marker) . -1) ((marker) . -1) (352 . 387) (336 . 337) (#("\"\"\"" 0 2 (fontified t face font-lock-string-face) 2 3 (fontified t syntax-table (15) face font-lock-string-face)) . 385) ((marker) . -3) (351 . 385) (335 . 336) nil (327 . 334) (#("name" 0 4 (fontified t face font-lock-function-name-face)) . 327) ((marker) . -4) nil (apply yas/take-care-of-redo 323 356 [cl-struct-yas/snippet ([cl-struct-yas/field 1 (327 . #<marker in no buffer>) (334 . #<marker in no buffer>) nil nil nil t [cl-struct-yas/field 2 (335 . #<marker in no buffer>) (339 . #<marker in no buffer>) nil ([cl-struct-yas/mirror (377 . #<marker in no buffer>) (414 . #<marker in no buffer>) "
      (let* 
        ((indent
            (concat \"\\n\" (make-string (current-column) 32)))
           (args
            (mapconcat
             '(lambda (x)
                (if (not (string= (nth 0 x) \"\"))
                    (concat \"- \" (char-to-string 96) (nth 0 x)
                            (char-to-string 96) \":\")))
             (mapcar
              '(lambda (x)
                 (mapcar
                  '(lambda (x)
                     (replace-regexp-in-string \"[[:blank:]]*$\" \"\"
                      (replace-regexp-in-string \"^[[:blank:]]*\" \"\" x)))
                  x))
              (mapcar '(lambda (x) (split-string x \"=\"))
                      (split-string text \",\")))
             indent)))
      (if (string= args \"\")
          (make-string 3 34)
        (mapconcat
         'identity
         (list \"\" \"Arguments:\" args (make-string 3 34))
         indent)))
    " [cl-struct-yas/exit (419 . #<marker in no buffer>) nil]]) nil t [cl-struct-yas/field 3 (349 . #<marker in no buffer>) (372 . #<marker in no buffer>) nil nil nil t [cl-struct-yas/mirror (377 . #<marker in no buffer>) (414 . #<marker in no buffer>) "
      (let* 
        ((indent
            (concat \"\\n\" (make-string (current-column) 32)))
           (args
            (mapconcat
             '(lambda (x)
                (if (not (string= (nth 0 x) \"\"))
                    (concat \"- \" (char-to-string 96) (nth 0 x)
                            (char-to-string 96) \":\")))
             (mapcar
              '(lambda (x)
                 (mapcar
                  '(lambda (x)
                     (replace-regexp-in-string \"[[:blank:]]*$\" \"\"
                      (replace-regexp-in-string \"^[[:blank:]]*\" \"\" x)))
                  x))
              (mapcar '(lambda (x) (split-string x \"=\"))
                      (split-string text \",\")))
             indent)))
      (if (string= args \"\")
          (make-string 3 34)
        (mapconcat
         'identity
         (list \"\" \"Arguments:\" args (make-string 3 34))
         indent)))
    " [cl-struct-yas/exit (419 . #<marker in no buffer>) nil]]]]] [cl-struct-yas/field 2 (335 . #<marker in no buffer>) (339 . #<marker in no buffer>) nil ([cl-struct-yas/mirror (377 . #<marker in no buffer>) (414 . #<marker in no buffer>) "
      (let* 
        ((indent
            (concat \"\\n\" (make-string (current-column) 32)))
           (args
            (mapconcat
             '(lambda (x)
                (if (not (string= (nth 0 x) \"\"))
                    (concat \"- \" (char-to-string 96) (nth 0 x)
                            (char-to-string 96) \":\")))
             (mapcar
              '(lambda (x)
                 (mapcar
                  '(lambda (x)
                     (replace-regexp-in-string \"[[:blank:]]*$\" \"\"
                      (replace-regexp-in-string \"^[[:blank:]]*\" \"\" x)))
                  x))
              (mapcar '(lambda (x) (split-string x \"=\"))
                      (split-string text \",\")))
             indent)))
      (if (string= args \"\")
          (make-string 3 34)
        (mapconcat
         'identity
         (list \"\" \"Arguments:\" args (make-string 3 34))
         indent)))
    " [cl-struct-yas/exit (419 . #<marker in no buffer>) nil]]) nil t [cl-struct-yas/field 3 (349 . #<marker in no buffer>) (372 . #<marker in no buffer>) nil nil nil t [cl-struct-yas/mirror (377 . #<marker in no buffer>) (414 . #<marker in no buffer>) "
      (let* 
        ((indent
            (concat \"\\n\" (make-string (current-column) 32)))
           (args
            (mapconcat
             '(lambda (x)
                (if (not (string= (nth 0 x) \"\"))
                    (concat \"- \" (char-to-string 96) (nth 0 x)
                            (char-to-string 96) \":\")))
             (mapcar
              '(lambda (x)
                 (mapcar
                  '(lambda (x)
                     (replace-regexp-in-string \"[[:blank:]]*$\" \"\"
                      (replace-regexp-in-string \"^[[:blank:]]*\" \"\" x)))
                  x))
              (mapcar '(lambda (x) (split-string x \"=\"))
                      (split-string text \",\")))
             indent)))
      (if (string= args \"\")
          (make-string 3 34)
        (mapconcat
         'identity
         (list \"\" \"Arguments:\" args (make-string 3 34))
         indent)))
    " [cl-struct-yas/exit (419 . #<marker in no buffer>) nil]]]] [cl-struct-yas/field 3 (349 . #<marker in no buffer>) (372 . #<marker in no buffer>) nil nil nil t [cl-struct-yas/mirror (377 . #<marker in no buffer>) (414 . #<marker in no buffer>) "
      (let* 
        ((indent
            (concat \"\\n\" (make-string (current-column) 32)))
           (args
            (mapconcat
             '(lambda (x)
                (if (not (string= (nth 0 x) \"\"))
                    (concat \"- \" (char-to-string 96) (nth 0 x)
                            (char-to-string 96) \":\")))
             (mapcar
              '(lambda (x)
                 (mapcar
                  '(lambda (x)
                     (replace-regexp-in-string \"[[:blank:]]*$\" \"\"
                      (replace-regexp-in-string \"^[[:blank:]]*\" \"\" x)))
                  x))
              (mapcar '(lambda (x) (split-string x \"=\"))
                      (split-string text \",\")))
             indent)))
      (if (string= args \"\")
          (make-string 3 34)
        (mapconcat
         'identity
         (list \"\" \"Arguments:\" args (make-string 3 34))
         indent)))
    " [cl-struct-yas/exit (419 . #<marker in no buffer>) nil]]]) [cl-struct-yas/exit (419 . #<marker in no buffer>) nil] 0 #<overlay in no buffer> [cl-struct-yas/field 3 (349 . #<marker in no buffer>) (372 . #<marker in no buffer>) nil nil nil t [cl-struct-yas/mirror (377 . #<marker in no buffer>) (414 . #<marker in no buffer>) "
      (let* 
        ((indent
            (concat \"\\n\" (make-string (current-column) 32)))
           (args
            (mapconcat
             '(lambda (x)
                (if (not (string= (nth 0 x) \"\"))
                    (concat \"- \" (char-to-string 96) (nth 0 x)
                            (char-to-string 96) \":\")))
             (mapcar
              '(lambda (x)
                 (mapcar
                  '(lambda (x)
                     (replace-regexp-in-string \"[[:blank:]]*$\" \"\"
                      (replace-regexp-in-string \"^[[:blank:]]*\" \"\" x)))
                  x))
              (mapcar '(lambda (x) (split-string x \"=\"))
                      (split-string text \",\")))
             indent)))
      (if (string= args \"\")
          (make-string 3 34)
        (mapconcat
         'identity
         (list \"\" \"Arguments:\" args (make-string 3 34))
         indent)))
    " [cl-struct-yas/exit (419 . #<marker in no buffer>) nil]]] nil nil]) (323 . 356) (#("def" 0 3 (fontified t face font-lock-keyword-face)) . 323) 326 ((marker . 420) . -3) nil (326 . 328) nil (#("
" 0 1 (fontified t)) . 326) ((marker) . -1) ((marker) . -1) ((marker) . -1) nil (323 . 326) nil (#("で" 0 1 (fontified t)) . -323) (323 . 324) (#("でｆ" 0 2 (fontified t)) . -323) (323 . 325) (#("で" 0 1 (fontified t)) . -323) (323 . 324) (#("ｄ" 0 1 (fontified t)) . -323) (322 . 324) (t 21085 32292 0 0) nil undo-tree-canary))
