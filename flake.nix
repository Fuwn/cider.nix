{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    systems.url = "github:nix-systems/default";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs =
    {
      flake-utils,
      nixpkgs,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        homeManagerModules.default =
          { config, ... }:
          with pkgs.lib;
          {
            options.programs.cider = {
              enable = mkOption {
                type = types.bool;
                default = false;
                description = "Enable Cider";
              };

              path = mkOption {
                type = types.path;
                description = "Path to Cider AppImage";
              };
            };

            config = mkIf config.programs.cider.enable {
              home.packages = [
                (pkgs.appimageTools.wrapType2 {
                  name = "cider";
                  src = config.programs.cider.path;

                  meta = with pkgs.lib; {
                    description = "The perfect client for Apple Music users";
                    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
                    homepage = "https://cider.sh/";
                    license = licenses.unfree;
                    platforms = platforms.linux;
                    mainProgram = "cider";
                    maintainers = [ maintainers.Fuwn ];
                  };
                })
              ];
            };
          };
      }
    );
}
