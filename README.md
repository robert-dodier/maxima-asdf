## What's the point of this?

The point is that with this stuff, ASDF can load system
definitions which contain Maxima files. Maxima is called to
load or compile and load Maxima files. There is also code
to download tar.gz files from Github and install them into
Quicklisp, which makes them available to ASDF.

## What's here

- maxima-file/

  Definition of the :maxima-file component for ASDF.

- maxima\-asdf.lisp

  Glue code for calling ASDF functions from Maxima.

- maxima\-quicklisp.lisp

  Glue code for downloading and installing packages 
  from Github into quicklisp/local-projects/.

## How to use it

Here is an example using the clifford package by Dimiter Prodanov.
I forked clifford on Github and added a clifford.asd file.

Note that the clifford package contains a couple of sizeable documents,
so it might take a few moments to download.

- Copy maxima-file/ to quicklisp/local-projects/.

- Launch Maxima. The rest of the steps are carried out in the Maxima session.

- `load ("maxima-asdf.lisp");`

- `load ("maxima-quicklisp.lisp")`;

- `install_github ("robert-dodier", "clifford", "master");`

- `asdf_load_source ("clifford");`

- `demo (clifford);`
