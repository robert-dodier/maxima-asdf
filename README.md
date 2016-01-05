## What's the point of this?

The point is that with this stuff, ASDF can load system
definitions which contain Maxima files. Maxima is called to
load or compile and load Maxima files.

## What's here

- maxima-file/

  Definition of the :maxima-file component for ASDF.

- maxima\_asdf.lisp

  Glue code for calling ASDF functions from Maxima.

- foo/

  Example of ASDF-loadable system which makes use
  of :maxima-file components.

## How to use it

See foo/foo.asd and foo/src/ for an example.
For that to work, you have to put foo and maxima-file
where ASDF can find them.
