;; maxima-quicklisp.lisp -- glue code for Maxima + Quicklisp
;; copyright 2016 by Robert Dodier
;; I release this work under terms of the GNU GPL version 2

;; install_github -- download a tarball from Github and unpack it into quicklisp/local-projects/.
;; Append the top-level project directory to various Maxima search paths.
;; Return a Maxima list comprising the path to the tar.gz and the unpacked top-level directory.

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
    (let ((local-projects-path (concatenate 'string ql-home "local-projects/")))
      (ql-minitar:unpack-tarball tar-filename :directory local-projects-path)
      ;; Assume here that Github tarballs always have a top-level directory,
      ;; and that top-level directory is the first item on the list of contents.
      (let*
        ((package-toplevel (first (ql-minitar::contents tar-filename)))
         (package-toplevel-path (concatenate 'string local-projects-path package-toplevel)))
        (append-to-maxima-paths package-toplevel-path)
        (delete-file tar-filename)
        (list '(mlist) tar.gz-filename package-toplevel-path)))))

(defmacro append-to-path (path-variable path item)
  `(setq ,path-variable (append ,path-variable (list (concatenate 'string ,path ,item)))))

(defun append-to-maxima-paths (p)
  (declare (special $file_search_demo $file_search_lisp $file_search_maxima $file_search_tests $file_search_usage))
  (append-to-path $file_search_demo p "$$$.{dem,demo}")
  (append-to-path $file_search_lisp p "$$$.lisp")
  (append-to-path $file_search_maxima p "$$$.mac")
  (append-to-path $file_search_tests p "$$$.mac")
  (append-to-path $file_search_usage p "$$$.{usg,txt}"))
