{ config, pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.11";

  home.file = {
    ".config/niri".source =
      ./config/niri;

    ".config/foot".source =
      ./config/foot;

    ".config/tmux/tmux.conf".source =
      ./config/tmux/tmux.conf;

    ".config/nvim".source =
      ./config/nvim;

    ".config/zathura".source =
      ./config/zathura;

    ".config/yazi".source =
      ./config/yazi;

    ".config/ghostty".source =
      ./config/ghostty;
  };

  programs.home-manager.enable = true;
}
