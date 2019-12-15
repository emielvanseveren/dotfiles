" source ~/.dotfiles/vim/splits.vim

"Use Vim settings, rather then Vi settings (much better!)
set nocompatible " This must be first, because it changes other options as a side effect.



set ignorecase
set smartcase
let mapleader = ","   " Sets leader key to ','

"General setting
syntax enable
set termguicolors
set clipboard=unnamed " use the same clipboard as system clipboard
set mouse=a           " Enable the mouse in vim. 
set wildmenu          " Much niver tab completion for commands
set scrolloff=5       " Keep 5 lines below and above the cursor 
set autoread          " Reload files changed outside vim
set visualbell        " No sounds
set gcr=a:blinkon0    " Disable cursor blink
set noswapfile        " No swap files
set nobackup          " No swap files
set nowb              " No swap files

"Spaces and tabs
set tabstop=2         " 2 space tab
set shiftwidth=2    
set softtabstop=2     " 2 space tab
set expandtab         " use spaces for tabs
set smarttab          " insert tabstop number of spaces when the tab key is pressed

"UI Layout
set number          " show line numbers
set showcmd         " show command in bottom bar
set nocursorline    " highlight current line
set showmatch       " highlight matching parenthesis
set lazyredraw      " Don't update screen during macro and script execution.

"Folding
set foldmethod=indent   " Fold based on indention levels
set foldnestmax=3       " Only fold up to three nested levels
set nofoldenable        " Disable folding by default

"Searching
set ignorecase      " ignore case when searching
set incsearch       " search as characters are entered
set hlsearch        " highlight all matches

"Disable arrow keys and break the bad habbit
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
"Move normally between wrapped lines
nmap j gj
nmap k gk

"Vim spell

set spellfile=$HOME/.vim-spell-en.utf-8.add " This will be a symlink to the dotfiles version of the spellfile
autocmd FileType markdown setlocal spell    " Spell check markdown
autocmd FileType gitcommit setlocal spell   " Spell check git commit messages
set complete+=kspell                        " For filetypes with spellcheck available, we'll also support auto-complete.

" Don't count acronyms / abbreviations as spelling errors
" (all upper-case letters, at least three characters)
" Also will not count acronym with 's' at the end a spelling error
" Also will not count numbers that are part of this
" Recognizes the following as correct:
au BufNewFile,BufRead syn match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
au BufNewFile,BufRead syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell

"Vim Plug (pluginmanager)
call plug#begin('~/.vim/plugged')

"General
Plug 'janko-m/vim-test'
Plug 'moll/vim-node'                    " Node support
Plug 'kien/ctrlp.vim'                   " Fuzzy file explorer (literaly open every file
Plug 'scrooloose/syntastic'             " Syntax highlighting
Plug 'scrooloose/nerdtree'              " Tree viewer
Plug 'Xuyuanp/nerdtree-git-plugin'      " Git status for Nerdtree
Plug 'tpope/vim-fugitive'               " Best git wrapper in the world
Plug 'sjl/vitality.vim'                 " Nicer cursor, tmux interactions
Plug 'wakatime/vim-wakatime'            " Track vim activity
Plug 'valloric/youcompleteme'           " Code completion
Plug 'docker/docker'                    " Dockerfile code completion
Plug 'nathanaelkane/vim-indent-guides'  " Shows indents
Plug '907th/vim-auto-save'              " Automatically save cahnges to disk without having to use :w

"Search
Plug 'google/vim-searchindex'           " Show how many times a search pattern occurs in the current buffer.

"Go
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim'}               " Go syntax highlight
Plug 'fatih/vim-go'                                                   " Go support

"Javascript
Plug 'pangloss/vim-javascript'                                        " Javascript syntax highlighting
Plug 'hail2u/vim-css3-syntax'                                         " CSS syntax
Plug 'ap/vim-css-color'                                               " Shows colors
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }  " Styled-components support
Plug 'joegesualdo/jsdoc.vim'                                          " JSDoc support

"Plugins for Markdown
Plug 'godlygeek/tabular'                " Line up text! Needed by Vim markdown.
Plug 'plasticboy/vim-markdown'          " Markdown support

"Theme
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim', {'as': 'dracula'}

"Plugins for other less used languages
Plug 'jparise/vim-graphql'      " GraphQL
Plug 'othree/html5.vim'         " html5 + SVG
Plug 'mzlogin/vim-markdown-toc' " Build a Table Of Content for markdown

call plug#end()

"Syntax Highlighting

"Javascript
let g:jsx_ext_required = 0                          " Support JSX syntax highlighting in *.js, not just *.jsx.
let g:vim_json_syntax_conceal = 0                   " Disable syntax concealing for json files.

"Golang
let g:go_highlight_build_constraints = 0            " Syntax highlighting
let g:go_highlight_extra_types = 1                  " Syntax highlighting
let g:go_highlight_fields = 1                       " Syntax highlighting
let g:go_highlight_functions = 1                    " Syntax highlighting
let g:go_highlight_methods = 1                      " Syntax highlighting
let g:go_highlight_operators = 1                    " Syntax highlighting
let g:go_highlight_structs = 1                      " Syntax highlighting
let g:go_highlight_types = 1                        " Syntax highlighting


"Vim-arline theme
let g:airline_theme = 'deus'
let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_sep = ''

"Vim-indent-guides
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1

"NERDTree
let NerdTreeShowHidden=1                                                                " Show hidden files by default
let NERDTreeQuitOnOpen = 1                                                              " Automatically close if a file is selected
let NERDTreeMinimalUI = 1                                                               " Cleaner UI
let NERDTreeDirArrows = 1                                                               " Arrows to show that you are opening a folder.
let g:NerdTreeIgnore=['\.git$[[dir]]', 'node_modules$[[dir]]', '\.nyc_output$[[dir]]']  " Ignore node_modules and .git files
autocmd StdinReadPre * let s:std_in=1                                                   " Open NERDTree on startup
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif             " Open NERDTree on startup
" NERDTree shortcuts
nmap <leader>t :NERDTreeFind<CR>
nmap <silent> <leader>v :NERDTreeToggle<CR>

"Vim-auto-save
let g:auto_save=1 " Enable AutoSave on startup



"Language specific indentation.
au FileType make      set noexpandtab shiftwidth=8 softtabstop=0 " Makefiles must use tabsa
au FileType yaml      setl  sw=2 sts=2 et


colorscheme dracula
