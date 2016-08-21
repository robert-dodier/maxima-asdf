;; maxima-quicklisp.lisp -- glue code for Maxima + Quicklisp
;; copyright 2016 by Robert Dodier
;; I release this work under terms of the GNU GPL version 2

(defun $install_github (user-string project-string ref-string)
  (let*
    ((url-string (concatenate 'string "https://github.com"
                                      "/" user-string
                                      "/" project-string
                                      "/tarball/" ref-string))
     (ql-home (format nil "~a" ql:*quicklisp-home*))
     (tar.gz-bytes (drakma:http-request url-string :connection-timeout nil))
     (tar-filename (concatenate 'string ql-home "dists/quicklisp/archives/" project-string "-" ref-string))
     (tar.gz-filename (concatenate 'string tar-filename ".gz")))
    (with-open-file (f tar.gz-filename :direction :output :if-exists :supersede :element-type '(unsigned-byte 8))
      (write-sequence tar.gz-bytes f))
    (ql-gunzipper:gunzip tar.gz-filename tar-filename)
    (ql-minitar:unpack-tarball tar-filename :directory (concatenate 'string ql-home "local-projects/"))
    (delete-file tar-filename)))
