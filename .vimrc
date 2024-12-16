" Daniel Collier's .vimrc ! 

"-----------------misc--------------
set belloff=all " Turn off the annoying bell sound.
set ruler " Show line number and column number in the status bar.
set tags=tags; " Enable ctags - ctags must be installed and a tag file must be generated in the root folder.
set showmatch " Highlight matching parenthesis.
set autoread " Auto reload when a file changes externally. (You must alt+tab away and back to vim for it to be loaded) 
set clipboard=unnamed " Vim does not share its clipboard with the OS by default. Lets shared the clipboard to avoid \"*p and \"*y
set scrolloff=15  " Start scrolling 5 lines before top or bottom
set spell " Enable spell checking.
set nobackup
set noswapfile
set noundofile
au GUIEnter * simalt ~x " Set vim to fullscreen when it is started.
set encoding=utf-8
let mapleader = "" " map leader to default (which is backslash)
set nofoldenable " disable code folder. I find it annoying when dealing with merges.
set nonumber " disable line numbers.
set guioptions-=T
set guioptions-=m
set wrap


"Press cp in normal mode to copy the full filepath of the current buffer to the Windows Clipboard.
nnoremap cp :let @* = expand("%:p")<CR>
"------------------------------------

"---------------netrw----------------
let g:netrw_banner=0 " Remove the banner.
let g:netrw_winsize = 25 " Set netrw window initial size to 25% of the page.
let g:netrw_keepdir = 0
"------------------------------------

"---------------remap----------------
" Switch between buffers
" Ctrl + Tab         = next buffer
" Ctrl + Shift + Tab = previous buffer
nnoremap <c-Tab> :bnext<CR>
nnoremap <c-s-Tab> :bprevious<CR>

" Typing :noh every time I do a seach is annoying.
" Now, pressing SPACE after a seach will clear all
" highlighted matches.
map <Space> :noh<cr>

" Tab navigation:
" Ctrl + t = new tab
" Ctrl + j = left traverse of tabs
" Ctrl + k = right traverse of tabs
nnoremap <c-t> :tabnew<CR> " 
inoremap <c-t> <Esc>:tabnew<CR>
nnoremap <c-j> gT
nnoremap <c-k> gt
"------------------------------------

"--------------macros----------------
"C++
let @i = 'o#include ""' "@i adds an empty #include
let @o = 'o#include <>' "@o adds and empty #include <>
let @l = 'LOG(INFO) << "qqqqq: func=" << __FUNCTION_ <<  " line=" << __LINE__;' " debug log

let @h = ':e %<.h' "@h switches to the .h file of the same name as the current files.
let @c = ':e %<.cc' "@c switched to the .cc file of the same name as the current file.
let @t = 'o#include <chrono>' . "\<Esc>o" .
\ 'std::chrono::time_point<std::chrono::steady_clock> start_time;' . "\<Esc>o" .
\ 'std::chrono::time_point<std::chrono::steady_clock> end_time;' . "\<Esc>o" .
\ '// Function to start timing' . "\<Esc>o" .
\ 'void djc_start_time() {' . "\<Esc>o" .
\ '    start_time = std::chrono::steady_clock::now();' . "\<Esc>o" .
\ '}' . "\<Esc>o" .
\ '// Function to stop timing and calculate duration' . "\<Esc>o" .
\ 'void djc_end_time(std::string a) {' . "\<Esc>o" .
\ '    end_time = std::chrono::steady_clock::now();' . "\<Esc>o" .
\ '    LOG(INFO) << "qqqqq: " << a << " took - " << std::chrono::duration_cast<std::chrono::microseconds>(end_time - start_time).count() << "us";' . "\<Esc>o" .
\ '}'

function! DeleteMatchingLines()
    let saved_cursor = getpos('.')
    let current_line = getline('.')
    execute 'g/\V' . substitute(current_line, '/', '\\/', 'g') . '/d'
    call setpos('.', saved_cursor)
endfunction
let @d=':call DeleteMatchingLines()<CR>'

"Misc
let @v = ':vs $MYGVIMRC' "@v open .vimrc
"------------------------------------

"-----------Commands----------------
command AdjustEndOfLine execute '%s/\r\(\n\)/\1/g'
"------------------------------------

"------------formatting--------------
set tabstop=2
set shiftwidth=2
set expandtab
"------------------------------------

"------------green theme-------------
set guifont=Cascadia_Mono:h15
:set background=dark

highlight clear
if exists("syntax_on")
	syntax reset
endif

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight! Default guifg=#d6b48b guibg=#042327 gui=NONE
highlight! Normal guifg=#d6b48b guibg=#042327 gui=NONE
highlight! Comment guifg=#31B72C guibg=NONE gui=NONE
highlight! link Constant Statement
highlight! String guifg=#2ca198 guibg=NONE gui=NONE
highlight! link Character Number
highlight! Number guifg=#70c5bf guibg=NONE gui=NONE
highlight! link Boolean Number
highlight! link Float Number
highlight! link Identifier Default
highlight! Statement guifg=#ffffff guibg=NONE gui=NONE
highlight! link Operator Default
highlight! PreProc guifg=#9DE3C0 guibg=NONE gui=NONE
highlight! link Type PreProc
highlight! link Special Default
highlight! link SpecialChar String
highlight SpecialComment guifg=#87875f guibg=NONE gui=reverse
highlight Underlined guifg=#af5f5f guibg=NONE gui=NONE
highlight! link Todo Comment
highlight link Title Default
highlight Cursor guibg=NONE guifg=NONE gui=reverse
highlight MoreMsg guifg=#dfaf87 guibg=NONE gui=NONE
highlight Visual guifg=#dfdfaf guibg=#888888 gui=NONE
highlight Question guifg=#875f5f guibg=NONE gui=NONE
highlight Search guifg=#dfdfaf guibg=#878787 gui=NONE
highlight PmenuSel guifg=#dfdfaf guibg=#875f5f gui=NONE
highlight MatchParen guifg=#dfdfaf guibg=#875f5f gui=NONE
highlight VertSplit guifg=#000000 guibg=NONE gui=NONE
highlight! String guifg=#2ec09c guibg=NONE gui=NONE
highlight DiffAdd gui=none guifg=#000000 guibg=#bada9f
highlight DiffChange gui=none guifg=#000000 guibg=#e5d5ac
highlight DiffDelete gui=bold guifg=#000000 guibg=#ffb0b0
highlight DiffText gui=none guifg=#000000 guibg=#e5d5ac


" Syntax highlighting for my C language defines.
" Keywords:
" internal, persist
"
" Types:
" u8, u16, u32, u64, i8, i16, i32, i64, f32, f64
augroup InternalHighlight
  autocmd!
  autocmd FileType c,cpp setlocal iskeyword+=_

  " Keywords
  autocmd FileType c,cpp syntax match InternalKeyword /\<internal\>/ containedin=ALL
  autocmd FileType c,cpp highlight InternalKeyword guifg=#9de3c0
  autocmd FileType c,cpp syntax match PersistKeyword /\<persist\>/ containedin=ALL
  autocmd FileType c,cpp highlight PersistKeyword guifg=#9de3c0

  " Types
  autocmd FileType c,cpp syntax match CustomType /\<\(u8\|u16\|u32\|u64\|i8\|i16\|i32\|i64\|f32\|f64\)\>/ containedin=ALL
  autocmd FileType c,cpp highlight CustomType guifg=#9de3c0
augroup END
"------------------------------------

" --------------Search --------------
set hlsearch   " Enable Highlight Search.
set incsearch  " Highlight while search.
set ignorecase " Case Insensitivity Pattern Matching.
set smartcase  " Overrides ignorecase if pattern contains upcase.
set showcmd    " Show command in bottom bar.

" Keep search results at the center of screen.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

command! -nargs=? Filter let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile | put! a
command! -nargs=? RFilter let @a='' | execute 'g!/<args>/y A' | new | setlocal bt=nofile | put! a
command! -nargs=? FilterSelection let @a='' | execute 'g/' . @/ . '/y A' | new | setlocal bt=nofile | put! a
command! -nargs=? RFilterSelection let @a='' | execute 'g!/' . @/ . '/y A' | new | setlocal bt=nofile | put! a

" Looks for a pattern in all open buffers.
" If list == 'c' then put results in the quickfix list.
" If list == 'l' then put results in the location list.
function! GrepBuffers(pattern, list)
    let str = ''

    if (a:list == 'l')
        let str = 'l'
    endif

    let str = str . 'vimgrep /' . a:pattern . '/'

    for i in range(1, bufnr('$'))
        let str = str . ' ' . fnameescape(bufname(i))
    endfor

    execute str
    execute a:list . 'w'
endfunction

" :GrepBuffers('pattern') puts results into the quickfix list.
command! -nargs=1 GrepBuffers call GrepBuffers(<args>, 'c')

" :GrepBuffersL('pattern') puts results into the location list.
command! -nargs=1 GrepBuffersL call GrepBuffers(<args>, 'l')
"------------------------------------

