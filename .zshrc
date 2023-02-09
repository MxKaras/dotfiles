export PATH="$HOME/.local/bin:$PATH"

export DOCKER_BUILDKIT=1

alias vim="nvim"
alias ls="lsd"
alias ll="lsd -la"

alias k="kubectl"
alias tf="terraform"
alias tg="terragrunt"

function ktx() {
	kubectl config use-context $1
}

function kexec() {
	kubectl exec --stdin --tty -n $2 $1 -- /bin/bash
}

## GIT

function gcb() {
	# equivalent to `git branch --show-current` I guess?
	git rev-parse --abbrev-ref HEAD | tr -d '\n' | pbcopy
}

function gpb() {
	B=$(git branch --show-current)
	git pull origin $B
}

function gcm() {
	B=$(git symbolic-ref /refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
	git checkout $B
}

function gcmd() {
	CB=$(git branch --show-current | tr -d '\n')
	gcm
	git branch -D $CB
	gpb
}

alias gfo="git fetch origin --prune"
alias gs="git status"
alias gcan="git commit -a --amend --no-edit"

#####

function ap() {
	if [[ -z "$1" ]]; then
		echo $AWS_PROFILE
	else
		export AWS_PROFILE=$1
	fi
}

function docker-shell() {
	docker run --rm -it --entrypoint /bin/sh $1
}

function bump-starship() {
	sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --bin-dir ~/.local/bin
}

PREFIX="$(brew --prefix)"
source $PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"
