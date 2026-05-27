{
  inputs,
  vars,
  ...
}:
{
  home-manager.users.${vars.username} = {
    imports = with inputs.self.modules.homeManager; [
      base
    ];

    home.file.".config/nvim".source = inputs.self + /config/nvim;
    home.file.".config/.tmux.conf".source = inputs.self + /config/tmux/tmux.conf;
    home.file.".config/starship.toml".source = inputs.self + /config/starship/starship.toml;
    home.file.".zshrc".source = inputs.self + /config/zsh/zshrc;
    home.sessionVariables.EDITOR = "nvim";
  };
}
