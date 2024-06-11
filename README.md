# Nvim Configuration

## 🛠️ Requirements

#### Make a backup of your current nvim and shared folder, if you don't want to lose your current configuration

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

#### Installtools for correct functioning

1. Ripgrep and xClip:

```shell
sudo apt-get install ripgrep xclip
```

2. Nerdfont:

   2.1. Download [FiraCode NerdFont](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/FiraCode.zip).

   2.2. Unzip and paste font files directly to `~./local/share/fonts`.

   2.3. Set FiraCode NerdFont as the terminal font.

3. Build essential (**OPTIONAL**, Fixes some errors when opening files in nvim): `sudo apt-get install build-essential`

## Installation

#### Clone this repository

```shell
git clone https://github.com/EduardoV-dev/astronvim-config ~/.config/nvim/lua/user
```

#### Start Neovim

```shell
nvim
```
