# desc: Shared helper for ~/bin scripts that run a CLI from a docker image.
# Source this file, then: docker_tool [-s] [-w] [-u] [-e VAR]... [-v SRC:DST]... IMAGE [ARGS...]
#   -s  mount the docker socket     -w  mount $PWD at /work and run there
#   -u  run as the calling user     -e  pass VAR through if it is set
#   -v  extra bind mount
docker_tool() {
  local opt
  local -a args=(--rm)
  [ -t 0 ] && args+=(-i)
  [ -t 1 ] && args+=(-t)
  OPTIND=1
  while getopts 'swue:v:' opt; do
    case "$opt" in
      s) args+=(-v /var/run/docker.sock:/var/run/docker.sock) ;;
      w) args+=(-v "$PWD:/work" -w /work) ;;
      u) args+=(-u "$(id -u):$(id -g)") ;;
      e) [ -n "${!OPTARG+x}" ] && args+=(-e "$OPTARG") ;;
      v) args+=(-v "$OPTARG") ;;
      *) return 2 ;;
    esac
  done
  shift $((OPTIND - 1))
  exec docker run "${args[@]}" "$@"
}
