# unameOut="$(uname -s)"
# case "${unameOut}" in
# Linux*) export os=Linux ;;
# Darwin*) export os=Mac ;;
# CYGWIN*) export os=Windows ;;
# MINGW*) export os=Windows ;;
# *) export os="UNKNOWN:${unameOut}" ;;
# esac

# # Handle armhf/aarch64 systems by appending _arm32 to compiled binaries in ~/bin TODO: should be fixed by wrapper
# architecture="$(uname -m)"
# export architecture
# if [[ "$architecture" =~ "aarch64" ]]; then
#   export archstring="_arm32"
# fi

# # If there are files in our home bin with an archstring that matches our arch
# #  then create aliases to them so they take priority over PATH
# # Also this is a funky way to do this, so stop shellcheck whining
# # TODO wrapper script should handle this
# # shellcheck disable=all
# if [ -n "${archstring}" ]; then
#   for file in $HOME/bin/*${archstring}; do
#     file=$(basename "$file")
#     file=${file%$archstring}
#     alias ${file}=${file}${archstring}
#   done
# fi
