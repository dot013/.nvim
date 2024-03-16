{ inputs }: final: prev: with final.pkgs.lib; let
  pkgs = final;
  mkNeovim = pkgs.callPackage ./mk-neovim.nix { };
  extraPackages = with pkgs; [
    lua-language-server
    nil
  ];
in
{
  nvim-pkg = mkNeovim {
    plugins = [ ];
    inherit extraPackages;
  };
  nvim-luarc-json = final.mk-luarc-json {
    plugins = [ ];
  };
}
