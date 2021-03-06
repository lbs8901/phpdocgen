;;; phpdocgen.el --- PHP Documentor Generator

;; Copyright (C) 2016 Chaz

;; Author: Chaz <chazwize@gmail.com>
;; Keywords: php doc
;; Version: 0.0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This is php documentor block generator

;;; Code:

(defun phpdoc ()
  "print-the-php-documentor-block"
  (interactive) 
  (search-backward " function")
  (setq method-name (phpdoc-get-method-description))
  (setq params (phpdoc-get-params))
  (phpdoc-block-position)
  (setq inicio (point))
  (setq init-block-point (point))
  (phpdoc-start-line)
  (phpdoc-new-line method-name)
  (phpdoc-new-line)
  (phpdoc-insert-params params)
  (phpdoc-end-line)
  (indent-region inicio (point))
  (goto-char init-block-point)
  (message "PHPDocumentor block created")
)


(defun php-create-setter ()
  "create-the-setter-for-a-variable"
  (interactive) 
  (search-backward "$")
  (setq method-name (phpdoc-get-method-description))
  (setq params (phpdoc-get-params))
  (phpdoc-block-position)
  (setq inicio (point))
  (setq init-block-point (point))
  (phpdoc-start-line)
  (phpdoc-new-line method-name)
  (phpdoc-new-line)
  (phpdoc-insert-params params)
  (phpdoc-end-line)
  (indent-region inicio (point))
  (goto-char init-block-point)
  (message "PHPDocumentor block created")
)


(defun phpdoc-block-position ()
  (previous-line)(beginning-of-line)(newline)
)

(defun phpdoc-new-line (&optional phpdoc-data)
  (newline)
  (insert (concat "* " phpdoc-data))
)  

(defun phpdoc-end-line ()
  (newline)
  (insert "*/")
)

(defun phpdoc-start-line ()
    (insert "/**")
)

(defun phpdoc-get-method-description ()
  (right-word)
  (search-forward " ")
  (setq init-word (point))
  (right-word)
  (buffer-substring-no-properties init-word (point))
)

(defun phpdoc-get-variable-name ()
  (search-forward " ")
  (setq init-word (point))
  (right-word)
  (buffer-substring-no-properties init-word (point))
)


(defun phpdoc-insert-params (param-list)
  (if (> (length param-list) 0)
  (while param-list
    (phpdoc-new-line (concat "@param " (car param-list)))
    (setq param-list (cdr param-list))
   )
  )
)  

(defun phpdoc-get-params ()
  (search-forward "(")
  (setq init-word (point))
  (search-forward ")")
  (setq params (buffer-substring-no-properties init-word (point)))
  (replace-regexp-in-string " " "" (replace-regexp-in-string ")" "" (replace-regexp-in-string "$+" "" params)))
  (setq param-list (split-string (replace-regexp-in-string " " "" (replace-regexp-in-string ")" "" params)) ","))
)

(fset 'php-create-setter
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217848 115 97 backspace 101 97 114 tab 98 97 tab return 36 return right 67108896 C-right 134217847 134217790 134217848 115 101 97 114 tab 98 97 tab return 125 return return up return tab 112 117 98 99 108 105 backspace backspace backspace 108 105 99 32 102 117 110 99 105 backspace backspace 99 116 105 111 110 32 115 101 116 25 C-left 21 51 right 67108896 right 134217848 99 97 112 105 116 97 108 105 tab 45 114 101 103 tab return 5 40 36 25 41 32 123 return tab 36 116 104 105 115 45 62 25 32 61 32 36 25 59 return 125 return] 0 "%d")) arg)))
