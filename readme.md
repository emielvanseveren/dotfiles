# Dotfiles

### dependencies:

- direnv
- kubectx and kubens 
- MonaSpace font
- dunst
- swaylock
- ripgrep
- fd
- nerdfonts
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

### optional
- VLC

### Systemd

```bash
## Enable 
systemctl enable --user ssh-agent.service

```


### Windows Dual boot

Windows by default stores your current local time to the system clock. Linux stores the current UTC time to the system clock and calculates the local time when displaying it. When you boot into Windows, it will add your timezone to the system clock. Then when you boot into Linux, it will incorrectly think; your system clock is in UTC, and add your time zone again before displaying it. ([FIX](https://wiki.archlinux.org/title/System_time#UTC_in_Microsoft_Windows))


