# Home Manager Dotfiles

This repository uses **Nix Home Manager** on **CachyOS** to manage user configuration files only.

- **pacman** installs applications, fonts and other system packages.
- **Nix / Home Manager** links the dotfiles from `config/` into `~/.config/` and manages `nixfmt`.
- **Fish** is currently **not** managed by Home Manager.

The repository does not install the desktop stack itself; the applications must be present before the configuration is useful.

---

## Structure

```text
home-manager/
├── flake.nix
├── home.nix
├── README.md
└── config/
    ├── fuzzel/
    │   └── fuzzel.ini
    ├── kitty/
    │   ├── kitty.conf
    │   ├── colors.conf
    │   └── current-theme.conf
    ├── mako/
    │   └── config
    ├── niri/
    │   ├── config.kdl
    │   ├── colors.kdl
    │   ├── cfg/
    │   │   ├── keybinds.kdl
    │   │   └── layout.kdl
    │   └── animations/
    │       └── pixelate.kdl
    ├── nvim/
    ├── swayidle/
    │   └── config
    ├── swaylock/
    │   └── config
    ├── tmux/
    │   └── tmux.conf
    ├── waybar/
    │   ├── config.jsonc
    │   └── style.css
    ├── yazi/
    │   └── theme.toml
    └── zathura/
        ├── zathurarc
        └── catppuccin-mocha
```

Currently managed:

* Niri (`config.kdl` plus keybinds, layout, colors and animations)
* Kitty
* Fuzzel
* Mako
* Swaylock
* Swayidle
* Waybar
* Tmux
* Neovim
* Zathura
* Yazi

---

## Prerequisites

A CachyOS/Arch system with:

* `pacman`
* Nix with flakes enabled

Check Nix:

```bash
nix --version
```

Home Manager does not have to be installed separately; it is run on demand with `nix run`.

---

## Install system packages

Install the desktop applications and fonts with **pacman**:

```bash
sudo pacman -S --needed \
  niri awww mako swayidle swaylock fuzzel kitty \
  zathura zathura-pdf-mupdf yazi thunar \
  cliphist wl-clipboard brightnessctl grim \
  network-manager-applet nm-connection-editor bemenu \
  ttf-jetbrains-mono-nerd
```

What the groups cover:

* Compositor / wallpaper / notifications: `niri`, `awww`, `mako`
* Idle, lock and launcher: `swayidle`, `swaylock`, `fuzzel`
* Terminal, file manager and PDFs: `kitty`, `thunar`, `yazi`, `zathura`, `zathura-pdf-mupdf`
* Clipboard, brightness and screenshots: `cliphist`, `wl-clipboard`, `brightnessctl`, `grim`
* Network GUI: `network-manager-applet`, `nm-connection-editor`
* Mako's middle-click menu and the Nerd Font: `bemenu`, `ttf-jetbrains-mono-nerd`

Notes:

* `awww` provides `swww` and the `awww-daemon` started by Niri.
* `zathura-pdf-mupdf` is required for Zathura to open PDF files.
* The Nerd Font used by Kitty, Fuzzel and Mako is `JetBrainsMono Nerd Font`.

### Optional AUR packages

```bash
paru -S ttf-proggy-vector   # font referenced by swaylock
paru -S nixfmt-bin          # if you prefer nixfmt from pacman
```

If you install `nixfmt-bin`, remove `nixfmt` from `home.packages` in `home.nix`.

### Verify the install

```bash
for b in niri waybar mako swayidle swaylock fuzzel kitty \
         zathura yazi cliphist wl-paste brightnessctl grim awww-daemon; do
  command -v "$b" || echo "missing: $b"
done

fc-list | grep -i 'JetBrainsMono Nerd' | head
```

---

## Applying changes

```bash
cd /run/media/uwu/qas/Projects/home-manager
```

If you cloned the repository somewhere else, use that path instead.

Check the configuration:

```bash
nix flake check
```

Or build just the activation package:

```bash
nix build .#homeConfigurations.uwu.activationPackage
```

Apply it:

```bash
nix run github:nix-community/home-manager -- switch --flake .
```

Home Manager creates a new generation containing the updated configuration.

`--flake .` looks for `homeConfigurations.<current-user>`. On this machine that is `homeConfigurations.uwu`, which must match the attribute in `flake.nix`. To select a configuration explicitly:

```bash
nix run github:nix-community/home-manager -- switch --flake .#uwu
```

---

## Modifying configurations

Do **not** edit the files under `~/.config` directly. They are Home Manager symlinks. Edit the matching file in the repository and switch.

### Niri

```text
config/niri/config.kdl
```

`config.kdl` includes:

* `cfg/keybinds.kdl`
* `cfg/layout.kdl`
* `colors.kdl`
* `animations/pixelate.kdl`

### Kitty

```text
config/kitty/kitty.conf
```

`kitty.conf` includes `current-theme.conf`.

### Waybar

```text
config/waybar/config.jsonc
config/waybar/style.css
```

### Mako

```text
config/mako/config
```

### Fuzzel

```text
config/fuzzel/fuzzel.ini
```

### Swaylock and Swayidle

```text
config/swaylock/config
config/swayidle/config
```

### Tmux

```text
config/tmux/tmux.conf
```

### Neovim

```text
config/nvim/
```

Neovim is linked **out of the store** so LazyVim can write `lazy-lock.json` into the config directory:

```nix
".config/nvim".source =
  config.lib.file.mkOutOfStoreSymlink
    "/run/media/${username}/qas/Projects/home-manager/config/nvim";
```

If you move the repository, update that path in `home.nix`.

### Zathura

```text
config/zathura/zathurarc
```

`zathurarc` includes `catppuccin-mocha`.

### Yazi

```text
config/yazi/theme.toml
```

Apply any change with:

```bash
nix run github:nix-community/home-manager -- switch --flake .
```

---

## Adding another configuration

### 1. Copy it into the repository

```bash
mkdir -p config/rofi
cp -r ~/.config/rofi/* config/rofi/
```

### 2. Add it to `home.nix`

```nix
home.file = {
  # Existing configurations...

  ".config/rofi".source = ./config/rofi;
};
```

### 3. Add it to Git

The flake source is the Git repository. New paths must exist and should be tracked:

```bash
git add config/rofi home.nix
```

### 4. Check and apply

```bash
nix flake check
nix run github:nix-community/home-manager -- switch --flake .
```

---

## Removing a configuration

### 1. Remove it from `home.nix`

For example, remove:

```nix
".config/rofi".source = ./config/rofi;
```

### 2. Apply the configuration

```bash
nix run github:nix-community/home-manager -- switch --flake .
```

### 3. Remove the repository copy if no longer needed

```bash
git rm -r config/rofi
```

The existing file in `~/.config/rofi` may need to be handled separately depending on whether you want to keep using it outside Home Manager.

---

## Username and configuration name

`flake.nix` currently contains:

```nix
homeConfigurations.uwu = home-manager.lib.homeManagerConfiguration {
  # ...
  extraSpecialArgs = {
    username = "uwu";
  };
  # ...
};
```

On another machine with a different username, change **both** the attribute name and the `username` value, or select the configuration explicitly with `--flake .#name`.

`home.nix` uses the value for:

```nix
home.username = username;
home.homeDirectory = "/home/${username}";
```

The Neovim out-of-store symlink also uses `${username}`.

---

## Checking the current configuration

Show the available Home Manager configurations:

```bash
nix flake show
```

Validate the configuration without applying it:

```bash
nix flake check
```

Build the activation package without activating it:

```bash
nix build .#homeConfigurations.uwu.activationPackage
```

List available generations:

```bash
home-manager generations
```

If the `home-manager` command is not installed separately:

```bash
nix run github:nix-community/home-manager -- generations
```

---

## Formatting Nix files

`nixfmt` is provided by `home.packages`:

```bash
nixfmt home.nix flake.nix
nixfmt --check home.nix flake.nix
```

If you move `nixfmt` to pacman via `paru -S nixfmt-bin`, remove it from `home.packages` in `home.nix`.

---

## Troubleshooting

### `does not provide attribute 'homeConfigurations.uwu...'`

The attribute name in `flake.nix` does not match the current user. Rename it, or select it explicitly:

```bash
nix run github:nix-community/home-manager -- switch --flake .#uwu
```

### `Path 'config/foo' does not exist in Git repository`

`home.nix` references a directory that is missing, or a new directory has not been added to Git. Either create the directory and `git add` it, or remove the entry from `home.nix`.

### `Failed to run nixfmt: spawn nixfmt ENOENT`

`nixfmt` is not installed. It is normally provided by `home.packages`; make sure the current generation has been applied, or install it with `paru -S nixfmt-bin`.

### `Git tree '...' has uncommitted changes`

This warning during Nix commands is expected when files have been modified but not committed.

### Niri session is not available at the login screen

Install `niri` (`sudo pacman -S niri`), log out, and select the Niri session in the display manager. Niri can also be started from a TTY.

### Waybar shows empty workspaces or window title

The `niri/workspaces` and `niri/window` modules require a running Niri session and Waybar with niri support. Waybar 0.16+ includes these modules.

---

## Git workflow

After confirming that a configuration works:

```bash
git status
git add .
git commit -m "Update niri configuration"
```

```text
Modify configuration
        ↓
nix flake check
        ↓
Home Manager switch
        ↓
Test configuration
        ↓
git commit
```
