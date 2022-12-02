let
  pkgs = import <nixpkgs> {};
in
pkgs.stdenv.mkDerivation {
  name = "hello-world";
  src = builtins.fetchTarball {
    url = "https://ftp.gnu.org/gnu/hello/hello-2.10.tar.gz";
    sha256 = "1im1gglfm4k10bh4mdaqzmx3lm3kivnsmxrvl6vyvmfqqzljq75l";
  };
}
