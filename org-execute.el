;;; org-execute.el - Automating recurrent jobs
;;
;; Copyright (C) 2015 Michael Strey
;;
;; Author: Michael Strey <strey@strey.biz>
;; Version: 0.1
;;
;; This file is not yet part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:

;; Pressing TAB on an agenda entry shall lead to the execution of
;; Babel code below the corresponding headline.  This allows
;; automating recurrent jobs, e.g. backups, updates, calls of
;; org-drill, reading news etc.

;; Requirements:
;; Somewhere in the buffer containing the appropriate heading must be a named
;; Babel block.  Belong the properties of the heading must be an entry
;; =:EXECUTE: name_of_source_block=.

;; Example:

;; *** TODO Drill
;; SCHEDULED: <2015-06-10 Mi .+1d>
;; :PROPERTIES:
;; :STYLE:    habit
;; :ID:       0a4dc8a2-2131-45d3-9f85-11034180bf69
;; :LAST_REPEAT: [2015-06-09 Di 16:19]
;; :EXECUTE:  drill
;; :END:
;; 
;; #+NAME: drill
;; #+begin_src emacs-lisp
;; (org-drill)
;; #+end_src

;; To install:
;; (require 'org-execute)
;;
;; 

(require 'org)

(defun org-execute-babel-below-heading ()
  "Execute a named Babel block that is indicated in a property with the key :EXECUTE:"
  (save-excursion
    (let* ((n (org-entry-get nil "EXECUTE"))
	   (a (org-babel-find-named-block n)))
      (when (and n a)
	  (goto-char a)
	  (org-babel-execute-maybe)))))

(add-hook 'org-agenda-after-show-hook 'org-execute-babel-below-heading)

(provide 'org-execute)
