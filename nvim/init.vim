set incsearch
set ignorecase
set hlsearch
set noswapfile
set number
set expandtab               " converts tabs to white space
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=4

noremap ]q :cnext<CR>
noremap [q :cprev<CR>
noremap ]Q :cfirst<CR>
noremap [Q :clast<CR>

noremap ]<SPACE> o<ESC>k
noremap [<SPACE> O<ESC>j

noremap <C-h> :noh<CR>

noremap <C-n> :bn<CR>
noremap <C-p> :bp<CR>
noremap <C-d> :bd<CR>

noremap <C-l> :cclose<CR>
noremap <C-c> :copen<CR>

set pastetoggle=<F2>

" persistent undo
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/neo-undo
endif

call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" autoformat tsx
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'sbdchd/neoformat'

call plug#end()

"""""""""""""" vim-airline settings """"""""""""""""""""""""""""
" show buffers on top (when only one tab)
let g:airline#extensions#tabline#enabled = 1
" show buffer numbers
let g:airline#extensions#tabline#buffer_nr_show = 1
" fix fonts
let g:airline_powerline_fonts = 1


" Conqueror of Completion stuff
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> ga :CocCommand tsserver.executeAutofix<CR>
nmap <silent> gn <Plug>(coc-rename)


" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" color stuff...

" This line enables the true color support.
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Note, the above line is ignored in Neovim 0.1.5 above, use this line instead.
set termguicolors

func! s:my_colors_setup() abort
  highlight CocFloating ctermbg=blue" For background color
  highlight CocErrorFloat ctermfg=black " For text color
endfunc

augroup colorscheme_coc_setup | au!
  au VimEnter * call s:my_colors_setup()
augroup END

" from https://github.com/neoclide/coc-tsserver
" for typescript, don't forget to run:
" CocInstall coc-tsserver

" let g:coc_enable_locationlist = 0
" autocmd User CocLocationsChange CocList --normal location
" let coc.preferences.useQuickfixForLocations: true

" brazil stuff
au FileType java call SetWorkspaceFolders()

function! SetWorkspaceFolders() abort
    " Only set g:WorkspaceFolders if it is not already set
    if exists("g:WorkspaceFolders") | return | endif

    if executable("findup")
        let l:ws_dir = trim(system("cd '" . expand("%:h") . "' && findup packageInfo"))
        " Bemol conveniently generates a '$WS_DIR/.bemol/ws_root_folders' file, so let's leverage it
        let l:folders_file = l:ws_dir . "/.bemol/ws_root_folders"
        if filereadable(l:folders_file)
            let l:ws_folders = readfile(l:folders_file)
            let g:WorkspaceFolders = filter(l:ws_folders, "isdirectory(v:val)")
        endif
    else
        throw 'TJTAG 1'
    endif
endfunction



" with new keyboard I keep hitting F1
noremap <F1> <ESC>

" coc will add the closing paren and i need to skip over it (with shift-tab)
inoremap <S-Tab> <esc>la

nmap <silent> gc :'<,'>s/^/\/\/ /g<CR>



" neoformat stuff
let g:neoformat_try_node_exe = 1 " use prettier from node_modules instead of PATH

" auto run format on save for javascript files
autocmd BufWritePre *.ts Neoformat
autocmd BufWritePre *.js Neoformat
autocmd BufWritePre *.json Neoformat


" (inspired by
" https://stackoverflow.com/questions/71085585/eslint-vim-or-neovim-workflow)
"
" ok, to run eslint and iterate through issues via the quickfix list:
" :compiler eslint
" :make
" :cn / :cp
"
" but, to make this work, I modified the compiler that was installed,
" ie, I modified /Users/tj/nvim-macos/share/nvim/runtime/compiler/eslint.vim
" such that it runs my lint script defined in package.json
