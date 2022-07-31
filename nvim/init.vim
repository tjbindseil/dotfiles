" below is from https://medium.com/geekculture/neovim-configuration-for-beginners-b2116dbbde84

set nocompatible            " disable compatibility to old-time vi                                  
set showmatch               " show matching
set ignorecase              " case insensitive
set mouse=v                 " middle-click paste with
set hlsearch                " highlight search
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
set nobackup
set nowb
set noswapfile              " disable creating swap file

" below is stuff from old vimrc

set noerrorbells
set novisualbell

" Auto-update files changing on disk
set autoread

" Keep 1 line below and above the cursor
set scrolloff=1
" Add a bit extra margin to the left
set foldcolumn=1

" F2 before pasting turns off indentation
set pastetoggle=<F2>

" TODO
" Handy mapping for F4, switch between .cpp and .h file
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" the above was for Sound Devices, alas I will need to decode and recode this
" " currently, it does:
" tc_state_machine/tc_state_machine/src/mk1/fsm.cpp
" to
" tc_state_machine/tc_state_machine/src/mk1/fsm.h
" while it needs to do:
" tc_state_machine/tc_state_machine/src/mk1/fsm.cpp
" to
" tc_state_machine/tc_state_machine/include/tc_state_machine/mk1/fsm.h"

" persistent undo
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/neo-undo
endif

noremap <C-n> :bn<CR>
noremap <C-p> :bp<CR>
noremap <C-d> :bd<CR>
noremap <C-h> :noh<CR>
noremap <C-k> :w<CR>:make<CR>
noremap <C-l> :cclose<CR>
noremap <C-c> :copen<CR>

" stop showing me help when i miss escape
" in fact, just map it to escape
map <F1> <Esc>
imap <F1> <Esc>


" below is plugins (https://github.com/junegunn/vim-plug)

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" plugins here!
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-obsession'
" Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomlion/vim-solidity'
Plug 'airblade/vim-gitgutter'

Plug 'davidhalter/jedi-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plug 'preservim/nerdcommenter'

" this is my language server client (for now)
" https://github.com/autozimu/LanguageClient-neovim
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Initialize plugin system
call plug#end()


" replacing ]q[q]Q[Q for quickfix iteration, previously from Plug 'tpope/vim-unimpaired'
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>
nnoremap ]Q :cfirst<CR>
nnoremap ]Q :clast<CR>

nnoremap ]<space> o<esc>k
nnoremap [<space> O<esc>j



" airline stuff

"""""""""""""" vim-airline settings """"""""""""""""""""""""""""
" show buffers on top (when only one tab)
let g:airline#extensions#tabline#enabled = 1

" show buffer numbers
let g:airline#extensions#tabline#buffer_nr_show = 1

" set theme
"let g:airline_theme='dracula'

" fix fonts
let g:airline_powerline_fonts = 1


""" language client stuff
" Required for operations modifying multiple buffers like rename.
set hidden

" \ 'cpp': ['clangd-12', '--compile-commands-dir=/home/tbindseil/workspace/autoyard/src/tl', '--log=verbose'],
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['clangd-12', '--log=verbose'],
    \ 'py': ['python-language-server'],
    \ }



""""""""""""""" language client stuff
"" taken from c++ versions in docker
"" but I am not able to do that outside docker so just stealing the mappings for now
"" TODO figure out how to bind to both python and c++
"
" Python plugs
"
" nnoremap gd :call jedi#goto_definitions()<CR>
" nnoremap gc :call jedi#completions()<CR> weird, moves the whole screen
" nnoremap gc :call jedi#setup_completion()<CR>
" nnoremap gh :call LanguageClient#textDocument_hover()<CR>
" nnoremap gi :call LanguageClient#textDocument_implementation()<CR>
" nnoremap gr :call LanguageClient#textDocument_rename()<CR>
" nnoremap gs :call LanguageClient#textDocument_signatureHelp()<CR>
" nnoremap gt :call LanguageClient#textDocument_typeDefinition()<CR>
" nnoremap gu :call LanguageClient#textDocument_references()<CR>
" nnoremap gu :call jedi#usages()<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction




let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "0"
