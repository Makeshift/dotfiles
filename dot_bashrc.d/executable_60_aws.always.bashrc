alias ssm='aws ssm start-session --target' # SSM session shortcut

if command -v aws_completer >/dev/null; then
  complete -C "$(command -v aws_completer)" aws
fi

if [[ -f /tmp/aws_work_conf/source_me ]]; then source /tmp/aws_work_conf/source_me; fi

# https://github.com/common-fate/granted
if which assume &> /dev/null; then
	alias assume="source assume"
fi
