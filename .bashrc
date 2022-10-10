# Set up a simple prompt with directory and git info
source ~/.bash_git
PS1='\[\033]0;\w\007\]\n\[\033[0;32m\]- \w\[\033[0;36m\]`__git_ps1`\[\033[0m\]\n\[\033[1;30m\]$ \[\033[0m\]'

alias gs="git status"
alias ga="git add -A"
alias gap="ga -p"
alias gc="git commit"
alias gcm="gc -m"
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(bold cyan) %an  %C(dim green)(%ar)%n        %C(white)%s%n%C(dim yellow)%d%C(reset)' --all"
alias gls="gl --simplify-by-decoration"
alias gd="git diff"
alias gdc="git diff --cached"
alias gdma='gd master...@'
alias gundo="git reset @^"
alias gmc="find -name '*.orig' | xargs -r rm" #merge cleanup
alias gfm="git fetch && gfo master"
alias gfmc="gfm && git checkout master"
alias grpo="git remote prune origin"

alias grepr='grep -rI --exclude-dir=.git --exclude=*.lcl'
alias greprc='grep -rI --include="*.cs"'
alias greprx='grep -rI --include="*.xml"'
alias greprdef='grep -rI --include="*.[Dd]efaults"'

alias pr='start firefox https://dev.azure.com/mseng/AzureDevOps/_git/AzureDevOps/pullrequests?_a=mine'
alias prcc='start firefox https://dev.azure.com/mseng/AzureDevOps//_git/AzureDevOps.ConfigChange/pullrequests?_a=mine'
alias prn='start firefox https://dev.azure.com/mseng/AzureDevOps/_git/AzDevNext/pullrequests?_a=mine'
alias prd='start firefox https://dev.azure.com/mseng/AzDevNext.Deploy/_git/AzDevNext.Deploy/pullrequests?_a=mine'
alias yolo='gc -a --amend --no-edit && git push -f'

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

function gfo () {
	git fetch . origin/$1:$1
}

function gfd () {
	git fetch . `git rev-parse --abbrev-ref HEAD`:$1
}

# git push set upstream
function gpsu () {
    branch=$(git rev-parse --abbrev-ref @)
    cmd="git push -u origin $branch:users/chkimes/$branch"
    echo $cmd
    eval $cmd
}
