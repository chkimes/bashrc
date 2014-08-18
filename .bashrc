alias gs="git status"
alias ga="git add -A"
alias gc="git commit"
alias gl="git log"
alias gd="git diff"
alias gdc="git diff --cached"
alias gundo="git reset @^"

# gclean and gnuke functions courtesy of rspeele (github.com/rspeele)
function gclean () {
	CLEAN='git clean -f -x -d -e *.csproj.user -e _ReSharper* -e ignored/'
	if [ "$1" = "please" ]; then
		$CLEAN
	else
		$CLEAN --dry-run
	fi
}
function gnuke () {
	NUKE='git clean -f -x -d'
	MAGICWORD=`date '+%Y%m%d'`
	if [ "$1" = `date '+%Y%m%d'` ]; then
		$NUKE
	else
		$NUKE --dry-run
		echo "You didn't say the magic word: $MAGICWORD"
	fi
}

