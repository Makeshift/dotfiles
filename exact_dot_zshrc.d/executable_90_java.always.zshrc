# We want to set the JAVA_HOME var based on the current version of Java we have selected,
#  which is set by update-alternatives, so use readlink to follow the symlink to the
#  java binary then remove the /bin/java from the end of the path.
JAVA_HOME=$(readlink -f /usr/bin/java)
JAVA_HOME=${JAVA_HOME%/bin/java}
export JAVA_HOME
