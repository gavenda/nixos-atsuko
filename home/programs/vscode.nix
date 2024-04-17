{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        editorconfig.editorconfig
        bbenoist.nix
        teabyii.ayu
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "volar";
          publisher = "Vue";
          version = "2.0.12";
          sha256 = "sha256:uTMOaE/IInT4V6AZb83eoviKO5adiMybIEQkS4pVEcw=";
        }
      ];
    })
  ];
}
