{
  flake-parts-lib,
  moduleWithSystem,
  inputs,
  ...
}:
let
  inherit (flake-parts-lib) importApply;
in
{
  imports = [ inputs.flake-parts.flakeModules.modules ];

  flake.modules.homeManager.ceamx = moduleWithSystem (
    perSystem@{ inputs', config, ... }:
    home@{ lib, ... }:
    {
      imports = [
        (importApply ./ceamx/default.nix {
          inherit (inputs'.nix-treesitter.packages) tree-sitter-corn;
        })
      ];

      config = lib.mkIf home.config.programs.emacs.ceamx.enable {
        home.packages = [
          perSystem.config.packages.aspell-with-dicts
          perSystem.config.packages.rassumfrassum

          inputs'.nix-nil-lsp.packages.nil
        ];

        # Not the greatest workaround, but...
        # <https://github.com/minad/jinx/discussions/173#discussioncomment-9416580>
        home.sessionVariables.ASPELL_CONF = "dict-dir ${config.packages.aspell-with-dicts}/lib/aspell";
      };
    }
  );

  # flake.modules.home.org-protocol = moduleWithSystem (_@{config,...}: _@);
}
