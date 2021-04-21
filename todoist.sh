mkdir -p $GOPATH/src/github.com/sachaos
cd $GOPATH/src/github.com/sachaos
git clone https://github.com/sachaos/todoist.git
cd todoist
make install

# yay -S peco
# source "$GOPATH/src/github.com/sachaos/todoist/todoist_functions.sh"
