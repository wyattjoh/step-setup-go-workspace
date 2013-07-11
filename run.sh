export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

# Make actual go workspace
mkdir -p "$HOME/go/{src,pkg,bin}"
debug "Created Go workspace in $HOME/go"

package_dir="/"
if [ -z "$WERCKER_SETUP_GO_WORKSPACE_PACKAGE_DIR" ]
then
  if [ -z "$WERCKER_GIT_REPOSTORY" ]
  then
    package_dir="$GOPATH/src/$WERCKER_GIT_DOMAIN/$WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSTORY"
    debug "package-dir option not set, will use default: $package-dir"
  else
    fail 'missing package-dir option and no repository info found, please add this the setup-package-dir step in wercker.yml'
  fi
else
  package_dir="$GOPATH/src/$WERCKER_SETUP_PACKAGE_DIR_DIR"
  debug "package-dir option set, will use: $package-dir"
fi

mkdir -p "$package_dir"
ln -s $WERCKER_SOURCE_DIR "$GOPATH/src/$dir";
export $WERCKER_SOURCE_DIR="$package_dir"

info "\$WERCKER_SOURCE_DIR now points to: $WERCKER_SOURCE_DIR"
success "Go workspace setup finished"
