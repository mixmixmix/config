set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'Rip-Rip/clang_complete'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'  
let g:ycm_confirm_extra_conf = 0 "using json commands
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_enable_diagnostic_signs = 0

syntax on
 set autowrite
 set autoindent
 set nu
 set guifont=Menlo\ Regular:h15
 set guioptions-=r
 set background=dark
 nnoremap gp `[v`]
set clipboard=unnamed "set the default clipboard being system
 set foldmethod=syntax
 set nofoldenable
 set relativenumber
" set paste "always insert in paste mode, doesn't work with YCM. set nopaste
" exits past mode.
xnoremap p "_dP 
" don't yank when pasting
