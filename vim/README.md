This is the setup for my vim plugins and themes.
I'm using vim 8.0 as the reference version, so no plugin manager necessary.

Current List
------------
1. vim-airline
2. vim-airline-themes
3. vim-fugitive
4. jedi-vim
5. ctrlp
6. vim-gitgutter
7. ALE
8. vim-virtualenv

Installing a plugin:
--------------------

1. we already did `git submodule init`
2. `git submodule add <ssh to repo for plugin> pack/daherr/start/<plugin-name>`
3. `git add .` from the main directory
4. `git commit -m '<some message here>'`

Update packages:
----------------
1. `git submodule update --remote --merge`
2. `git commit`

Remove a package:
-----------------
`git submodule deinit pack/daherr/start/<plugin-name>`
`git rm pack/daherr/start/<plugin-name>`
`rm -Rf .git/modules/pack/daherr/start/<plugin-name>`
`git commit`

* these are taken from [vim: so long pathogen, hello native package loading](https://shapeshed.com/vim-packages)

We also need pathogen for the right fonts. Installed as follows:
`git clone https://github.com/powerline/fonts.git --depth=1```
`cd fonts`
`./install.sh`
`cd ..`
`rm -rf fonts`

Then: in the terminal, set your font to be one of the powerline fonts. I'm using Source Code Mono.
In vimrc: `let g:airline_powerline_fonts=1`

2017-11-21:
----------

Changes based on this post: [How I use Vim](https://boddy.im/vim-dev-env.html)

1. Added vim-gitgutter, ctrlp, ALE, vim-virtualenv.
2. ALE package requires autopep8 for linting and fixing. Need to install it as well: `pip3.6 install --upgrade autopep8`
3. vim-gitgutter also did a bunch of changes to `.gitconfig` to use vimdiff as a diff tool.

TODO:
-----
1. add shell scripts to handle all of the installation on a new system including pip and font stuff.
2. handle username in the vim directory.
3. Insure you have installed vim8 on the system (no need to compile).
