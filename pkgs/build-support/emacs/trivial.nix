# trivial builder for Emacs packages

{ lib, stdenv, texinfo, ... }@envargs:

with lib;

args:

import ./generic.nix envargs ({
  buildPhase = ''
    runHook preBuild

    emacs -L . --batch -f batch-native-compile *.el

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    LISPDIR=$out/share/emacs/site-lisp
    install -d $LISPDIR
    install *.el *.elc eln-* $LISPDIR

    runHook postInstall
  '';
}

// args)
