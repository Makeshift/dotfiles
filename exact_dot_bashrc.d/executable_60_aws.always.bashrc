alias ssm='aws ssm start-session --target' # SSM session shortcut

if command -v aws_completer >/dev/null; then
  complete -C "$(command -v aws_completer)" aws
fi

alias work='work && . $HOME/.aws/codeartifact-token' # Reload AWS credentials after 'work' logs us in
. $HOME/.aws/codeartifact-token

export AWS_REGION=eu-west-1
export AWS_PROFILE=original-main-account
