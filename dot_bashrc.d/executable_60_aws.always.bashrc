alias ssm='aws ssm start-session --target' # SSM session shortcut

if command -v aws_completer >/dev/null; then
  complete -C "$(command -v aws_completer)" aws
fi

if [[ -f $HOME/.aws/source_me ]]; then source $HOME/.aws/source_me; fi
alias work='work && . $HOME/.aws/source_me' # Reload AWS credentials after 'work' logs us in

# https://github.com/common-fate/granted
if which assume &> /dev/null; then
	alias assume="source assume"
fi
