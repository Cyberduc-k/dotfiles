# contains $fish_user_paths "~/.cargo/bin"; or set -Ua fish_user_paths "~/.cargo/bin"
# contains $fish_user_paths "~/.fzf/bin"; or set -Ua fish_user_paths "~/.fzf/bin"
# contains $fish_user_paths "/mnt/f/Language/zig-linux-x86_64-0.5.0+12e1c6e21"; or set -Ua fish_user_paths "/mnt/f/Language/zig-linux-x86_64-0.5.0+12e1c6e21"
set -gx LLVM_SYS_100_PREFIX /home/cyberduck/.local/share/llvmenv/10.0.0
set -gx DISPLAY (grep nameserver /etc/resolv.conf | sed 's/nameserver //' | head -n 1)
set -gx FZF_DEFAULT_COMMAND "fd --type f"
set -gx FZF_DEFAULT_OPTS "--reverse --height 15%"
