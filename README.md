# 🍎 `cider.nix`

> Home Manager module for [Cider](https://cider.sh/), a cross-platform Apple Music
experience written from the ground up with performance in mind

<p align="center">
  <br />
  <a href="https://cider.sh/">
    <img src="https://i.imgur.com/yODz0ue.png" alt="Screenshot from cider.sh" width="75%">
  </a>
  <br />
  <small>Screenshot from <a href="https://cider.sh/">cider.sh</a></small>
</p>

## Installation

### Standalone Home Manager

Directly add `cider.nix` as a Home Manager input.

```nix
{ pkgs, ... }:
{
  imports = [
    (import (
      pkgs.fetchFromGitHub {
        owner = "Fuwn";
        repo = "cider.nix";
        rev = "...";  # Use the current commit revision hash
        hash = "..."; # Use the current commit sha256 hash
      }
    )).homeManagerModules.${pkgs.system}.default
  ];
}
```

### Flakes & Home Manager

1. Add `cider.nix` to your flake inputs.

  ```nix
  {
    inputs.cider = {
      url = "github:Fuwn/cider.nix";
      inputs.nixpkgs.follows = "nixpkgs"; # Recommended
    };
  }
  ```

2. Consume `cider.nix` as a Home Manager module.

  ```nix
  # ...

  inputs.home-manager.lib.homeManagerConfiguration {
    modules = [
      inputs.cider.homeManagerModules.${pkgs.system}.default
    ];
  };

  # ...
  ```

## Configuration & Usage

After [purchasing Cider](https://cider.sh/downloads/client), download and place
the provided AppImage near your Home Manager configuration. Configure and access
`cider.nix` through the `programs.cider` attribute.

```nix
{
  programs.cider = {
    enable = true;

    # This value assumes that Cider's AppImage is adjacent relative to the 
    # operating Nix file
    path = ./Cider-linux-appimage-x64.AppImage;
  };
}
```

Cider will now be available as the executable `cider`.

## Licence

This project is licensed with the [GNU General Public License v3.0](./LICENSE.txt).
