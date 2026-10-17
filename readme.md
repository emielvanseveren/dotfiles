# Dotfiles

### dependencies:

- alacritty (cargo install alacritty)
- foot (apt, secondary terminal; tmux.conf declares terminal features for both)
- zsh (via apt)
- oh-my-zsh (https://github.com/ohmyzsh/ohmyzsh)
- direnv (apt)
- man
- kubectx and kubens 
- MonaSpace font
- dunst
- ripgrep
- fzf (>= 0.61 for the styled look; Ubuntu ships 0.44, put the release binary in ~/.local/bin)
- fd-find (Ubuntu names it fdfind: `ln -s /usr/bin/fdfind ~/.local/bin/fd`)
- bat (Ubuntu names it batcat: `ln -s /usr/bin/batcat ~/.local/bin/bat`)
- tree
- dunst
- firefox  (In `about:config` (firefox browser) enable `toolkit.legacyUserProfileCustomizations.stylesheets` to allow custom stylesheets)
- swww
- waybar
- zathura (this is just the document viewer and requires different package for each filetype)
- zathura-pdf-mupdf
- texlive-basic
- texlive-
- texlive-meta
- wl-clipboard (system clipboard handler, required to copy between system and nvim)
- git-delta (git pager)
- nwg-displays
- rofi
- tmux
- pulseaudio
- neovim
- brightnessctl (add user to video group)
- playerctl (media keys in sway)
- curl
- wget
- keychain
- bind-tools (dig command)
- tpm (git clone in ~/.tmux/plugins/tmp + prefix+I to install plugins)
- vlc
- pavucontrol
- docker (install via docker website)
- grim, slurp (screenshots)
- xdg-desktop-portal-wlr (for screensharing)

#### Desktop specific

- hyprland
- hypridle
- hyprlock

#### Laptop specific
The reason I use sway on my work laptop is because we require to use Ubuntu. Ubuntu is not supported by Hyprland
- sway
- swayidle
- swaylock
- kanshi
- wl-mirror

### Fonts
[Download the specific font](https://github.com/ryanoasis/nerd-fonts/releases) and move the font files to `~/.local/share/fonts/`, then run `fc-cache -f`.

- 0xProto Nerd Font (used by alacritty — see `~/.config/alacritty/alacritty.toml`)
- JetBrainsMono Nerd Font
- MonaSpace

### Systemd

```bash
## Enable 
systemctl enable --user ssh-agent.service
## https://github.com/moby/moby/issues/38373#issuecomment-447393517
systemctl enable --user docker.socket
```

### AI related tools
- github cli (gh)
- claude cli


### Windows Dual boot

Windows by default stores your current local time to the system clock. Linux stores the current UTC time to the system clock and calculates the local time when displaying it. When you boot into Windows, it will add your timezone to the system clock. Then when you boot into Linux, it will incorrectly think; your system clock is in UTC, and add your time zone again before displaying it. ([FIX](https://wiki.archlinux.org/title/System_time#UTC_in_Microsoft_Windows))

