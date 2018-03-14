;; maxima-quicklisp.lisp -- glue code for Maxima + Quicklisp
;; copyright 2016 by Robert Dodier
;; I release this work under terms of the GNU GPL version 2

;; I'd rather do (require 'drakma) here ... oh well.
(if (not (gethash "drakma" asdf::*defined-systems*))
  (ql:quickload :drakma))

;; install_github -- download a tarball from Github and unpack it into quicklisp/local-projects/.
;; Append the top-level project directory to various Maxima search paths.
;; Return a Maxima list comprising the path to the tar.gz and the unpacked top-level directory.

(defun $install_github (user-string project-string ref-string)
  (let*
    ((url-string (concatenate 'string "https://github.com"
                                      "/" user-string
                                      "/" project-string
                                      "/tarball/" ref-string))
     (request-results (multiple-value-list (drakma:http-request url-string :connection-timeout nil)))
     (http-status (second request-results))
     (ql-home (format nil "~a" ql:*quicklisp-home*))
     (tar-filename (concatenate 'string ql-home "dists/quicklisp/archives/" project-string "-" ref-string))
     (tar.gz-filename (concatenate 'string tar-filename ".gz")))
    (if (= 200 http-status)
	(let ((tar.gz-bytes (first request-results)))
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
	     (list '(mlist) tar.gz-filename package-toplevel-path))))
	(merror (format nil "~a: ~a" http-status (seventh request-results))))))
