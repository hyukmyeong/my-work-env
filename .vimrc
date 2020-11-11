"============================================================================
" Basic options
"============================================================================
set number                  "nu : show line
set smartcase
set ruler                   "ru : inform cursor position in right below side
set nowrapscan
"set background=dark
set ignorecase              "dont distinguish capital and little during searching
set hlsearch                "highlight to searched string"
set showmatch               "show coupled pharenthisis
set magic                   "use special character in searching pattern
set title
set nobackup                "dont make backup file
set noswapfile              "dont make backup file
"set backupdir=~/.vim/temp/backup
"set directory=~/.vim/temp/swap
set cursorline              "show curson location at the time
set sc                      "show command under the window
set fdm=manual              "code editing way : manual, indent, expr, marker, syntax, diff
set fencs=utf-8,euc-kr,cp949,cp932,euc-jp,shift-jis,big5,latin1,ucs-2le
set enc=utf-8
set tenc=utf-8
set encoding=utf-8
set nocul                   "highlighting word on cursor
set fileformat=unix
set mouse=a
set backspace=indent,eol,start whichwrap+=<,>,[,]
set belloff=all
"set km=startsel,stopesel    "use shift to select blocks
set path+=~/src/current/android/kernel/include/**;
"filetype on
filetype plugin indent on
let mapleader = ";"
"set paste
"set guioptions=gmrL        "eliminate tool box
"set guifont=Dina:h9:cANSI
"set comments=sl:/*,mb:*,elx:*/
"set loadplugins
"set mousemodel=popup
"set visualbell             "vb : there will be visual effect rather than beeping when you input wrong key
"set comments=sl:/*,mb:*,elx:*/
"set loadplugins
"set fillchars+=stl:\ ,stlnc:\
"au BufWritePost *.c,*.cpp,*.h silent! !ctags -R &
set helplang=ko


"============================================================================
" Mikki Command 
"============================================================================
":%!xxd : show as hex
":%!xxd -r : show as text

"============================================================================
" Basic Exec
"============================================================================
"call feedkeys(":NERDTree\<cr>", 'n')
"call feedkeys(":Tlist\<cr>", 'n')


"============================================================================
" Color
"============================================================================
"colorscheme torte
"colorscheme ambient 
"colorscheme molokai
"
set t_Co=256
syntax on
colorscheme minimalist

"hi ModeMsg ctermfg=2 ctermbg=0
"hi Todo ctermfg=4 ctermbg=0
"hi Include ctermfg=4 ctermbg=0
"hi PreProc ctermfg=4 ctermbg=0
"hi Comment ctermfg=4 ctermbg=0
"hi Normal ctermfg=6 ctermbg=0
"hi Type ctermfg=6 ctermbg=0
"hi Function ctermfg=3 ctermbg=0
"hi Special ctermfg=3 ctermbg=0
"hi Statement ctermfg=6 ctermbg=0
"hi Pmenu ctermbg=1
"hi Title ctermfg=4 ctermbg=0
"hi treePart ctermfg=2 ctermbg=0
"hi treeDir ctermfg=2 ctermbg=0
"hi treeFile ctermfg=4 ctermbg=0
"hi Search term=reverse ctermfg=9 ctermbg=1

"xming setting
"colorscheme jellybeans
"syntax on
"hi ModeMsg ctermfg=2 ctermbg=0

"============================================================================
" for Fun
"============================================================================
"source ~/.vim/plugin/tetris.vim


"============================================================================
" Toggle Key options
"============================================================================
"nmap <F2> :bp<cr>
"nmap <F3> :bn<cr>
nmap <F2> <C-W>p 
nmap <F3> <C-W>b 
nmap <F4> :w!<cr>
nmap <F5> :A<cr>
nmap <F6> :marks<cr>
nmap <F7> <Leader>bv
nmap <F8> z.:TlistSync<cr>
"nmap <F9> :mkview<cr>:qa!<cr>
"nmap <F10> :NERDTreeToggle<cr>:TlistToggle<cr>:SrcExplToggle<cr>
nmap <F9> :NERDTreeToggle<cr>:TlistToggle<cr>
"nmap <F11> :mkview<cr>:qa<cr>
"nmap <F12> :mkview<cr>:q!<cr>:q!<cr>:q!<cr>:q!<cr>:q!<cr>
nmap <F11> :%s/from/to/gc
nmap <F12> :qa!<cr>
"nmap <F7> :MarksBrowser<cr>
"nmap <F7> :help functions<cr>
"nmap <F11> :gitv<cr>

nmap <PageUp> :bp<cr>
nmap <PageDown> :bn<cr>

noremap <C-A> gg<S-V>G
inoremap <C-A> <C-O>gg<C-O><S-V>G

map <leader>sp :sp<cr>
map <leader>vs :vs<cr>

map <leader>tt :tabnew<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tc :tabclose<cr>

nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

"make src.i before using below
"nmap <C-I> :vs<cr> echon system('grep -A2 -B2 "$(sed -n '.line(".").'p '.expand("%:p").'\|sed -e "s/^[ \t]\+//;s/\([]\*\.[]\)/\\\\\1/g;s/\(__\)\?[a-z][a-z_0-9]*(\(([u2346])\)\?[^)]*)/.*/g;s/__[a-z]\+/.*/g;s/[A-Z][A-Z_0-9]*/.*/g")" '.expand("%:p:r").'.i')<CR>
"nmap <C-O> :vs<cr> echon system('grep -A2 -B2 "$(sed -n '.line(".").'p '.expand("%:p").'\|sed -e "s/^[ \t]\+//;s/\([]\*\.[]\)/\\\\\1/g;s/[A-Z][A-Z_0-9]*/.*/g")" '.expand("%:p:r").'.i')<CR>

vnoremap <BS> d
vmap <Tab> >gv
vmap <S-Tab> <gv

cnoremap <C-A>		<Home>      "start of line
cnoremap <C-B>		<Left>      "back one character
cnoremap <C-D>		<Del>       "delete character under cursor
cnoremap <C-E>		<End>       "end of line
cnoremap <C-F>		<Right>     "forward one character
cnoremap <C-N>		<Down>      "recall newer command-line
cnoremap <C-P>		<Up>        "recall previous (older) command-line
cnoremap <Esc><C-B>	<S-Left>    "back one word
cnoremap <Esc><C-F>	<S-Right>   "forward one word

"terminal mode
tnoremap <ESC><ESC> <C-\><C-N>
tnoremap <C-H> <C-W>h
tnoremap <C-J> <C-W>j
tnoremap <C-K> <C-W>k
tnoremap <C-L> <C-W>l


"============================================================================
" removes trailing spaces
"============================================================================
"function! TrimWhiteSpace()
"	    %s/\s\+$//e
"endfunction

"autocmd FileWritePre    * :call TrimWhiteSpace()
"autocmd FileAppendPre   * :call TrimWhiteSpace()
"autocmd FilterWritePre  * :call TrimWhiteSpace()
"autocmd BufWritePre     * :call TrimWhiteSpace()


"============================================================================
" Plugin, ETC.
"============================================================================
let marksCloseWhenSeleted=0


"============================================================================
" Snippets initialization
"============================================================================
"let g:snipMate = {}
"let g:snipMate.scope_aliases = {}
"let g:snipMate.scope_aliases['dosbatch'] = 'dosbatch,bat'
autocmd BufNewFile,BufRead *.bat set filetype=bat


"============================================================================
" indent color
"============================================================================
"let g:indent_guides_auto_colors = 0
"let g:indent_guides_autocmds_enabled = 1
"autocmd VimEnter,Colorscheme * call indent_guides#enable()
"au VimEnter * :IndentGuidesEnable
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=green
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=white
"let g:indent_guides_start_level = 2
"let g:indent_guides_guide_size = 1


"============================================================================
" taglist, SrcExplorer, NERDTree initialization
"============================================================================
"let Tlist_Use_Right_Window=1
let Tlist_Use_Left_Window=1
let Tlist_Inc_WinWidth=0
let Tlist_Auto_Open=1
let Tlist_Auto_Update=1

let NERDTreeWinPos = "right"
let g:srcExpl_winHeight=8
let g:srcExpl_refreshTime=100
let g:srcExpl_jumpKey="<ENTER>"
let g:SrcExpl_gobackKey="<SPACE>"
let g:SrcExpl_searchLocalDef=1
let g:SrcExpl_isUpdateTags=0
let g:SrcExpl_updateTagsCmd="ctags --sort=foldcase -R ."
let g:SrcExpl_updateTagsKey="<F11>"

let g:SrcExpl_pluginList=[
  \ "__Tag_List__",
  \ "_NERD_tree_",
  \ "Source_Explorer"
\ ]


"============================================================================
" FuzzyFinder initialization
"============================================================================
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|swp|class|pyc|orig)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_ignoreCase = 0
"map <leader>ff :FufFile .\*/\*/\*/
map <leader>ff :FufFile ./**/<cr>
map <leader>fd :FufDir **/<cr>
map <leader>fm :FufMruCmd<cr>
map <leader>fb :FufBuffer <cr>



"============================================================================
" OmniCppComplete initialization
"============================================================================
" -- optional --
" auto close options when exiting insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
set completeopt=menu,menuone

" -- configs --
let OmmniCpp_GlobalScopeSearch = 1 " search namespaces in this and included files
let OmniCpp_NamespaceSearch = 1
let OmniCpp_DisplayMode = 0
let OmniCpp_ShowScopeInAbbr = 0
let OmniCpp_ShowPrototypeInAbbr = 0       "show function prototype (i.e. parameters) in popup window
let OmniCpp_ShowAccess = 1
let OmniCpp_DefaultNamespaces = []
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 0
let OmniCpp_LocalSearchDecl = 0


"============================================================================
" ctags initialization
"============================================================================
set tags=./tags,tags
set tags+=/usr/src/linux-headers-2.6.35-25-generic/tags
"set tags+=/home001/hyuk.myeong/ICS_cayman/android/kernel/tags
"set tags+=/home001/hyuk.myeong/ICS_cayman/android/device/lge/tags
"set tags+=/home001/hyuk.myeong/ICS_cayman/android/device/common/tags
"set tags+=/home001/hyuk.myeong/ICS_cayman/bootable/bootloader/lk/tags
"set tags+=/home001/hyuk.myeong/ICS_cayman/vendor/lge/tags


"============================================================================
" cscope initialization
"============================================================================
"cscope reset
"cscope show
"cscope kill
"cscope add

if has("cscope")
       set csprg=/usr/bin/cscope
       set csto=0
       set cst
       set nocsverb
       set cscopetag

       if filereadable("./cscope.out")
         cs add ./cscope.out . -C
       elseif filereadable("../cscope.out")
         cs add ../cscope.out . -C
       elseif filereadable("../../cscope.out")
         cs add ../../cscope.out . -C
       elseif filereadable("../../../cscope.out")
         cs add ../../../cscope.out . -C
       elseif filereadable("../../../../cscope.out")
         cs add ../../../../cscope.out . -C
       elseif filereadable("../../../../../cscope.out")
         cs add ../../../../../cscope.out . -C
       elseif filereadable("../../../../../../cscope.out")
         cs add ../../../../../../cscope.out . -C
       else
         cs add /usr/src/linux/cscope.out
       endif

"       if $CSCOPE_DB != ""
"              cs add $CSCOPE_DB
"       endif

       if version >= 500
         func! Sts()
           let st = expand("<cword>")
           exe "sts ".st
         endfunc
         nmap ;st :call Sts()<cr>

         func! Tj()
           let tj = expand("<cword>")
           exe "tj ".tj
         endfunc
         nmap ;tj :call Tj()<cr>
       endif

       func! Css()
         let css = expand("<cword>")
"         new
         exe "cs find s .*".css

         if getline(1) == ""
           exe "q!"
         endif
       endfunc
       nmap ;css :call Css()<cr>

       func! Csc()
         let csc = expand("<cword>")
"         new
         exe "cs find c .*".csc

         if getline(1) == ""
           exe "q!"
         endif
       endfunc
       nmap ;csc :call Csc()<cr>

       func! Csd()
         let csd = expand("<cword>")
"         new
         exe "cs find d .*".csd

         if getline(1) == ""
           exe "q!"
         endif
       endfunc
       nmap ;csd :call Csd()<cr>

       func! Csg()
         let csg = expand("<cword>")
"         new
         exe "cs find g .*".csg

         if getline(1) == ""
           exe "q!"
         endif
       endfunc
       nmap ;csg :call Csg()<cr>
endif

"============================================================================
" Functions
"============================================================================
let s:paren_hl_on = 0
function s:Highlight_Matching_Paren()
	if s:paren_hl_on
		match none
		let s:paren_hl_on = 0
	endif

	let c_lnum = line('.')
	let c_col = col('.')

	let c = getline(c_lnum)[c_col - 1]
	let plist = split(&matchpairs, ':\|,')
	let i = index(plist, c)
	if i < 0
		return
	endif
	if i % 2 == 0
		let s_flags = 'nW'
		let c2 = plist[i + 1]
	else
		let s_flags = 'nbW'
		let c2 = c
		let c = plist[i - 1]
	endif
	if c == '['
		let c = '\['
		let c2 = '\]'
	endif
	let s_skip ='synIDattr(synID(line("."), col("."), 0), "name") ' .
	\ '=~?	"string\\|comment"'
	execute 'if' s_skip '| let s_skip = 0 | endif'

	let [m_lnum, m_col] = searchpairpos(c, '', c2, s_flags, s_skip)

	if m_lnum > 0 && m_lnum >= line('w0') && m_lnum <= line('w$')
		exe 'match Search /\(\%' . c_lnum . 'l\%' . c_col .
		\ 'c\)\|\(\%' . m_lnum . 'l\%' . m_col . 'c\)/'
		let s:paren_hl_on = 1
	endif
endfunction

autocmd CursorMoved,CursorMovedI * call s:Highlight_Matching_Paren()
autocmd InsertEnter * match none
