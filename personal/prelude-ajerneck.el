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

(provide 'prelude-ajerneck)

;;; prelude-ajerneck.el ends here
