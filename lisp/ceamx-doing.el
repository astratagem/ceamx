;;; ceamx-doing.el --- Ceamx -- Doing                -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Chris Montgomery

;; Author: Chris Montgomery <chmont@protonmail.com>
;; Keywords: local

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

;;;; Org-GTD

;; - List of available filters :: https://github.com/Trevoke/org-gtd.el/blob/org-gtd-4/doc/org-gtd.org#available-filters

(defun ceamx/active-projects ()
  "Display all active Org-GTD projects."
  (interactive)
  (org-gtd-view-show
    '( (name . "Active Projects")
       (type . active-project))))

(defun ceamx/all-projects ()
  "Display all Org-GTD projects, including completed."
  (interactive)
  (org-gtd-view-show
    '( (name . "All Projects")
       (type . project))))

(defun ceamx/stuck-projects ()
  "Display Org-GTD projects that have work but no next actions."
  (interactive)
  (org-gtd-view-show
    '( (name . "Stuck Projects")
       (type . stuck-project))))

(defun ceamx/work-projects ()
  "Display active Org-GTD projects in the Work area of focus."
  (interactive)
  (org-gtd-view-show
    '( (name . "Work Projects")
       (type . active-project)
       (area-of-focus . "Work"))))

;; (defun ceamx/org-gtd-)

(provide 'ceamx-doing)
;;; ceamx-doing.el ends here
