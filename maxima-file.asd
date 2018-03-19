(defsystem maxima-file
  :name "maxima-file"
  :version "2015.09.21"
  :maintainer "Robert Dodier"
  :author "Robert Dodier"
  :licence "GPL"
  :description "Define :maxima-file for ASDF"
  :long-description "Define :maxima-file ASDF.
Any system using :maxima-file components should :defsystem-depends-on '(\"maxima-file\")"

  :components ((:file "maxima-file")))

