;; maxima_asdf.lisp -- ASDF glue code for Maxima
;; copyright 2015 by Robert Dodier
;; I release this work under terms of the GNU General Public License

(require 'asdf)

(in-package :maxima)

(defmacro with-maxima-path-update (name &body body)
  (let ((source-topdir (gensym)))
    `(prog1
         (progn
           ,@body)
       (let ((,source-topdir (format nil "~a" (ql:where-is-system ,name))))
         (append-to-maxima-paths ,source-topdir)))))

(defun $asdf_load (name)
  (with-maxima-path-update name (asdf:load-system name)))

(defun $asdf_compile (name)
  (with-maxima-path-update name (asdf:compile-system name)))

(defmacro append-to-path (path-variable path item)
  `(let ((to-be-added (concatenate 'string ,path ,item)))
     (unless (member to-be-added (rest ,path-variable) :test #'string=)
       (setq ,path-variable (append ,path-variable (list to-be-added))))))

(defun append-to-maxima-paths (p)
  (declare (special $file_search_demo $file_search_lisp $file_search_maxima $file_search_tests $file_search_usage))
  (append-to-path $file_search_demo p "$$$.{dem,demo}")
  (append-to-path $file_search_lisp p "$$$.lisp")
  (append-to-path $file_search_maxima p "$$$.mac")
  (append-to-path $file_search_tests p "$$$.mac")
  (append-to-path $file_search_usage p "$$$.{usg,txt}"))

(defun $asdf_load_source (name)
  (with-maxima-path-update name (asdf:oos 'asdf:load-source-op name)))



