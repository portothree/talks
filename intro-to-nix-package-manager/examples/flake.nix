{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      my-container-image = pkgs.dockerTools.buildLayeredImage {
        name = "my-container-image";
        tag = "latest";
        contents = [
          pkgs.hello
        ];
        config.Cmd = [ "hello" ];
      };
    };
}
