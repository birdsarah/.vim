After initial clone

    $ git submodule update --init

After update

    $ git submodule update

Install jedi inside jedi-vim

    $ cd bundle/jedi-vim
    $ git submodule update --init

Expects powerline installed

    $ sudo dnf install powerline tmux-powerline vim-powerline

Expects powerline fonts installed (old instructions)

    $ wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
    $ sudo mv PowerlineSymbols.otf /usr/share/fonts/
    $ sudo fc-cache -vf
    $ sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

Expects solarized theme to be available
