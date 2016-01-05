;; maxima-file.lisp -- ASDF component type for Maxima
;; copyright 2015 by Robert Dodier
;; I release this work under terms of the GNU General Public License

(require 'asdf)

(in-package :asdf)

(defclass maxima-file (source-file)
  ((type :initform "mac")))

(defmethod perform ((o load-source-op) (c maxima-file))
  (let ((source-file (first (input-files o c))))
    (funcall (symbol-function (find-symbol "$LOAD" (find-package "MAXIMA"))) source-file)))

(defmethod perform ((o load-op) (c maxima-file))
  (let ((source-file (first (input-files o c))))
    (load source-file)))

(defmethod output-files ((o compile-op) (c maxima-file))
  (let
    ((maxima-version (concatenate 'string "maxima-" (symbol-value (find-symbol "*AUTOCONF-VERSION*" (find-package "MAXIMA")))))
     (system-name (component-name (component-system c)))
     (component-name (component-name c)))
    (list (make-pathname :directory (list :relative maxima-version system-name) :name component-name))))

(defmethod perform ((o compile-op) (c maxima-file))
  (let*
    ((source-file (first (input-files o c)))
     (output-file (first (output-files o c)))
     (x (funcall (symbol-function (find-symbol "$TRANSLATE_FILE" (find-package "MAXIMA"))) source-file output-file)))
    (compile-file* (third x))))

