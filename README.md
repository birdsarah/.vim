After initial clone

    $ git submodule update --init

After update

    $ git submodule update

Expects powerline in /usr/local/lib - [stackoverflow](http://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin)

    $ pip install git+git://github.com/Lokaltog/powerline
    $ wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
    $ sudo mv PowerlineSymbols.otf /usr/share/fonts/
    $ sudo fc-cache -vf
    $ sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

Expects solarized theme to be available
