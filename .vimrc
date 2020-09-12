" basic vim stuff
set tabstop=4 shiftwidth=4 expandtab
set ignorecase
set number

" highlight stuff
set hlsearch
noremap <C-h> :noh<CR>

" buffer stuff
noremap <C-n> :bn<CR>
noremap <C-p> :bp<CR>
noremap <C-d> :bd<CR>

colorscheme elflord

set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir

" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" then open vim, and run :PlugInstall
call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-unimpaired'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
Plug 'OmniSharp/omnisharp-vim' 

call plug#end()
