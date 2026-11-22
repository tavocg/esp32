{
  description = "ESP32-C3 Development";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      tinygoTarget = "esp32c3-supermini";
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
        shellHook = ''
          info="$(tinygo info ${tinygoTarget})"
          export GOROOT="$(printf '%s\n' "$info" | sed -n 's/^cached GOROOT:[[:space:]]*//p')"
          tags="$(printf '%s\n' "$info" | sed -n 's/^build tags:[[:space:]]*//p' | tr ' ' ',')"
          export GOFLAGS="-tags=$tags"
          export TINYGO_TARGET="${tinygoTarget}"

          case "$PS1" in
            "(esp32) "*) ;;
            *) PS1="(esp32) $PS1" ;;
          esac
        '';
      };
    };
}
