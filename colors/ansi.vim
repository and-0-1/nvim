hi clear

let g:colors_name = 'ansi'
set notermguicolors

" This color scheme relies on ANSI colors only. It automatically inherits
" the 16 colors of your terminal color scheme. Set 'background' before
" loading this colorscheme — structural highlights (popups, cursorline,
" statusline, etc.) swap their dark/light ANSI slots accordingly.
"
" 0: Black        │   8: Bright Black (dark gray)
" 1: Red          │   9: Bright Red
" 2: Green        │  10: Bright Green
" 3: Yellow       │  11: Bright Yellow
" 4: Blue         │  12: Bright Blue
" 5: Magenta      │  13: Bright Magenta
" 6: Cyan         │  14: Bright Cyan
" 7: White (gray) │  15: Bright White

" Semantic palette slots that flip with &background:
"   near   = closer to Normal bg (subtle tint)
"   far    = opposite of Normal bg (high-contrast inverse)
"   dim    = mid-tone closer to bg (e.g. comments, separators)
"   bright = mid-tone closer to fg (e.g. fold/sign column)
if &background ==# 'light'
  let s:near   = 15
  let s:far    = 0
  let s:dim    = 7
  let s:bright = 8
else
  let s:near   = 0
  let s:far    = 15
  let s:dim    = 8
  let s:bright = 7
endif

function! s:hi(spec) abort
  let l:s = a:spec
  let l:s = substitute(l:s, '<near>',   s:near,   'g')
  let l:s = substitute(l:s, '<far>',    s:far,    'g')
  let l:s = substitute(l:s, '<dim>',    s:dim,    'g')
  let l:s = substitute(l:s, '<bright>', s:bright, 'g')
  execute 'hi ' . l:s
endfunction

" Editor Elements
highlight Normal guibg=none ctermbg=none
hi Ignore ctermfg=NONE  ctermbg=NONE cterm=NONE
hi Underlined cterm=underline
hi Bold cterm=bold
hi Italic cterm=italic
call s:hi('NonText ctermfg=<near>')
call s:hi('StatusLine ctermfg=<far> ctermbg=<dim> cterm=NONE')
call s:hi('StatusLineNC ctermfg=<far> ctermbg=<near> cterm=NONE')
call s:hi('VertSplit ctermfg=<dim>')
call s:hi('TabLine ctermfg=<bright> ctermbg=<near>')
call s:hi('TabLineFill ctermfg=<near> ctermbg=NONE')
hi TabLineSel ctermfg=0 ctermbg=11
hi Title ctermfg=4 cterm=bold
call s:hi('CursorLine ctermbg=<near> ctermfg=NONE')
call s:hi('Cursor ctermbg=<far> ctermfg=<near>')
call s:hi('CursorColumn ctermbg=<near>')
call s:hi('LineNr ctermfg=<dim>')
hi CursorLineNr ctermfg=6
hi helpLeadBlank ctermbg=NONE ctermfg=NONE
hi helpNormal ctermbg=NONE ctermfg=NONE
call s:hi('Visual ctermbg=<dim> ctermfg=<far> cterm=bold')
call s:hi('VisualNOS ctermbg=<dim> ctermfg=<far> cterm=bold')
call s:hi('Pmenu ctermbg=<near> ctermfg=<far>')
call s:hi('PmenuSbar ctermbg=<dim> ctermfg=<bright>')
call s:hi('PmenuSel ctermbg=<dim> ctermfg=<far> cterm=bold')
call s:hi('PmenuThumb ctermbg=<bright> ctermfg=NONE')
call s:hi('FoldColumn ctermfg=<bright>')
hi Folded ctermfg=12
call s:hi('WildMenu ctermbg=<near> ctermfg=<far> cterm=NONE')
call s:hi('SpecialKey ctermfg=<near>')
hi IncSearch ctermbg=1 ctermfg=0
hi CurSearch ctermbg=3 ctermfg=0
hi Search ctermbg=11 ctermfg=0
hi Directory ctermfg=4
call s:hi('MatchParen ctermbg=<near> ctermfg=3 cterm=underline')
hi SpellBad cterm=undercurl
hi SpellCap cterm=undercurl
hi SpellLocal cterm=undercurl
hi SpellRare cterm=undercurl
call s:hi('ColorColumn ctermbg=<dim>')
call s:hi('SignColumn ctermfg=<bright>')
call s:hi('ModeMsg ctermbg=<far> ctermfg=<near> cterm=bold')
hi MoreMsg ctermfg=4
hi Question ctermfg=4
call s:hi('QuickFixLine ctermbg=<near> ctermfg=14')
call s:hi('Conceal ctermfg=<dim>')
call s:hi('ToolbarLine ctermbg=<near> ctermfg=<far>')
call s:hi('ToolbarButton ctermbg=<dim> ctermfg=<far>')
call s:hi('debugPC ctermfg=<bright>')
call s:hi('debugBreakpoint ctermfg=<dim>')
hi ErrorMsg ctermfg=1 cterm=bold,italic
hi WarningMsg ctermfg=11
hi DiffAdd ctermbg=10 ctermfg=0
hi DiffChange ctermbg=12 ctermfg=0
hi DiffDelete ctermbg=9 ctermfg=0
hi DiffText ctermbg=14 ctermfg=0
hi diffAdded ctermfg=10
hi diffRemoved ctermfg=9
hi diffChanged ctermfg=12
hi diffOldFile ctermfg=11
hi diffNewFile ctermfg=13
hi diffFile ctermfg=12
call s:hi('diffLine ctermfg=<bright>')
hi diffIndexLine ctermfg=14
hi healthError ctermfg=1
hi healthSuccess ctermfg=2
hi healthWarning ctermfg=3

" Syntax
call s:hi('Comment ctermfg=<dim> cterm=italic')
hi Constant ctermfg=3
hi Error ctermfg=1
hi Identifier ctermfg=9
hi Function ctermfg=4
hi Special ctermfg=13
hi Statement ctermfg=5
hi String ctermfg=2
hi Operator ctermfg=6
hi Boolean ctermfg=3
hi Label ctermfg=14
hi Keyword ctermfg=5
hi Exception ctermfg=5
hi Conditional ctermfg=5
hi PreProc ctermfg=13
hi Include ctermfg=5
hi Macro ctermfg=5
hi StorageClass ctermfg=11
hi Structure ctermfg=11
hi Todo ctermfg=0 ctermbg=9 cterm=bold
hi Type ctermfg=11

" neovim-specific (remove if you're using vim)
call s:hi('NormalFloat ctermbg=<near> ctermfg=<far>')
call s:hi('FloatBorder ctermbg=<near> ctermfg=<bright>')
call s:hi('FloatShadow ctermbg=<near> ctermfg=<far>')
