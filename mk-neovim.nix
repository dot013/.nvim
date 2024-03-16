{ pkgs, lib, stdenv, }:
with lib;
{ appName ? null
, plugins ? [ ]
, devPlugins ? [ ]
, ignoreConfigRegexes ? [ ]
, extraPackages ? [ ]
, resolvedExtraLuaPackages ? [ ]
, extraPython3Packages ? p: [ ]
, withPython3 ? true
, withRuby ? false
, withNodeJs ? false
, withSqlite ? true
, viAlias ? appName == "nvim"
, vimAlias ? appName == "nvim"
,
}:
let
  defaultPlugin = {
    plugin = null;
    config = null;
    optional = false;
    runtime = { };
  };
  externalPackages = extraPackages ++ (optionals withSqlite [ pkgs.sqlite ]);
  normalizedPlugins = map
    (x:
      defaultPlugin
      // (
        if x ? plugin
        then x
        else { plugin = x; }
      ))
    plugins;
  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    inherit extraPython3Packages withPython3 withRuby withNodeJs viAlias vimAlias;
    plugins = normalizedPlugins;
  };
  nvimRtpSrc =
    let
      src = ./.;
    in
    lib.cleanSourceWith {
      inherit src;
      name = "nvim-rtp-src";
      filter = path: tyoe:
        let
          srcPrefix = toString src + "/";
          relPath = lib.removePrefix srcPrefix (toString path);
        in
        lib.all (regex: builtins.match refex relPath == null) ignoreConfigRegexes;
    };
  nvimRtp = stdenv.mkDerivation {
    name = "nvim-rtp";
    src = nvimRtpSrc;
    buildPhase = ''
      mkdir -p $out/nvim
      mkdir -p $out/lua
      rm init.lua
    '';
    installPhase = ''
      cp -r after $out/after
      rm -r after
      cp -r lua $out/lua
      rm -r lua
      cp -r * $out/nvim
    '';
  };
  initLua = ''
    vim.loader.enable()
    vim.opt.rtp:prepend('${nvimRtp}/lua')
  ''
  + (builtins.readFile ./init.lua)
  + ''
    vim.opt.rtp:append('${nvimRtp}/nvim')
    vim.opt.rtp:append('${nvimRtp}/after')
  '';

  extraMakeWrapperArgs = builtins.concatStringsSep " " (
    (optional (appName != "nvim" && appName != null && appName != "")
      ''--set NVIM_APPNAME "${appName}"'')
    ++ (optional (externalPackages != [ ])
      ''--prefix PATH : "${makeBinPath externalPackages}"'')
    ++ (optional withSqlite
      ''--set LIBSQLITE_CLIB_PATH "${pkgs.sqlite.out}/lib/libsqlite3.so"'')
    ++ (optional withSqlite
      ''--set LIBSQLITE "${pkgs.sqlite.out}/lib/libsqlite3.so"'')
  );
  extraMakeWrapperLuaCArgs = optionalString (resolvedExtraLuaPackages != [ ]) ''
    --suffix LUA_CPATH ";" "${
      lib.concatMapStringsSep ";" pkgs.luaPackages.getLuaCPath
      resolvedExtraLuaPackages
    }"'';
  extraMakeWrapperLuaArgs = optionalString (resolvedExtraLuaPackages != [ ]) ''
    --suffix LUA_PATH ";" "${
      concatMapStringSep ";" pkgs.luaPackages.getLuaPath
      resolvedExtraLuaPackages
    }"'';
in
pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (neovimConfig // {
  luaRcContent = initLua;
  wrapperArgs =
    escapeShellArgs neovimConfig.wrapperArgs
      + " "
      + extraMakeWrapperArgs
      + " "
      + extraMakeWrapperLuaCArgs
      + " "
      + extraMakeWrapperLuaArgs;
  wrapRc = true;
})
