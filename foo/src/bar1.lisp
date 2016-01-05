(format t "HELLO FROM BAR1.LISP; *DEFAULT-PATHNAME-DEFAULTS*=~S~%" *default-pathname-defaults*)
(defun maxima::$mybar1 (x) (maxima::m* x x))
(defun maxima::$mybar2 () asdf::foo-toplevel)
