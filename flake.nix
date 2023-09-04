{
  description = "talks";
  nixConfig = { bash-prompt = "[talks.nix]$ "; };
  inputs = {
    nixpkgs = { url = "nixpkgs/nixos-22.05"; };
    pre-commit-hooks = { url = "github:cachix/pre-commit-hooks.nix"; };
  };
  outputs = { self, nixpkgs, pre-commit-hooks }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      checks.${system}.pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = { typos = true; };
      };
      devShells.${system}.default = import ./shell.nix { inherit pkgs; };
    };
}
