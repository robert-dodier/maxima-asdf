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

These instructions apply to Unix-like systems (including macOS).
The same steps probably apply for MS Windows, but the names of folders may vary.

Synopsis:

- Step 0. (ONE TIME ONLY) Install Quicklisp
- Step 1. (ONE TIME ONLY) Install maxima-asdf in Quicklisp
- Step 2. (ONE TIME ONLY) Ensure Quicklisp is loaded automatically by Maxima
- Step 3. (ONE TIME ONLY) Ensure maxima-asdf is loaded automatically by Maxima
- Step 4. (ONCE PER PROJECT) Use maxima-asdf to install projects
- Step 5. (ONCE PER SESSION) Use maxima-asdf to load packages

In more detail:

- Step 0. (ONE TIME ONLY) Install Quicklisp

  maxima-asdf uses Quicklisp to load Maxima programs.
  Refer to the Quicklisp home page (http://beta.quicklisp.org)
  for installation instructions.

- Step 1. (ONE TIME ONLY) Install maxima-asdf in Quicklisp

  maxima-asdf must be in a location where Quicklisp can find it.
  We can accomplish that by cloning maxima-asdf into
  the local-projects directory.

  Here $QUICKLISP\_HOME represents the location of the top-level Quicklisp directory.
  It is typically /home/you/quicklisp but it might be somewhere else.

      $ cd $QUICKLISP_HOME/local-projects/
      $ git clone https://github.com/robert-dodier/maxima-asdf.git

- Step 2. (ONE TIME ONLY) Ensure Quicklisp is loaded automatically by Maxima

  Quicklisp must be loaded in every Maxima session.
  To ensure this, add the following to your `maxima-init.lisp` file:

      #-quicklisp
      (let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                             (user-homedir-pathname))))
        (when (probe-file quicklisp-init)
          (load quicklisp-init)))

  Your `maxima-init.lisp` is found in `$HOME/.maxima`.

- Step 3. (ONE TIME ONLY) Ensure maxima-asdf is loaded automatically by Maxima

  maxima-asdf must be loaded in every Maxima session.
  To ensure this, add the following to your `maxima-init.lisp` file:

      (ql:quickload :drakma)
      (ql:quickload :maxima-asdf)

  maxima-asdf depends on drakma, a Common Lisp HTTP client,
  so drakma must be loaded first.
  (I was unable to figure out a way to make that completely automatic.)

- Step 4. (ONCE PER PROJECT) Use maxima-asdf to install projects

  The maxima-asdf function `install_github` installs a project from Github,
  specified by Github user name, repo name, and branch name.

      install_github (gh_user_name, repo_name, branch_name);

  `install_github` downloads a tarball containing the project
  and unpacks it in `quicklisp/local_projects` so that Quicklisp can find it.

  `"master"` is the most common branch name, but other branches
  may be specified equally well.

  At present (Dec 2018), there is no way to install only part of a repo;
  it's all or nothing.

- Step 5. (ONCE PER SESSION) Use maxima-asdf to load packages

  maxima-asdf functions `asdf_load` and `asdf_load_source`
  use Quicklisp to load packages, as defined by ASDF files
  (named with `.asd` file name extension).
  The ASDF files may be anywhere in the installed package;
  Quicklisp will search installed packages to find them.

# Example: clifford package

A sample session is included below using the clifford package by
Dimiter Prodanov. In order to make clifford loadable via `asdf_load_source`, I
forked clifford on Github and added a clifford.asd file. Note that the
clifford package contains a couple of sizeable documents, so it might take a
few moments to download.

      install_github ("robert-dodier", "clifford", "master");
      asdf_load_source ("clifford");

At this point the clifford package is loaded and we can run a demo.

      demo (clifford);
