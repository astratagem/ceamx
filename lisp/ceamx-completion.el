;;; ceamx-completion.el --- ceamx :: lib :: completion  -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Chris Montgomery

;; Author: Chris Montgomery <chmont@protonmail.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Helper functions for completion.

;;; Code:

;; via <https://github.com/minad/consult?tab=readme-ov-file#help>
;;;###autoload
(defun ceamx/emacs-info ()
  "Search through common Emacs info pages."
  (interactive)
  (consult-info "emacs" "efaq" "elisp" "cl"))

;;;###autoload
(defun ceamx/org-info ()
  "Search through the Org-Mode info page."
  (interactive)
  (consult-info "org"))

;;;###autoload
(defun ceamx/completion-info ()
  "Search through completion info pages."
  (interactive)
  (consult-info "vertico" "consult" "marginalia" "orderless" "embark"
                "corfu" "cape" "tempel"))

;;;###autoload
(defun ceamx/consult-info-dwim (&optional buffer)
  "Search Info manuals appropriate to BUFFER's major-mode."
  (interactive)
  (with-current-buffer (or buffer (current-buffer))
    (let* ((mode major-mode)
           (fn (pcase mode
                 ((pred (lambda (x) (memq x '(emacs-lisp-mode))))
                  #'ceamx/emacs-info)
                 ((pred (lambda (x) (memq x '(org-mode org-agenda-mode))))
                  #'ceamx/org-info)
                 (_ #'consult-info))))
      (command-execute fn))))


(defun ceamx/embark-export-write ()
  "Export the current `vertico' candidates to a writable buffer.
Supported export flows include the following:

`consult-grep'      => `wgrep'
files               => `wdired'
`consult-location'  => `occur-edit'"
  (interactive)
  (require 'embark)
  (require 'wgrep)
  (let* ((edit-command
          (pcase-let ((`(,type . ,candidates)
                       (run-hook-with-args-until-success 'embark-candidate-collectors)))
            (pcase type
              ('consult-grep #'wgrep-change-to-wgrep-mode)
              ('file #'wdired-change-to-wdired-mode)
              ('consult-location #'occur-edit-mode)
              (x (user-error "Embark category %S doesn't support writable export" x)))))
         (embark-after-export-hook `(,@embark-after-export-hook ,edit-command)))
    (embark-export)))

(defun ceamx-completion--embark-display-actions-responsive (buffer alist)
  "Display Embark actions BUFFER in a side window.
Uses right side if frame is wide, top if narrow.
WIDTH-THRESHOLD defaults to 140 columns.
ALIST is passed through to `display-buffer-in-side-window'."
  (let* ((width-threshold 140)
         (wide-p (> (frame-width) width-threshold))
         (side (if wide-p 'right 'top))
         (size (if wide-p
                   '(window-width . 0.3)
                 '(window-height . 0.3))))
    (display-buffer-in-side-window
     buffer
     (append `((side . ,side) ,size (slot . 99)) alist))))

(provide 'ceamx-completion)
;;; ceamx-completion.el ends here
