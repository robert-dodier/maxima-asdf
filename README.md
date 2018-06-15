## What's the point of this?

The point is that with this stuff, ASDF can load system
definitions which contain Maxima files. Maxima is called to
load or compile and load Maxima files. There is also code
to download tar.gz files from Github and install them into
Quicklisp, which makes them available to ASDF.

## What's here

- maxima-file.lisp

  Definition of the :maxima-file component for ASDF.

- maxima\-asdf.lisp

  Glue code for calling ASDF functions from Maxima.

- maxima\-quicklisp.lisp

  Glue code for downloading and installing packages
  from Github into quicklisp/local-projects/.

## How to use it

- Copy maxima-asdf/ to quicklisp/local-projects/ or do the following in
  quicklisp/local-projects/

      git clone https://github.com/robert-dodier/maxima-asdf.git

- Load `maxima-asdf` by executing `:lisp (ql:quicklisp :maxima-asdf)` in your
  Maxima session or by putting `(ql:quicklisp :maxima-asdf)` in
  `maxima-init.lisp`. Please note that Quicklisp must be loaded in every Maxima
  session.

- Use `install_github` to install projects and `asdf_load_source` to load
  packages. A sample session is included below using the clifford package by
  Dimiter Prodanov. In order to make clifford loadable via `asdf_load_source`, I
  forked clifford on Github and added a clifford.asd file. Note that the
  clifford package contains a couple of sizeable documents, so it might take a
  few moments to download.

      install_github ("robert-dodier", "clifford", "master");
      asdf_load_source ("clifford");
      demo (clifford);
