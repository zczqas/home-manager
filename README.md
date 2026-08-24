# Home Manager Dotfiles

This repository uses **Nix Home Manager** on CachyOS to manage selected user configurations while leaving the rest of the system configuration untouched.

## Structure

```text
dotfiles/
├── flake.nix
├── home.nix
└── config/
    ├── niri/
    │   └── config.kdl
    ├── foot/
    │   └── foot.ini
    ├── tmux/
    │   └── tmux.conf
    ├── nvim/
    ├── zathura/
    ├── yazi/
    └── ghostty/
```

Currently managed:

* Niri
* Foot
* Tmux
* Neovim
* Zathura
* Yazi
* Ghostty

Fish is currently **not managed by Home Manager**.

---

## Applying Changes

After modifying any configuration in the repository:

```bash
cd ~/Projects/dotfiles
```

Check the configuration:

```bash
nix flake check
```

Apply the changes:

```bash
nix run github:nix-community/home-manager -- switch --flake .
```

Home Manager creates a new generation containing the updated configuration.

---

## Modifying Configurations

Do **not** directly modify the Home Manager-managed files under `~/.config`.

Instead, modify the corresponding file in the repository.

### Niri

Edit:

```bash
nvim ~/Projects/dotfiles/config/niri/config.kdl
```

Then:

```bash
nix run github:nix-community/home-manager -- switch --flake .
```

The resulting configuration will be available at:

```text
~/.config/niri/config.kdl
```

### Foot

Edit:

```bash
nvim ~/Projects/dotfiles/config/foot/foot.ini
```

Apply:

```bash
nix run github:nix-community/home-manager -- switch --flake .
```

### Tmux

Edit:

```bash
nvim ~/Projects/dotfiles/config/tmux/tmux.conf
```

Apply:

```bash
nix run github:nix-community/home-manager -- switch --flake .
```

### Neovim

Edit files inside:

```text
config/nvim/
```

For example:

```bash
nvim ~/Projects/dotfiles/config/nvim/lua/...
```

Apply:

```bash
nix run github:nix-community/home-manager -- switch --flake .
```

### Zathura

Edit files inside:

```text
config/zathura/
```

Apply:

```bash
nix run github:nix-community/home-manager -- switch --flake .
```

### Yazi

Edit files inside:

```text
config/yazi/
```

Apply:

```bash
nix run github:nix-community/home-manager -- switch --flake .
```

### Ghostty

Edit files inside:

```text
config/ghostty/
```

Apply:

```bash
nix run github:nix-community/home-manager -- switch --flake .
```

---

## Adding Another Configuration

To manage another configuration:

### 1. Copy it into the repository

For example:

```bash
mkdir -p config/rofi
cp -r ~/.config/rofi/* config/rofi/
```

### 2. Add it to `home.nix`

```nix
home.file = {
  # Existing configurations...

  ".config/rofi".source =
    ./config/rofi;
};
```

### 3. Check the configuration

```bash
nix flake check
```

### 4. Apply it

```bash
nix run github:nix-community/home-manager -- switch --flake .
```

---

## Removing a Configuration

If you no longer want Home Manager to manage something:

### 1. Remove it from `home.nix`

For example, remove:

```nix
".config/ghostty".source =
  ./config/ghostty;
```

### 2. Apply the configuration

```bash
nix run github:nix-community/home-manager -- switch --flake .
```

### 3. Remove the repository copy if no longer needed

```bash
rm -rf config/ghostty
```

The existing file in `~/.config/ghostty` may need to be handled separately depending on whether you want to keep using it outside Home Manager.

---

## Changing the Username

The current `flake.nix` contains:

```nix
extraSpecialArgs = {
  username = "ahn";
};
```

If using the repository on another machine with a different username, change this value:

```nix
extraSpecialArgs = {
  username = "newusername";
};
```

The `home.nix` uses this value:

```nix
home.username = username;
home.homeDirectory = "/home/${username}";
```

This is currently a manual per-machine setting.

---

## Checking the Current Configuration

Show the available Home Manager configurations:

```bash
nix flake show
```

Validate the configuration without applying it:

```bash
nix flake check
```

Build the configuration without activating it:

```bash
nix build .#homeConfigurations.ahn.activationPackage
```

Replace `ahn` with the configured username if necessary.

---

## Home Manager Generations

Every successful:

```bash
nix run github:nix-community/home-manager -- switch --flake .
```

creates a new Home Manager generation.

List generations:

```bash
home-manager generations
```

If the `home-manager` command is not installed separately, you can continue using:

```bash
nix run github:nix-community/home-manager -- generations
```

---

## Git Workflow

After confirming that a configuration works:

```bash
git status
git add .
git commit -m "Update niri configuration"
```

For example:

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

The warning:

```text
Git tree '...' has uncommitted changes
```

during `nix` commands is expected when you have modified files that haven't been committed yet.
