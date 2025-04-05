export PATH="$PATH:$HOME/.local/bin:$HOME/.local/share/gem/ruby/3.0.0/bin:$HOME/.cargo/bin"
export LC_ALL="C"

#set programs
export LANG="en_US.UTF-8"
export TERM="screen-256color-bce"
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export VIDEO="mpv"
export EXA_COLORS="*.mp3=36"
export XDG_CACHE_HOME="$HOME/.cache"
export GTK_IM_MODULE='ibus'
export QT_IM_MODULE='ibus'
export SDL_IM_MODULE='ibus'
export XMODIFIERS='@im=ibus'
export GDK_BACKEND="wayland"
export MPD_HOST="127.0.0.1"
export GOPATH="$HOME/.local/go"
export COSMIC_DISABLE_DIRECT_SCANOUT=1
export QT_STYLE_OVERRIDE="kvantum"
# export DISPLAY=":0"

#move dotfiles
export ZDOTDIR="$HOME/.config/zsh"

if [ "$TERM" = "linux" ]; then
	/bin/echo -e "
	\e]P0191724
	\e]P1eb6f92
	\e]P29ccfd8
	\e]P3f6c177
	\e]P431748f
	\e]P5c4a7e7
	\e]P6ebbcba
	\e]P7e0def4
	\e]P826233a
	\e]P9eb6f92
	\e]PA9ccfd8
	\e]PBf6c177
	\e]PC31748f
	\e]PDc4a7e7
	\e]PEebbcba
	\e]PFe0def4
	"
	# get rid of artifacts
	clear
fi

if [[ "$(tty)" = "/dev/tty1" ]]; then 
    dbus-run-session niri; exit
fi
