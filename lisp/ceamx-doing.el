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

(defun ceamx/quick-wins ()
  "Display low-effort next actions."
  (interactive)
  (org-gtd-view-show
    '( (name . "Quick Wins")
       (type . next-action)
       (effort . (< "15min")))))

(defun ceamx/focused-work ()
  "Display next action candidates for focused work."
  (interactive)
  (org-gtd-view-show
    '( (name . "Focus Work")
       (type . next-action)
       (priority . (>= B))
       (effort . (> "30min")))))

(defun ceamx/triage-needs-effort ()
  "Display next actions missing effort metadata."
  (interactive)
  (org-gtd-view-show
    '( (name . "Needs Effort Estimate")
       (type . next-action)
       (effort . nil))))

(defun ceamx/triage-needs-priority ()
  "Display next actions missing priority metadata."
  (interactive)
  (org-gtd-view-show
    '( (name . "Needs Priority")
       (type . next-action)
       (priority . nil))))

(defun ceamx/triage-in-progress ()
  "Display next actions that have been started but not finished.
Uses clocked status to determine progress."
  (interactive)
  (org-gtd-view-show
    '( (name . "In Progress")
       (type . next-action)
       (clocked . (> "0:00")))))

(defun ceamx/triage-not-started ()
  "Display next actions that have not been started.
Uses clocked status to determine progress."
  (interactive)
  (org-gtd-view-show
    '( (name . "Not Started")
       (type . next-action)
       (clocked . nil))))

(provide 'ceamx-doing)
;;; ceamx-doing.el ends here
