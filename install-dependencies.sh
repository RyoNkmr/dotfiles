# install xcode-select
xcode-select --install

# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# neovim
brew install --HEAD neovim
pip install --upgrade pynvim
pip3 install --upgrade pynvim

# js LSP
npm i -g javascript-typescript-langserver prettier eslint

# for deoplete-go
go get -u github.com/stamblerre/gocode

# tmux
gem install tmuxinator

# prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
