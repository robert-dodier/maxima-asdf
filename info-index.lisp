;; info-index.lisp -- ASDF component type for Maxima documentation index
;; copyright 2018 by Robert Dodier
;; I release this work under terms of the GNU General Public License

(require 'asdf)

(in-package :asdf)

(defclass info-index (cl-source-file)
  ((type :initform "lisp"))) ;; ISN'T THIS INHERITED FROM CL-SOURCE-FILE ??

(defmethod perform ((o load-source-op) (c info-index))
  (format t "HEY PERFORM LOAD-SOURCE-OP, C = ~S; PUNT~%" c)
  (call-next-method))

(defmethod perform ((o load-op) (c info-index))
  (format t "HEY PERFORM LOAD-OP, C = ~S; PUNT~%" c)
  (call-next-method))

(defmethod input-files ((o compile-op) (c info-index))
  (let*
    ((foo (call-next-method))
     ;; WHY DOESN'T THE FOLLOWING LINE WORK ??
     ;; (bar (info-index-type c))
     (bar "lisp")
     (baz (merge-pathnames (make-pathname :type bar) (first foo))))
    (format t "HEY INPUT-FILES COMPILE-OP, (COMPONENT-PATHNAME ~S) = ~S~%" c (component-pathname c))
    (format t "HEY INPUT-FILES COMPILE-OP, (CALL-NEXT-METHOD) => ~S~%" foo)
    (format t "HEY INPUT-FILES COMPILE-OP, RETURN (LIST ~S)~%" baz)
    (list baz)))

(defmethod output-files ((o compile-op) (c info-index))
  (format t "HEY OUTPUT-FILES COMPILE-OP, C = ~S; PUNT~%" c)
  (call-next-method))

(defun silly-copy (in-file out-file)
  (unless (equalp in-file out-file) ;; silently refuse to copy file to itself
    (with-open-file (in in-file)
      (with-open-file (out out-file :direction :output :if-exists :supersede)
        (do ((c (read-char in nil) (read-char in nil))) ((null c))
          (write-char c out))))))

(defmethod perform ((o compile-op) (c info-index))
  (format t "HEY PERFORM COMPILE-OP, O = ~S, C = ~S, (COMPONENT-SYSTEM C) = ~S, (COMPONENT-NAME (COMPONENT-SYSTEM C)) = ~S~%" o c (component-system c) (component-name (component-system c)))
  (format t "HEY PERFORM COMPILE-OP, (INPUT-FILES O C) = ~S~%" (input-files o c))
  (format t "HEY PERFORM COMPILE-OP, (OUTPUT-FILES O C) = ~S~%" (output-files o c))
  (let*
    ((system-name (component-name (component-system c)))
     (info-name (make-pathname :name system-name :type "info"))
     (info-in-file (merge-pathnames info-name (first (input-files o c))))
     (info-out-file (merge-pathnames info-name (first (output-files o c)))))
    (format t "HEY PERFORM COMPILE-OP, COPY ~S TO ~S~%" info-in-file info-out-file)
    (silly-copy info-in-file info-out-file)
    (call-next-method)))

