;; info-index.lisp -- ASDF component type for Maxima documentation index
;; copyright 2018 by Robert Dodier
;; I release this work under terms of the GNU General Public License

(require 'asdf)

(in-package :asdf)

(defclass info-index (cl-source-file)
  ((type :initform "lisp"))) ;; ISN'T THIS INHERITED FROM CL-SOURCE-FILE ??

(defmethod perform ((o load-source-op) (c info-index))
  (call-next-method))

(defmethod perform ((o load-op) (c info-index))
  (call-next-method))

(defmethod input-files ((o compile-op) (c info-index))
  (let*
    ((foo (call-next-method))
     ;; WHY DOESN'T THE FOLLOWING LINE WORK ??
     ;; (bar (info-index-type c))
     (bar "lisp")
     (baz (merge-pathnames (make-pathname :type bar) (first foo))))
    (list baz)))

(defmethod output-files ((o compile-op) (c info-index))
  (call-next-method))

(defun silly-copy (in-file out-file)
  (unless (equalp in-file out-file) ;; silently refuse to copy file to itself
    (with-open-file (in in-file)
      (with-open-file (out out-file :direction :output :if-exists :supersede)
        (do ((c (read-char in nil) (read-char in nil))) ((null c))
          (write-char c out))))))

(defmethod perform ((o compile-op) (c info-index))
  (let*
    ((system-name (component-name (component-system c)))
     (info-name (make-pathname :name system-name :type "info"))
     (info-in-file (merge-pathnames info-name (first (input-files o c))))
     (info-out-file (merge-pathnames info-name (first (output-files o c)))))
    (silly-copy info-in-file info-out-file)
    (call-next-method)))
