{
  description = "ESP32-C3 Development";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.curl
          pkgs.esptool
          pkgs.gnumake
          pkgs.go
          pkgs.mpremote
          pkgs.platformio-chrootenv
          pkgs.tinygo
        ];
      };
    };
}
