alias ssm='aws ssm start-session --target' # SSM session shortcut

alias work='work && . $HOME/.aws/codeartifact-token' # Reload AWS credentials after 'work' logs us in
[[ -f "$HOME/.aws/codeartifact-token" ]] && . "$HOME/.aws/codeartifact-token"

export AWS_REGION=eu-west-1
export AWS_PROFILE=original-main-account
