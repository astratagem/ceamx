;;; ceamx-vcs.el --- Ceamx -- Version Control        -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Chris Montgomery

;; Author: Chris Montgomery <chmont@protonmail.com>
;; Keywords: vc, local

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

;;

;;; Code:

(defun browse-at-remote--format-region-url-as-codeberg (repo-url location filename &optional linestart lineend)
  (cond
    ((and linestart lineend)
      (format "%s/src/%s/%s#L%d-L%d"
        repo-url location filename linestart lineend))
    (linestart
      (format "%s/src/%s/%s#L%d"
        repo-url location filename linestart))
    (t
      (format "%s/src/%s/%s"
        repo-url location filename))))

(defun browse-at-remote--format-commit-url-as-codeberg (repo-url commithash)
  (format "%s/commit/%s" repo-url commithash))

(provide 'ceamx-vcs)
;;; ceamx-vcs.el ends here
