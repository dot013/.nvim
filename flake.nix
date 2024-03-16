{
  description = "My NeoVim config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";

    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, neovim, flake-utils, gen-luarc, ... }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      neovim-overlay = import ./overlay.nix { inherit inputs; };
    in
    flake-utils.lib.eachSystem supportedSystems
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              neovim-overlay
              gen-luarc.overlays.default
            ];
          };
          shell = pkgs.mkShell {
            name = "nvim-devShell";
            builtInputs = with pkgs; [
              lua-language-server
              nil
              stylua
              luajitPackages.luacheck
              deno
            ];
            shellHook = ''
              ln -fs ${pkgs.nvim-luarc-json} .luarc.json
            '';
          };
        in
        {
          packages = rec { default = nvim; nvim = pkgs.nvim-pkg; };
          devShells = { default = shell; };
        }) // { overlays.default = neovim-overlay; };
}
