" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

colorscheme ron

set tabstop=2     "set tablength to 2
set shiftwidth=2  "with << and >> text is indented two spaces
set expandtab     "hitting tab produces the amount of spaces
set autoindent    "indent automatically
set showcmd       "show command in right lower corner while typing
set bg=dark       "tell vim that the background is dark
set number        "show linenumbers
set tags=./tags;/ "to search for tagfiles recursively up to the root-directory
set ignorecase    "ignore case for searches by default
set hlsearch      "enable search highlighting, although this is default on many distros

set spell
set spelllang=en
set spellfile="/home/namnatulco/.vim/spell/en.utf-8.add"

filetype indent on

if exists("did_load_filetypes")                         "only do this after filetype detection finishes
  autocmd FileType c,cpp set foldmethod=syntax          "enable folding for C and C++ files
  autocmd FileType c,cpp set nospell                    "disable spell checking for C and C++ files
  augroup filetypedetect
        autocmd! BufRead,BufNewFile *.md set filetype=markdown "use markdown for .md
        autocmd! BufRead,BufNewFile *.ned set filetype=ned     "use ned.vim for OMNeT++ NED files
        autocmd! BufRead,BufNewFile *.msg set filetype=ned     "use ned.vim for OMNeT++ MSG files
  augroup END
endif


"disable spellcheck to F4
map <F4> :set nospell<CR>
"english spellcheck to F5
map <F5> :set spelllang=en spellfile="/home/namnatulco/.vim/spell/en.utf-8.add"<CR>
"german spellcheck to F6
map <F6> :set spelllang=de_de spellfile="/home/namnatulco/.vim/spell/de.utf-8.add"<CR>
"map file explorer to F2
map <F2> :e .<CR>
"delete trailing spaces with F3
map <special> <F3> :%s/\s\+$//gc<CR>
"map <enter> to remove currently highlighted search results
nnoremap <Space> :noh<CR><Space>
