alias gs="git status"
alias ga="git add -A"
alias gap="ga -p"
alias gc="git commit"
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(bold cyan) %an  %C(dim green)(%ar)%n        %C(white)%s%n%C(dim yellow)%d%C(reset)' --all"
alias gls="gl --simplify-by-decoration"
alias gd="git diff"
alias gdc="git diff --cached"
alias gundo="git reset @^"
alias gmc="find -name '*.orig' | xargs -r rm" #merge cleanup

# gclean and gnuke functions courtesy of rspeele (github.com/rspeele)
function gclean () {
	CLEAN='git clean -f -x -d -e *.csproj.user -e *.pubxml.user -e _ReSharper* -e .vs/ -e ignored/'
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

function gdl () {
	FROM=$1
	if [ "$1" = "" ]; then
		FROM=1
	fi

	ACCENTS=""
	while [ $FROM -gt 1 ]; do
		ACCENTS="$ACCENTS^"
		FROM=$((FROM-1))
	done

	git log -p -1 @$ACCENTS
}

function gdmb () {
	git diff $(git merge-base $1 $2) $2
}
