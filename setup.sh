#!/usr/bin/env bash

mkdir -p ~/.local/bin
mkdir -p ~/.local/share
mkdir -p ~/.local/state
mkdir -p ~/.config
mkdir ~/workspace

export PATH="$HOME/.local/bin:$PATH"

cp .zshrc ~/.zshrc

function _homebrew() {
	if [[ -z "$(which brew)" ]]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi
}

function _iterm-colors() {
	mkdir -p ~/.config/iterm2

	if [[ ! -f ~/.config/iterm2/Solarized-Dark-Higher-Contrast.itermcolors ]]; then
		curl https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Solarized%20Dark%20Higher%20Contrast.itermcolors -o ~/.config/iterm2/Solarized-Dark-Higher-Contrast.itermcolors
	fi
}

function _lsd() {
	mkdir -p ~/.config/lsd
	cp lsd-config.yaml ~/.config/lsd/config.yaml
	brew install -q lsd
}

function _cargo() {
	if [[ -z "$(which cargo)" ]]; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	fi
}

function _starship() {
	cp starship.toml ~/.config

	if [[ -z "$(which starship)" ]]; then
		sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --bin-dir ~/.local/bin
	fi
}

function _sdkman() {
	if [[ -z "$(which sdk)" ]]; then
		export SDKMAN_DIR="$HOME/.local/sdkman"
		curl -s "https://get.sdkman.io" | bash
		source "$SDKMAN_DIR/bin/sdkman-init.sh"
	fi
}

_homebrew
_iterm-colors
_lsd
_cargo
_starship
_sdkman

brew tap homebrew/cask-fonts && brew install --cask font-symbols-only-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install -q shfmt tfenv zsh-autosuggestions ripgrep neovim jq ncdu fd bat fzf
# stuff for yazi
brew install -q ffmpegthumbnailer unar poppler zoxide yazi

# TODO put these in seperate functions
brew install -q fnm
echo "v16.20.1" >> ~/workspace/.node_version

echo ".idea" >> ~/workspace/.gitignore
git config --global push.default current
git config --global core.excludesfile ~/workspace/.gitignore

printf "\n===> NOTE: if a zsh-autosuggestions related error follows this, ignore it and open a new terminal.\n\n"

printf "\n===> Now run `source ~/.zshrc` or open a new terminal."
