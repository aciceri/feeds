with import <nixpkgs> {
 overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];
};

let
  customEmacs = (emacsWithPackagesFromUsePackage {
    package = pkgs.emacs;
    config = "";
    extraEmacsPackages = epkgs: [
      epkgs.elfeed
      epkgs.elfeed-org
    ];
  });  
  deploy = pkgs.writeShellScriptBin "deploy"
    ''
      ${customEmacs}/bin/emacs --batch --no-init --load export.el
      cat feeds.opml
    '';
in
stdenv.mkDerivation rec {
  name = "feeds";
  buildInputs = [ deploy ];
}
