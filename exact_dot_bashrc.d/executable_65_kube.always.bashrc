complete -o default -F __start_kubectl kubectl
. <(eksctl completion bash)

source <(helm completion bash)

#helm() {
#    command helm "$@" 2>&1 | helmerr
#}
