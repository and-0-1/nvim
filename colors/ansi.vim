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
  let s:dim    = 7
  let s:bright = 8
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
"call s:hi('StatusLine ctermfg=<far> ctermbg=<near> cterm=NONE')
"call s:hi('StatusLineNC ctermfg=<far> ctermbg=<dim> cterm=NONE')
call s:hi('VertSplit ctermfg=<dim>')
"call s:hi('TabLine ctermfg=<bright> ctermbg=<near>')
"call s:hi('TabLineFill ctermfg=<near> ctermbg=NONE')
"hi TabLineSel ctermfg=0 ctermbg=11
hi Title ctermfg=4 cterm=bold
call s:hi('CursorLine ctermbg=NONE ctermfg=NONE')
call s:hi('Cursor ctermbg=<far> ctermfg=<near>')
call s:hi('CursorColumn ctermbg=<near>')
call s:hi('LineNr ctermfg=<dim>')
hi CursorLineNr ctermfg=6
hi helpLeadBlank ctermbg=NONE ctermfg=NONE
hi helpNormal ctermbg=NONE ctermfg=NONE
call s:hi('Visual ctermbg=<bright> ctermfg=<far> cterm=bold')
call s:hi('VisualNOS ctermbg=<bright> ctermfg=<far> cterm=bold')
"call s:hi('Pmenu ctermbg=<near> ctermfg=<far>')
"call s:hi('PmenuSbar ctermbg=<dim> ctermfg=<bright>')
"call s:hi('PmenuSel ctermbg=<dim> ctermfg=<far> cterm=bold')
"call s:hi('PmenuThumb ctermbg=<bright> ctermfg=NONE')
call s:hi('FoldColumn ctermfg=<bright>')
hi Folded ctermfg=12
call s:hi('WildMenu ctermbg=<near> ctermfg=<far> cterm=NONE')
call s:hi('SpecialKey ctermfg=<near>')
hi IncSearch ctermbg=1 ctermfg=0
hi CurSearch ctermbg=3 ctermfg=0
hi Search ctermbg=11 ctermfg=0
hi Directory ctermfg=4
hi MatchParen ctermfg=0 ctermbg=2
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
hi Comment ctermfg=2 cterm=italic
hi Constant ctermfg=5
hi Identifier ctermfg=7
hi Function ctermfg=7
hi Special ctermfg=7
hi SpecialChar ctermfg=5
hi Statement ctermfg=7 cterm=NONE
hi String ctermfg=6
hi Operator ctermfg=7
hi Boolean ctermfg=14
hi link Label Keyword
hi Keyword ctermfg=15
hi Exception ctermfg=15
hi Conditional ctermfg=15
hi PreProc ctermfg=1
hi Include ctermfg=1
hi Macro ctermfg=7
hi StorageClass ctermfg=1
hi Structure ctermfg=15
hi Todo ctermfg=0 ctermbg=9 cterm=bold
hi Type ctermfg=10

hi link typescriptInterfaceName Type
hi link typescriptTypeReference Type
hi typescriptCall ctermfg=7
hi typescriptIdentifier ctermfg=7
hi typescriptObjectLabel ctermfg=7
hi typescriptFuncCallArg ctermfg=7
hi link typescriptClassStatic Keyword
hi link typescriptDestructureVariable NONE
hi link javascriptLabel Keyword
hi link typescriptArrowFunc Function
hi link tsxAttrib NONE
hi link typescriptPaymentShippingOptionProp NONE
hi link typescriptDOMFormProp NONE
hi link typescriptBOMWindowMethod NONE
hi link typescriptPaymentAddressProp NONE
hi link typescriptNull Keyword
"hi link typescriptStatementKeyword Keyword
hi link typescriptBOMHistoryProp NONE


" neovim-specific (remove if you're using vim)
"call s:hi('NormalFloat ctermbg=<near> ctermfg=<far>')
"call s:hi('FloatBorder ctermbg=<near> ctermfg=<bright>')
"call s:hi('FloatShadow ctermbg=<near> ctermfg=<far>')


"" Treesitter highlighting
"" - allows for more precise syntax highlighting
"" - only available for nvim >0.5
"" - see also :help treesitter-highlight-groups
"
"call s:hi('@variable ctermfg=<far>')
"hi @variable.builtin ctermfg=1
"hi @variable.parameter ctermfg=1
"hi @variable.member ctermfg=1
"hi @constant.builtin ctermfg=5
"hi @string.regexp ctermfg=1
"hi @string.escape ctermfg=6
"hi @string.special.url ctermfg=4 cterm=underline
"hi @string.special.symbol ctermfg=13
"hi @type.builtin ctermfg=3
"hi @property ctermfg=1
"hi @function.builtin ctermfg=5
"hi @constructor ctermfg=11
"hi @keyword.coroutine ctermfg=1
"hi @keyword.function ctermfg=5
"hi @keyword.return ctermfg=5
"hi @keyword.export ctermfg=14
"call s:hi('@punctuation.bracket ctermfg=<far>')
"hi @comment.error ctermbg=9 ctermfg=0
"hi @comment.warning ctermbg=11 ctermfg=0
"hi @comment.todo ctermbg=12 ctermfg=0
"hi @comment.note ctermbg=14 ctermfg=0
"call s:hi('@markup ctermfg=<far>')
"call s:hi('@markup.strong ctermfg=<far> cterm=bold')
"call s:hi('@markup.italic ctermfg=<far> cterm=italic')
"call s:hi('@markup.strikethrough ctermfg=<far> cterm=strikethrough')
"hi @markup.heading ctermfg=4 cterm=bold
"hi @markup.quote ctermfg=6
"hi @markup.math ctermfg=4
"hi @markup.link.url ctermfg=5 cterm=underline
"hi @markup.raw ctermfg=14
"hi @markup.list.checked ctermfg=2
"call s:hi('@markup.list.unchecked ctermfg=<dim>')
"hi @tag ctermfg=5
"hi @tag.builtin ctermfg=6
"hi @tag.attribute ctermfg=4
"hi @tag.delimiter ctermfg=5
"
"hi link @variable.parameter.builtin @variable.parameter
"hi link @constant Constant
"hi link @constant.macro Macro
"hi link @module Structure
"hi link @module.builtin Special
"hi link @label Label
"hi link @string String
"hi link @string.special Special
"hi link @character Character
"hi link @character.special SpecialChar
"hi link @boolean Boolean
"hi link @number Number
"hi link @number.float Float
"hi link @type Type
"hi link @type.definition Type
"hi link @attribute Constant
"hi link @attribute.builtin Constant
"hi link @function Function
"hi link @function.call Function
"hi link @function.method Function
"hi link @function.method.call Function
"hi link @operator Operator
"hi link @keyword Keyword
"hi link @keyword.operator Operator
"hi link @keyword.import Include
"hi link @keyword.type Keyword
"hi link @keyword.modifier Keyword
"hi link @keyword.repeat Repeat
"hi link @keyword.debug Exception
"hi link @keyword.exception Exception
"hi link @keyword.conditional Conditional
"hi link @keyword.conditional.ternary Operator
"hi link @keyword.directive PreProc
"hi link @keyword.directive.define Define
"hi link @punctuation.delimiter Delimiter
"hi link @punctuation.special Special
"hi link @comment Comment
"hi link @comment.documentation Comment
"hi link @markup.underline underline
"hi link @markup.link Tag
"hi link @markup.link.label Label
"hi link @markup.list Special
"hi link @diff.plus diffAdded
"hi link @diff.minus diffRemoved
"hi link @diff.delta diffChanged
