{
  config,
  pkgs,
  username,
  ...
}:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.11";

  home.file = {
    ".config/niri".source = ./config/niri;

    ".config/foot".source = ./config/foot;

    ".config/kitty".source = ./config/kitty;

    ".config/tmux/tmux.conf".source = ./config/tmux/tmux.conf;

    ".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "/run/media/${username}/qas/Projects/home-manager/config/nvim";

    ".config/zathura".source = ./config/zathura;

    ".config/yazi".source = ./config/yazi;

    ".config/ghostty".source = ./config/ghostty;

    ".config/fuzzel".source = ./config/fuzzel;

    ".config/mako".source = ./config/mako;

    ".config/swaylock".source = ./config/swaylock;

    ".config/swayidle".source = ./config/swayidle;

    ".config/waybar".source = ./config/waybar;
  };

  home.packages = with pkgs; [
    nixfmt
  ];

  programs.home-manager.enable = true;
}
