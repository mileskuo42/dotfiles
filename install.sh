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

echo "==> 安装 Helix 编辑器..."
mkdir -p ~/.local/bin
if ! command -v hx &>/dev/null; then
    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64)  HX_ARCH="x86_64-linux" ;;
        aarch64) HX_ARCH="aarch64-linux" ;;
        arm64)   HX_ARCH="aarch64-macos" ;;
        *)       echo "  跳过 Helix：不支持的架构 $ARCH" ;;
    esac
    if [ -n "$HX_ARCH" ]; then
        curl -sL "https://github.com/helix-editor/helix/releases/latest/download/helix-${HX_ARCH}.tar.xz" | tar xJ -C /tmp
        mv /tmp/helix-*/hx ~/.local/bin/
        echo "    hx 已安装到 ~/.local/bin/hx"
    fi
else
    echo "    hx 已存在，跳过"
fi

echo ""
echo "✓ 完成！重新打开终端生效。"
echo "  提示：把 API key 等敏感变量写入 ~/.env.local"
