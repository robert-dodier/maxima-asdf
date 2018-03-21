;; info-index.lisp -- ASDF component type for Maxima documentation index
;; copyright 2018 by Robert Dodier
;; I release this work under terms of the GNU General Public License

(require 'asdf)
(require 'uiop)

(in-package :asdf)

(defclass info-index (cl-source-file) ())

;; An info index file is a Lisp source file, which is compiled
;; just the same as an ordinary Lisp file, with the additional
;; step of copying the .info to the same location to where the
;; compiler output will go.

(defmethod perform ((o compile-op) (c info-index))
  (let*
    ((system-name (component-name (component-system c)))
     (info-name (make-pathname :name system-name :type "info"))
     (info-in-file (merge-pathnames info-name (first (input-files o c))))
     (info-out-file (merge-pathnames info-name (first (output-files o c)))))
    ;; INFO-IN-FILE and INFO-OUT-FILE should be different,
    ;; but just to be safe, silently refuse to copy file to itself.
    (unless (uiop:pathname-equal info-in-file info-out-file)
      (uiop:copy-file info-in-file info-out-file))
    (call-next-method)))
