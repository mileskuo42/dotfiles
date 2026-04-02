#!/bin/bash
set -e
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "==> 创建目录..."
mkdir -p ~/.config

echo "==> 软链接配置文件..."
configs=(kitty starship yazi)
for cfg in "${configs[@]}"; do
    rm -rf ~/.config/$cfg
    ln -sf "$DOTFILES/.config/$cfg" ~/.config/$cfg
    echo "    ~/.config/$cfg -> dotfiles"
done

rm -f ~/.config/starship.toml
ln -sf "$DOTFILES/.config/starship.toml" ~/.config/starship.toml

rm -f ~/.zshrc
ln -sf "$DOTFILES/.zshrc" ~/.zshrc

echo "==> 安装 Homebrew 包..."
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew install starship fzf zoxide ripgrep vivid
brew install --cask font-maple-mono-sc-nf

echo "==> 安装 Oh My Zsh 插件..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" --depth=1
[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" --depth=1

echo ""
echo "✓ 完成！重新打开终端生效。"
echo "  提示：把 API key 等敏感变量写入 ~/.env.local"
