  
" Vim color file
"
" Author: Michael Böhler <michael@familie-boehler.de>
" Note: Based on the molokai theme
"

hi clear
set background=dark
    
if exists("syntax_on")
  syntax reset
endif

let g:colors_name="hawaii"


hi Normal          guifg=#F8F8F2 guibg=#0F0F0F

hi Comment         guifg=#7E8E91
hi CursorLine                    guibg=#002626
hi CursorColumn                  guibg=#262600
hi ColorColumn                   guibg=#232526
hi LineNr          guifg=#465457 guibg=#232526
hi NonText         guifg=#465457
hi SpecialKey      guifg=#465457

hi MarkedLine   guifg=NONE    guibg=#183692 gui=none

hi Boolean         guifg=#AE81FF
hi Character       guifg=#E6DB74
hi Number          guifg=#AE81FF
hi String          guifg=#E6DB74
hi Conditional     guifg=#F92672               gui=none
hi Constant        guifg=#AE81FF               gui=none
hi Cursor          guifg=#000000 guibg=#F8F8F0
hi Debug           guifg=#BCA3A3               gui=none
hi Define          guifg=#66D9EF
hi Delimiter       guifg=#8F8F8F
hi DiffAdd                       guibg=#13354A
hi DiffChange      guifg=#89807D guibg=#4C4745
hi DiffDelete      guifg=#960050 guibg=#1E0010
hi DiffText                      guibg=#4C4745 gui=italic,none

hi Directory       guifg=#A6E22E               gui=none
hi Error           guifg=#960050 guibg=#1E0010
hi ErrorMsg        guifg=#F92672 guibg=#232526 gui=none
hi Exception       guifg=#A6E22E               gui=none
hi Float           guifg=#AE81FF
hi FoldColumn      guifg=#465457 guibg=#000000
hi Folded          guifg=#465457 guibg=#000000
hi Function        guifg=#A6E22E
hi Identifier      guifg=#FD971F
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000
hi IncSearch    guifg=fg      guibg=#119922 gui=none


hi Keyword         guifg=#FF035C               gui=none
hi Label           guifg=#E6DB74               gui=none
hi Macro           guifg=#C4BE89               gui=italic
hi SpecialKey      guifg=#66D9EF               gui=italic
hi MatchParen      guifg=#000000 guibg=#FD971F gui=none
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74
hi Operator        guifg=#F92672

" complete menu
hi Pmenu           guifg=#66D9EF guibg=#000000
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#66D9EF

hi PreCondit       guifg=#A6E22E               gui=none
hi PreProc         guifg=#A6E22E
hi Question        guifg=#66D9EF               gui=none
hi Repeat          guifg=#FF035C               gui=none
hi Search       guifg=fg      guibg=#4466bb gui=none

" marks
hi SignColumn      guifg=#A6E22E guibg=#232526
hi SpecialChar     guifg=#FF035C               gui=none
hi SpecialComment  guifg=#7E8E91               gui=none
hi Special         guifg=#66D9EF guibg=bg      gui=italic
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi Statement       guifg=#FF035C               gui=none
hi StatusLine      guifg=#455354 guibg=fg      gui=bold
hi StatusLineNC    guifg=#808080 guibg=fg      gui=italic
hi StorageClass    guifg=#FD971F               gui=italic
hi Structure       guifg=#66D9EF
hi Tag             guifg=#FF035C               gui=italic
hi Title           guifg=#ef5939
hi Todo            guifg=#FFFFFF guibg=bg      gui=none

hi Typedef         guifg=#66D9EF
hi Type            guifg=#66D9EF               gui=none
hi Underlined      guifg=#808080               gui=underline
hi Undercurled     guifg=#808080               gui=undercurl

hi VisualNOS                     guibg=#403D3D
hi VertSplit      guifg=#808080 guibg=#080808 gui=none
" hi Visual                        guibg=#403D3D
hi Visual       guifg=NONE    guibg=#004282  gui=none
hi WarningMsg     guifg=#FFFFFF guibg=#333333 gui=none
hi WildMenu       guifg=#66D9EF guibg=#000000

" Special for Statements
hi Kto            guifg=#AE81FF       gui=underline
