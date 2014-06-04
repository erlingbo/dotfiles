
filetype off
" Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Enabled file type detection
filetype plugin indent on

"
"    Misc settings/defaults
" ========================================================================== "
"
syntax on                       " I like syntax hilight. Can't code without it.
set t_Co=256                    " Explicitly tell vim that the terminal has 256 colors
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-8859-1
set autoindent                  " Always set autoindenting on
set shiftwidth=4                " How many columns to insert with indent keys (<<)
set softtabstop=4               " How many columns to insert when pressing Tab-key
set tabstop=4                   " Number of coloumns to indent
set expandtab                   " Set spaces instead of <tab>
set wrap                        " Text wrapping on
set textwidth=109                " Wrap words by default
set colorcolumn=110              " Color long lines
set formatoptions=qrn1          " When to wrap text, and how
set modelines=0                 " Dont use modelines, disable to prevent security issues
set nocompatible                " Use Vim defaults instead of vi compatibility
set backspace=indent,eol,start  " more powerful backspacing
set wildmenu
set wildmode=list:longest       " File completion in a menu
set cursorline                  " Indicate what line we are on
set ttyfast                     " We are on a quick terminal
set laststatus=2                " Show a statusline all the time
set relativenumber              " Show numbers in column
set ignorecase                  " Defaults on search
set smartcase                   " Smarter search when applying upper case letters
set nobackup                    " Don't keep a backup file
set viminfo='20,\"50            " read/write a .viminfo file, don't store more than 50 lines of registers
set hlsearch                    " Hilight last search
set history=50                  " keep 50 lines of command line history
set ruler                       " show the cursor position all the time
set showcmd                     " Show (partial) command in status line.
set showmatch                   " Show matching brackets.
set showmode                    " Show mode we are in
set visualbell                  " Blink, no sound
set pastetoggle=<F2>            " Press F2 to enter paste mode
set errorformat=%f:%l:\ %m      "
set number                      " Show line numbers
set norelativenumber            " Use absolute line numbers

set autowrite                   " Save before :make, :suspend, etc
"set noerrorbells                " Stop beeping!
set shell=bash                   " We use bash
set showbreak=↪
set scrolljump=7

let mapleader = ","
let maplocalleader = ";"

" Set backup dir where all backup files are stored. Note: unnecessary if 'nobackup' is set.
set backupdir=$HOME/.vim/backups
set dir=$HOME/.vim/backups

" Suffixes that get lower priority when doing tab completion
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Automatically cd into the directory that the opened file is in
"au BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Automatically reload .vimrc when changed
"au! bufwritepost .vimrc source %
"
" Hilights trailing whitespace
match ErrorMsg /\s\+$/
" Highlights tab characters
highlight Tabs term=bold ctermfg=7 ctermbg=0
2match Tabs /\t/

let g:Powerline_symbols = 'unicode'   " unicode, compatible, fancy
"let g:Powerline_theme = 'distinguished' " distinguished, solarized

let g:syntastic_python_checker = 'pyflakes'


"    Looks
" ========================================================================== "
"
" We have a dark background
set background=dark

highlight clear

" Add hilight before colorscheme
au ColorScheme * highlight ExtraWhitespace ctermbg=red

"colorscheme xoria256
colorscheme molokai

" Color tweaks
"hi Comment ctermfg=DarkGray
"hi LineNr ctermfg=DarkGreen



"    Mappings
" ========================================================================== "
"

" Sane regexp (very magical)
nnoremap / /\v
vnoremap / /\v

" Redraw window so search terms are centered
nnoremap n nzz
nnoremap N Nzz

" Yank selection to system clipboard
vnoremap Y "*y

" Create header lines
nnoremap <leader>1 yypVr=
nnoremap <leader>2 yypVr-

" Clear hilights
nnoremap <leader><space> :noh<CR>

" Select recently pasted text
nnoremap <leader>v V`]

" Use tab to jump to next matching bracket
nnoremap <tab> %
vnoremap <tab> %

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" jj in insert mode mapped as Esc, and same with F1
inoremap jj <Esc>
map <F1> <Esc>
imap <F1> <Esc>

" hh in insert mode mapped as Esc + Write
inoremap hh <Esc>:w<CR>

" Command to remove trailing whitespaces
"command Tws %s/\s\+$//
nnoremap <leader>wsr :%s/\s\+$//<CR>

" Tired of forgetting sudo.
cmap w!! w !sudo tee %

" Tab navigation like Firefox
nmap <C-S-tab> :tabprevious<CR>
nmap <C-tab> :tabnext<CR>
map <C-S-tab> :tabprevious<CR>
map <C-tab> :tabnext<CR>
imap <C-S-tab> <ESC>:tabprevious<CR>i
imap <C-tab> <ESC>:tabnext<CR>i
nmap <C-t> :tabnew<CR>
imap <C-t> <ESC>:tabnew<CR>

" Toggle line wrapping
:map <F3> :set nowrap!<CR>

" Toggle line length warning when 79 chars long
nnoremap <silent> <F4>
      \ :if exists('w:long_line_match') <Bar>
      \   silent! call matchdelete(w:long_line_match) <Bar>
      \   unlet w:long_line_match <Bar>
      \ elseif &textwidth > 0 <Bar>
      \   let w:long_line_match = matchadd('ErrorMsg', '\%>'.&tw.'v.\+', -1) <Bar>
      \ else <Bar>
      \   let w:long_line_match = matchadd('ErrorMsg', '\%>79v.\+', -1) <Bar>
      \ endif<CR>

" Gundo
map <leader>u :GundoToggle<CR>

" NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
" Close NERDTree it is the last remaining buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif



"    Language specific settings
" ========================================================================== "
"

" Remove trailing whitespace on save
au BufWritePre *.py :%s/\s\+$//e
au BufWritePre *.js :%s/\s\+$//e

" No text wrap for urls.py
au BufNewFile,BufRead urls.py      setlocal nowrap

" Set filetype for Django files
au BufNewFile,BufRead *.html       setlocal filetype=htmldjango
au BufNewFile,BufRead admin.py     setlocal filetype=python.django
au BufNewFile,BufRead urls.py      setlocal filetype=python.django
au BufNewFile,BufRead models.py    setlocal filetype=python.django
au BufNewFile,BufRead views.py     setlocal filetype=python.django
au BufNewFile,BufRead settings.py  setlocal filetype=python.django
au BufNewFile,BufRead forms.py     setlocal filetype=python.django

"au FileType ruby,eruby,yaml,html,css,js set shiftwidth=2 sts=2 expandtab
" au BufNewFile,BufRead mutt* set tw=77 ai nocindent fileencoding=utf-8
au FileType javascript :setlocal sw=2 ts=2 sts=2
au FileType html :setlocal sw=2 ts=2 sts=2

nnoremap _pd :set ft=python.django<CR>

" Linting
au FileType python nnoremap <leader>lp :!pylint % -i y -r n -f parseable<CR>
au BufRead *.xml nnoremap <leader>x :%w !xmllint --valid --noout -<CR>
" Requires jshint.vim plugin
au FileType javascript nnoremap <leader>l :JSHintUpdate<CR>
let g:JSLintHighlightErrorLine = 0


" Django template comments surround with -
" 45 is ASCII for - to see, use :echo char2nr("-")
au FileType htmldjango let b:surround_45 = "{# \r #}"

" Django template shortcuts
au FileType htmldjango inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>
au FileType htmldjango inoremap <buffer> <c-f> {{<space><space>}}<left><left><left>



" Transparent editing of gpg encrypted files
" By Wouter Hanegraaff <wouter@blub.net>
"augroup encrypted
"    au!
"
"    " First make sure nothing is written to ~/.viminfo while editing
"    " an encrypted file.
"    autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
"    " We don't want a swap file, as it writes unencrypted data to disk
"    autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
"    " Switch to binary mode to read the encrypted file
"    autocmd BufReadPre,FileReadPre      *.gpg set bin
"    autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
"    autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null
"    " Switch to normal mode for editing
"    autocmd BufReadPost,FileReadPost    *.gpg set nobin
"    autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
"    autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
"
"    " Convert all text to encrypted text before writing
"    autocmd BufWritePre,FileWritePre    *.gpg   '[,']!gpg --default-recipient-self -ae 2>/dev/null
"    " Undo the encryption so we are back in the normal text, directly
"    " after the file has been written.
"    autocmd BufWritePost,FileWritePost    *.gpg   u
"augroup END
