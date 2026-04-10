# dotfiles

## 本地安装

```bash
bash install.sh
```

## 服务器配置

服务器上没有同步这份 dotfiles，需要手动把以下内容加入远程的 `~/.zshrc`：

**鼠标上报修复**（防止 vim/fzf 退出后触控板滑动出现乱码）：

```zsh
autoload -Uz add-zsh-hook
_reset_mouse_reporting() {
    printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l\e[?1015l'
}
add-zsh-hook precmd _reset_mouse_reporting
```

**tmux 常用 alias**：

```zsh
alias tl='tmux ls'
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tk='tmux kill-session -t'
alias tka='tmux kill-server'
```
