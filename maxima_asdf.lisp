;; maxima_asdf.lisp -- ASDF glue code for Maxima
;; copyright 2015 by Robert Dodier
;; I release this work under terms of the GNU General Public License

(require 'asdf)

(in-package :maxima)

(defun $asdf_load (name)
  (asdf:load-system name))

(defun $asdf_compile (name)
  (asdf:compile-system name))

(defun $asdf_load_source (name)
  (asdf:oos 'asdf:load-source-op name))
