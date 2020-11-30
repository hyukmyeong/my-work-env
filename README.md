OS : ubuntu 20.4

(0) basic installation 

```bash
# git clone https://github.com/hyukmyeong/my-work-env.git
$ cp my-work-env/.vim-8.1 ~/
$ cp my-work-env/.vimrc-8.1 ~/

$ sudo apt remove python3
$ sudo apt remove python3-dev

$ sudo apt install python3.8
$ sudo apt install python3.8-dev

$ sudo apt install clang-10 
$ sudo apt install libclang-10-dev

$ sudo apt install llvm-10
$ sudo apt install llvm-10-dev

$ mkdir go && cd go && curl -O https://storage.googleapis.com/golang/go1.12.9.linux-amd64.tar.gz
$ tar -xvf go1.12.9.linux-amd64.tar.gz
$ sudo chown -R root:root ./go
$ sudo mv go /usr/local
$ export PATH=$PATH:/usr/local/go/bin
```

(1) vim : youcompleteme install (https://github.com/ycm-core/YouCompleteMe)

```bash
# git clone https://github.com/hyukmyeong/my-work-env.git
$ cp my-work-env/.vim-8.1 ~/
$ cp my-work-env/.vimrc-8.1 ~/

$ cd ~/.vim/bundle/youcompleteme
$ ./install.py --clangd-completer
```


(2) emacs : rtags install (https://github.com/Andersbakken/rtags)

```bash
# git clone https://github.com/hyukmyeong/my-work-env.git
$ cp my-work-env/.emacs.d ~/
$ cp ~/.emacs.d/init.el-rtags ~/init.el

$ cd ~/.emacs
$ git clone --recursive https://github.com/Andersbakken/rtags.git
$ cd rtags && cmake . && make

$ vi ~/.bashrc (++ export PATH=$PATH:$HOME/.emacs.d/rtags/bin)
$ vi ~/.bash_profile (++ export PATH=$PATH:$HOME/.emacs.d/rtags/bin)

$ rdm &
$ cd ~/work/src
$ rc -J .
$ emacs
