ex()
{
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2) tar xjf $1 ;;
			*.tar.gz) tar xzf $1 ;;
			*.bz2) bunzip2 $1 ;;
			*.rar) unrar x $1 ;;
			*.gz) gunzip $1 ;;
			*.tar) tar xf $1 ;;
			*.tbz2) tar xjf $1 ;;
			*.tgz) tar xzf $1 ;;
			*.zip) unzip $1 ;;
			*.Z) uncompress $1 ;;
			*.7z) 7z x $1 ;;
			*.tar.xz) tar xf $1 ;;
			*.tar.zst) unzstd $1 ;;
			*) echo "$1 cannot be extracted" ;;
		esac
	else
	echo "$1 is not valid"
	fi
}

title() 
{
    ffmpeg -i $1 -metadata title=$2 -metadata album=$3 "$1\ .mp3"
    rm $1
    mv "$1\ .mp3" $1
}

doc() {
    touch $1.txt
    abiword --to=docx $1.txt
    rm $1.txt
}

thx() {
	tmux new-window hx $1
}
