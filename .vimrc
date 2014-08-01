" -----------------------------------------------------------------------------
" |                               VIM Settings                                |
" |                      (see gvimrc for gui vim settings)                    |
" -----------------------------------------------------------------------------
syntax enable
set background=dark
colorscheme candy

set nocompatible

" Notify VIM we have 256 colors
set t_Co=256 

" Vim info saved between sessions
" '25 - save previous number of marks
" f1 - save global marks
set viminfo+='25,f1

let $VIMRUNTIME='~/bin/vim/vim73_runtime'
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Set map leader
let mapleader=","

" Clipboard Stuff"
function PipeToClipboard() range
        echo system('echo '.shellescape(join(getline(a:firstline,a:lastline))).'| xclip -i')
endfunction
map "+y :call PipeToClipboard()<CR>

" Tabs ************************************************************************
set softtabstop=4
set shiftwidth=4
set tabstop=4

"set expandtab
"set sta " a <Tab> in an indent inserts 'shiftwidth' spaces
:noremap > >><ESC>
:noremap < <<<ESC>

let g:indent_guides_guide_size = 1
let g:indent_guides_space_guides = 0

" The Other Kind of Tabs ************************************************
set showtabline=2
map gl :tabnext<CR>
map gh :tabprev<CR>
map gn :tabnew<CR>
map gd :tabclose<CR>

" Indenting ********************************************************************
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent (local to buffer)

" Aligning ********************************************************************
map <Leader>g :Align =<CR>

" Scrollbars ******************************************************************
set sidescrolloff=1
set numberwidth=4

" Windows *********************************************************************
set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright

" Vertical split then hop to new buffer
:noremap <Leader>nv :vsp<cr>

" Horizontal split
:noremap <Leader>nh :split<cr>
" Window navigation
:noremap <Leader>j <C-W><C-J><cr>
:noremap <Leader>k <C-W><C-K><cr>
:noremap <Leader>h <C-W><C-H><cr>
:noremap <Leader>l <C-W><C-L><cr>

" Quitting all except modified
:noremap <Leader>q :q<CR>

" Removing windows newlines
:noremap <Leader>m :%s/\r//g<CR>

" Allow navigation away from modified buffers 
set hidden

" Toggle unprintable characters
":noremap <Leader>u :set list!<cr>
"set nolist

" Print highlighting of tag used under cursror
:noremap <Leader>s :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" Disbale File Changed Nag ****************************************************
" http://stackoverflow.com/questions/1095708/disable-warning-in-vim
autocmd FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
autocmd FileChangedShell * echohl WarningMsg | echo "File changed shell." | echohl None

:noremap <Leader>b :bp<CR>
:noremap <Leader>f :bn<CR>
:noremap <Leader>1 :1b<CR>
:noremap <Leader>2 :2b<CR>
:noremap <Leader>3 :3b<CR>
:noremap <Leader>4 :4b<CR>
:noremap <Leader>5 :5b<CR>
:noremap <Leader>6 :6b<CR>
:noremap <Leader>7 :7b<CR>
:noremap <Leader>8 :8b<CR>
:noremap <Leader>9 :9b<CR>
:noremap <Leader>0 :10b<CR>

" Auto changing directories
:set autochdir

" Searching *******************************************************************
set hlsearch  " highlight search
set incsearch  " incremental search, search as you type
set ignorecase " Ignore case when searching 
set smartcase " Ignore case when searching lowercase
map <Leader>/ :let @/ =""<CR>

" Will allow you to use :w!! to write to a file using sudo if you forgot to
" 'sudo vim file' (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" Colors **********************************************************************
"set t_Co=256 " 256 colors

" Status Line *****************************************************************
" Highlight group under cursor
" http://vim.wikia.com/wiki/Showing_syntax_highlight_group_in_statusline
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

set statusline=%F%m%r%h%w\ [%l,%c]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [hi=%{SyntaxItem()}]
"Always show status line
set laststatus=2

set showcmd
set ruler " Show ruler
"set ch=2 " Make command line two lines high


" Line Wrapping ***************************************************************
set wrap
set linebreak  " Wrap at word

" File Stuff ******************************************************************
filetype plugin indent on
" To show current filetype use: set filetype

autocmd FileType html :set filetype=xhtml " we couldn't care less about html

" Insert New Line **************************************************************
map <S-Enter> O<ESC> " awesome, inserts new line without going into insert mode
map <Enter> o<ESC>
set fo-=r " do not insert a comment leader after an enter, (no work, fix!!)
                        
" http://stackoverflow.com/questions/607435/why-does-vim-save-files-with-a-extension/607475
" The *.ext~ file is a backup file, containing the file as it was before you 
" edited it.
" The *.ext.swp file is the swap file, which serves as a lock file and contains 
" the undo/redo history as well as any other internal info VIM needs. In case 
" of a crash you can re-open your file and VIM will restore it's previous state 
" from the swap file (which I find helpful, so I don't switch it off).
" To switch off automatic creation of backup files, use (in your vimrc):
set nobackup
set nowritebackup


" Misc ************************************************************************
set backspace=indent,eol,start
set number " Show line numbers
set matchpairs+=<:>
set vb t_vb= " Turn off the bell, this could be more annoying, but I'm not sure how
set novisualbell

" Set list Chars - for showing characters that are not
" normally displayed i.e. whitespace, tabs, EOL
"set listchars=trail:.,tab:>-,eol:$
"set listchars=trail:.,nbsp:.
set nolist
                j       
" Mouse ***********************************************************************
set mouse=a " Enable the mouse
"behave xterm
"set selectmode=mouse


" Cursor Movement *************************************************************
" Make cursor move by visual lines instead of file lines (when wrapping)
map <up> gk
map k gk
imap <up> <C-o>gk
map <down> gj
map j gj
imap <down> <C-o>gj
map E ge

" Tags ***********************************************************************
" Close the vim window when the only window open is the taglist window
let Tlist_Exit_OnlyWindow = 1
" Open the taglist window, gain focus on opening
nnoremap <silent> <Leader>t :TlistToggle<CR>
let Tlist_GainFocus_On_ToggleOpen = 0
let Tlist_Use_Right_Window = 1 
let Tlist_Enable_Fold_Column = 0 
"let Tlist_File_Fold_Auto_Close = 1
let Tlist_Show_One_File = 1 " especially with this one 
let Tlist_Compact_Format = 1 
let Tlist_Use_SingleClick = 1

set tags=TAGS\ tags\ /vob/sectel/sec_sme_vob/code/WINCE500/tags

"let Tlist_Auto_Open = 1
if has("gui_win32")
        :noremap <Leader>e :!D:\reshen\apps\etags\ctags57\ctags -R *.h *.c *.cpp<CR>
        let Tlist_Ctags_Cmd = 'D:\reshen\apps\etags\ctags57\ctags.exe'
else
        :noremap <Leader>e :!ctags -R /vob/sectel/sec_sme_vob/code/WINCE500/PBWorkspaces/GD_COMMON_PROJECTS/HomeScreen/HomeScreen/*.cpp /vob/sectel/sec_sme_vob/code/WINCE500/PBWorkspaces/GD_COMMON_PROJECTS/HomeScreen/HomeScreen/*.h /vob/sectel/sec_sme_vob/code/WINCE500/PBWorkspaces/GD_COMMON_PROJECTS/HomeScreen/Common/*.cpp /vob/sectel/sec_sme_vob/code/WINCE500/PBWorkspaces/GD_COMMON_PROJECTS/HomeScreen/Common/*.h<CR>
endif
set updatetime=1000 

" Replace windows newlines with unix ones
:set magic
:noremap <Leader>w :%s/^M//gc<CR>

" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
"
" " Define file-type dependent dictionaries.
let g:neocomplcache_dictionary_filetype_lists = {
                        \ 'default' : '',
                        \ 'vimshell' : $HOME.'/.vimshell_hist',
                        \ 'scheme' : $HOME.'/.gosh_completions'
                        \ }

" Define keyword, for minor languages
if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

:command! -range=% -nargs=0 T2S execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
:command! -range=% -nargs=0 S2T execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" Ack
let g:ackprg="~/bin/ack -H --nocolor --nogroup --column"

:set noswapfile

let g:ctrlp_custom_ignore = 'eclipse-bin.*'
