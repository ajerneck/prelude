;;; prelude-ajerneck.el --- Emacs Prelude: My personal customizations.
;;
;; Copyright © 2014 Alexander Jerneck
;;
;; Author: Alexander Jerneck
;; URL: https://github.com/ajerneck/prelude.git
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; My personal customizations.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

;; Buffer numbering for easy navigation between buffers.
;; http://blog.binchen.org/posts/moving-focus-and-buffer-between-emacs-window.html
(require 'window-numbering)
;; highlight the window number in pink
(custom-set-faces '(window-numbering-face (( t (:foreground "DeepPink" :underline "DeepPink" :weight bold)))))
(window-numbering-mode 1)

;; Duplicate thing
;; duplicate line, region, etc.
;; prefix argument comments out.
(require 'duplicate-thing)
(global-set-key (kbd "M-c") 'duplicate-thing)

;; Helm customizations
;; http://tuhdo.github.io/helm-intro.html
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;; Magit keybindings
(global-set-key "\M-g\M-m" 'magit-status)

;; Org Mode customizations
(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "CURRENT(u!)" "WAIT(w@)" "SOMEDAY(y)" "|" "DONE(d!)" "CANCELLED(c@)")))

;; capture
(setq org-directory "~/start/admin/org")
(setq org-default-notes-file (concat org-directory "/inbox.org"))
(define-key global-map "\C-cc" 'org-capture)

;; agenda view to get an overview of all projects.
(setq org-agenda-custom-commands
      '(("p" tags-todo "TODO=\"NEXT\"project:current|TODO=\"STARTED\"project:current|TODO=\"WAIT\"project:current")))

;; remember templates
(setq org-capture-templates
      '(("t" "Task" entry (file+headline "~/start/admin/org/inbox.org" "Tasks")
         "* TODO %? %^G \n  %U\n%a")
        ("j" "Journal" entry (file+datetree "~/start/admin/org/journal.org")
         "* %U Journal Entry\n%?\n

** Goals for tomorrow
")

        ("r" "Resistance Planning" entry (file+datetree "~/start/admin/org/journal.org")
         "* %U Plan\n
        - [ ] 09:00
        - [ ]
        - [ ] 10:00
        - [ ]
        - [ ] 11:00
        - [ ]
        - [ ] 12:00
        - [ ]
        - [ ] 13:00
        - [ ]
        - [ ] 14:00
        - [ ]
        - [ ] 15:00
        - [ ]
        - [ ] 16:00
        - [ ]
        - [ ] 17:00
        - [ ]
        - [ ] 18:00
        - [ ]
        - [ ] 19:00
        - [ ]

*** Day Notes

")

        ("m" "Most important tasks" entry (file+datetree "~/start/admin/org/journal.org")
         "* %U Most important tasks:\n
** TODO Hard: %?\n
** Mosquito tasks\n
*** TODO \n
*** TODO \n
** TODO PM: \n
** TODO Habit: \n
* Day notes\n
* Goals for tomorrow\n
")

))

;; orgmode remember setup
; Targets include this file and any file contributing to the agenda -
                                        ; up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 4)
                                 (org-agenda-files :maxlevel . 4))))

;; turn on auto-fill-mode globally
;; (setq-default auto-fill-function 'do-auto-fill)

;; turn on reftex mode
(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'org-mode-hook 'turn-on-reftex)
;; specify the default bibliography, so reftex can find it.
;; http://orgmode.org/worg/org-faq.html#using-reftex-in-org-mode
(setq reftex-default-bibliography
      (quote
       ("/home/alexander/start/academic/lit/bibtex/master.bib")))
(define-key org-mode-map (kbd "C-c )") 'reftex-citation)

;; One sentence per line.
;; To adjust one sentence per line
;; http://luca.dealfaro.org/Emacs-fill-sentence-macro

(defun fill-sentence ()
  (interactive)
  (save-excursion
    (or (eq (point) (point-max)) (forward-char))
    (forward-sentence -1)
                                        ;(indent-relative)
    (let ((beg (point)))
      (forward-sentence)
      (fill-region-as-paragraph beg (point)))))
(global-set-key "\ej" 'fill-sentence)


;; Highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#585858")

;; Move buffers around easily using buf-move
;; http://www.johndcook.com/blog/2012/03/07/shuffling-emacs-windows/

(require 'buffer-move)
(global-set-key (kbd "C-x <up>")     'buf-move-up)
(global-set-key (kbd "C-x <down>")   'buf-move-down)
(global-set-key (kbd "C-x <left>")   'buf-move-left)
(global-set-key (kbd "C-x <right>")  'buf-move-right)

(add-hook 'org-mode-hook '(lambda ()
                            (local-set-key (kbd "C-x <up>")     'buf-move-up)
                            (local-set-key (kbd "C-x <down>")   'buf-move-down)
                            (local-set-key (kbd "C-x <left>")   'buf-move-left)
                            (local-set-key (kbd "C-x <right>")  'buf-move-right)
                            )
          )


;; Show current buffer filename
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name))
  (kill-new (file-truename buffer-file-name))
  )
(global-set-key "\C-cz" 'show-file-name)

;; Turn off smart underscore in ESS
(ess-toggle-underscore nil)

;; Activate polymodes
;; https://github.com/vspinu/polymode
(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

;; use cabal-repl with haskell mode.
(custom-set-variables
 '(haskell-process-type 'cabal-repl))


;; redefine the prefix key for flycheck, because the default clobbers
;; the org-time-stamp-inactive command.
(define-key flycheck-mode-map flycheck-keymap-prefix nil)
(setq flycheck-keymap-prefix (kbd "C-c f"))
(define-key flycheck-mode-map flycheck-keymap-prefix
  flycheck-command-map)



(provide 'prelude-ajerneck)

;;; prelude-ajerneck.el ends here
