(defsystem maxima-asdf
  :name "maxima-asdf"
  :defsystem-depends-on ("drakma")
  :maintainer "Robert Dodier"
  :author "Robert Dodier"
  :licence "GPL"
  :description "Define :maxima-asdf for ASDF"
  :long-description "Define :maxima-asdf ASDF."
  :components ((:file "maxima-asdf")
               (:file "maxima-quicklisp")))
