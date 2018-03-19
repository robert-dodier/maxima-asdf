(defsystem info-index
  :name "info-index"
  :maintainer "Robert Dodier"
  :author "Robert Dodier"
  :license "GPL"
  :description "Define :info-index for ASDF"
  :long-description "Define :info-index for ASDF.
:info-index components are Maxima documentation index files.
Any system using :info-index components should :defsystem-depends-on '(\"info-index\")"

  :components ((:file "info-index")))

