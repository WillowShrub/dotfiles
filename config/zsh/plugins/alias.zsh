alias ls='ls --color=auto'
alias hx='helix'
alias v='nvim'
alias yoump3='yt-dlp -x --audio-format vorbis'
alias yoump3-pl='yt-dlp -x --audio-format vorbis -o "%(playlist_index)s-%(title)s.%(ext)s"'
alias youtube-pl='yt-dlp -o "%(playlist_index)s-%(title)s.%(ext)s"'
alias py='python3.12'
alias open='xdg-open'
# alias doas='doas '
# alias kernelup='doas eclean-kernel -n 1 && doas grub-mkconfig -o /boot/grub/grub.cfg'
alias woman='man'
alias tmux='tmux -u'
alias sus='systemctl'
alias sxiv='imv'
alias nsxiv='imv'
alias usb='cd /run/media/$USERNAME'
alias projectadd='pwd | sed "s~$HOME/~~" >> ~/.local/share/projects'
alias pdb='python3.12 -m pdbp'
alias pdbp='python3.12 -m pdbp'
alias ncmpcpp='ncmpcpp -b ~/.config/ncmpcpp/bindings'
alias fetch='hyfetch'
