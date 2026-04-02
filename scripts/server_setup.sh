#!/bin/bash
set -e

mkdir -p ~/.local/bin
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

cd ~/.local/bin

# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar xf nvim-linux-x86_64.tar.gz
ln -sf nvim-linux-x86_64/bin/nvim nvim
rm nvim-linux-x86_64.tar.gz

# yazi
curl -LO https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip
unzip -o yazi-x86_64-unknown-linux-gnu.zip
ln -sf yazi-x86_64-unknown-linux-gnu/yazi yazi
rm yazi-x86_64-unknown-linux-gnu.zip

# ripgrep
RG_VER=$(curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | grep tag_name | cut -d'"' -f4)
curl -LO "https://github.com/BurntSushi/ripgrep/releases/latest/download/ripgrep-${RG_VER}-x86_64-unknown-linux-musl.tar.gz"
tar xf ripgrep-*.tar.gz
cp ripgrep-*/rg .
rm -rf ripgrep-*

# fd
FD_VER=$(curl -s https://api.github.com/repos/sharkdp/fd/releases/latest | grep tag_name | cut -d'"' -f4)
curl -LO "https://github.com/sharkdp/fd/releases/latest/download/fd-${FD_VER}-x86_64-unknown-linux-musl.tar.gz"
tar xf fd-*.tar.gz
cp fd-*/fd .
rm -rf fd-*

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# starship
curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/.local/bin -y

echo "Done. Run: source ~/.zshrc"
