(defparameter foo-toplevel *default-pathname-defaults*)

(defsystem foo :depends-on ("maxima")
  :defsystem-depends-on ("maxima-file")
  :name "foo"
  :version "2015.09.21"
  :maintainer "Robert Dodier"
  :author "Robert Dodier"
  :licence "GPL"
  :description "Foo, Bar, and Baz"
  :long-description "Apply Foo's algorithm to Bar, yielding Baz"
  :pathname "src"

  :components
    ((:maxima-file "foo1")
     (:maxima-file "foo2")
     (:file "bar1")))

