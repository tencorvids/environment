{ inputs, ... }:
{
  flake.modules.homeManager.core =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bat
        curl
        eza
        fd
        fzf
        home-manager
        jq
        lazydocker
        lazygit
        neovim
        ripgrep
      ];
      imports = with inputs.self.modules.homeManager; [
        git
        ssh
      ];
    };
}
