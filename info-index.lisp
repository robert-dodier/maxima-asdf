;; info-index.lisp -- ASDF component type for Maxima documentation index
;; copyright 2018 by Robert Dodier
;; I release this work under terms of the GNU General Public License

(require 'asdf)
(require 'uiop)

(in-package :asdf)

(defclass info-index (cl-source-file)
  ((type :initform "lisp"))) ;; ISN'T THIS INHERITED FROM CL-SOURCE-FILE ??

(defmethod perform ((o compile-op) (c info-index))
  (let*
    ((system-name (component-name (component-system c)))
     (info-name (make-pathname :name system-name :type "info"))
     (info-in-file (merge-pathnames info-name (first (input-files o c))))
     (info-out-file (merge-pathnames info-name (first (output-files o c)))))
    (unless (uiop:pathname-equal info-in-file info-out-file) ;; silently refuse to copy file to itself
      (uiop:copy-file info-in-file info-out-file))
    (call-next-method)))
