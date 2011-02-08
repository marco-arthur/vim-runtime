" vim:foldmethod=marker
" =============

" Global Variables: {{{1
" =============
let g:snippets_dir = $HOME . "/Desktop/vim/snippets"
" Settings: {{{1
" =============

let mapleader = ","
syntax on
set nolist
set background=dark
colorscheme ron
set tabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set cul
set nocompatible
set tags=../tags,./tags
set showcmd
set nonumber
set history=2500
set tags+=~/.vim/systags
set listchars="eol:$tab:"
set viminfo='1000,f1,:1000,/1000
set backup
set backupdir=./.backup,/tmp,.
set title
set autoread
set foldmethod=marker
set foldlevelstart=0
set foldtext=MyFoldText()

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

" ================
" Mappings: {{{1
" ================

" Leader Maps {{{2
" Copia para area de copia do X11
vmap <leader>x "+y

" Fazendo Spell checking para ingles
nmap <leader>se :set spell spelllang=en_us<CR>

" Paste Mode
nmap <leader>p :call TurnOnOff("paste")<CR>

" Fazendo Spell checking para portugues
nmap <leader>sp :set spell spelllang=pt_br<CR>

" Spell checking
nmap <leader>s :call TurnOnOff("spell")<CR>

" Janela única
nmap <leader>o :only<CR>

" Troca palavra interna
nmap <leader>c ciw

" Numero de linha
nmap <leader>n :call TurnOnOff("number")<CR>

" Explora .
nmap <leader>. :tabnew +Explore .<CR>

" Ignore Case
nmap <leader>i :call TurnOnOff("ignorecase")<CR>

" Tira régua
nmap <leader>r :call TurnOnOff("cul")<CR>

" Ver Caracteres de controle
nmap <leader>j :call TurnOnOff("list")<CR>


" }}}2
" Function Keys Maps {{{2
" *** F12 ***
" Procura por palavra sob cursor nos arquivo na pasta corrente
map <F12> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

" *** F11 ***
" Editar .vimrc
nmap <F11> :tabnew ~/.vimrc<CR>

" *** F10 *** (vazio)
" *** F9 *** (vazio)
nmap <F9> :buffers<CR>
" *** F8 *** (vazio)
" *** F7 ***
" Highligh texto procurado
nmap <F7> :call TurnOnOff("hls")<CR>

" *** F6 ***  (vazio)
" *** F5 ***  (vazio)
" Nova aba
nmap <F5> :nmap tabnew<CR>
" *** F4 ***
" Vazio

" *** F3 ***  (vazio)
" *** F2 ***  (vazio)
"}}}2
" Ungrouped Maps {{{2
" Apaga a linha de commando inteira
cnoremap <C-U> <C-E><C-U>

" Navegando em tabs
nmap L :tabnext<CR>
nmap H :tabprevious<CR>

" Veja em Tricks
nmap K yaw:Man <C-R>"<CR>

"  Get on tabs
nmap L :tabnext<CR>
nmap H :tabprevious<CR>

" Procura por texto selecionado. Ver :he visual.txt, lin 500
vmap X y/<C-R>"<CR>
" }}}2

" ======
" Tricks: {{{1
" ======

" Lendo manpages numa janela vim.
runtime! ftplugin/man.vim

" Turn hls on/off
func TurnOnOff( opt )
    if ( eval("&" . a:opt) )
        execute ":set no".a:opt
    echo a:opt " OFF"
    else
        execute "set ".a:opt
    echo a:opt " ON"
    endif
endfunc

" Ease recovery accidentaly ^w
inoremap <C-w> <C-g>u<C-w>

" ================
" Abbreviations {{{1
" ================
ab p/ para
ab pe por exemplo
" ================
" Setting Plugins: {{{1
" ================

" GetLatestPlugin: {{{2
" ===============

" Instala Plugins
let g:GetLatestVimScripts_allowautoinstall=1


" SpellChecking: {{{2
" ===============
if version != 700
    let spell_executable="aspell"
    let spell_auto_type="tex,doc,mail"
endif

" MatchIT: {{{2
" ===============

runtime macros/matchit.vim

" Twiki: {{{2
" =============

let g:Twiki_FoldAtHeadings=1
let g:Twiki_Functions=1
let g:Twiki_Mapings=1
let g:Twiki_SpellFile='/home/arthur/.dicionario/twiki.latin1.add'

" Shell Syntax: {{{2
" ===================

let g:is_bash=1
let g:sh_fold_enable=1

" Rails: {{{2
" ================

" Defining the OpenUrl command, (To use firefox)
command -bar -nargs=1 OpenURL :!firefox -P default <args>

" Omni-completion with rubycomplete.vim
let g:rubycomplete_rails = 1
" let g:rubycomplete_classes_in_global = 1
" let g:rubycomplete_rails_proactive = 1

" DbExt: {{{2
" ===============
" Markdown: {{{2
" ===============
" Consulte -->http://plasticboy.com/markdown-vim-mode/ para informacoes
augroup mkd
    autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
augroup END

" LatexSuite: {{{2
" ===============
let tex_flavor = "tex"

" NetRw: {{{2
" ===============
"let g:netrw_timefmt = "%a %Y-%m-%d  %I-%M-%S %p"
let g:netrw_list_hide= '\(^\|\s\s\)\zs\.\S\+,\.pyc'

" FuzzyFinder: {{{2
" ============
nmap <silent><leader>f :FufFile<CR>
nmap <silent><leader>d :FufDir<CR>
nmap <silent><leader>b :FufBuffer<CR>

" Functions: {{{1
" ===============

function CommentLine( cchar )
    " Strong feelings say: should be based on ft. But...
    " ... 'comments is a list very confusing, and ...
    " ... substitute( split(&comments,',')[-1] , '.*:','','') is frequently WRONG !
    " Alternatives:
    "     HardCore: big hash: '{lang : comment-char}'
    "     SoftCore: simple schema, define cchar on ~/ftplugin/*.vim files, And...
    if exists('comment_char')
        let cc = comment_char
    else
        let cc = a:cchar
    endif

    let s:nmap = ":nmap <leader>c 0i" . cc . "<Esc>"
    let s:imap = ":imap <leader>c <Esc>0i" . cc . "<Esc>A"
    exe s:nmap
    exe s:imap
endfunction

function RegisterMap(my_map)
  " Hi, So you don't remember all your maps ? Register it !
  " call RegisterMap({'name':'paste', 'map':'<leader>p', 'command':':call TurnOnOff("paste")<CR>', 'mode':'normal'})
  " but check if you actually create it ! :)
  " Author: Marco Arthur
  if !exists('g:my_maps')
    let g:my_maps = {}
  endif

  if type(a:my_map) == type({})
    if has_key(a:my_map,'name') && has_key(a:my_map,'map')
          \ && has_key(a:my_map,'command') && has_key(a:my_map,'mode')
      " Executing
      let map = a:my_map['map']
      let cmd = a:my_map['command']
      let mod = a:my_map['mode']
      if mod == 'normal'
         let exec_map = "nmap "
      endif
      if mod == 'visual'
         let exec_map = "vmap "
      endif
      let exec_map .= map . " " . cmd
      echo exec_map
      " We need try catch here
      exec exec_map

      " Registering
      let g:my_maps[a:my_map['name']] = a:my_map
      echo "MAP Added"
    else
      echo "Please see how to call properly RegisterMap()"
    endif
  else
    echo "Read how to call RegisterMap()"
  endif
endfunction

function ShowRegisteredMaps()
  " Nice, you registered, now you want to know
  " Author: Marco Arthur
  if exists('g:my_maps') && !empty(g:my_maps)
    for key in keys(g:my_maps)
      echo key . ': ' . g:my_maps[key]['mode'] . ' ' g:my_maps[key]['map']
    endfor
  else
    echo "OH mine! You don't have yet Registered your Maps!"
  endif
endfunction


function! ChooseSomething(question, table, default)
    " So you want to prompt something ? Call
    " ChooseSomething('Please Choose One Above', { 1:'First Option', 2:'Second Option', 3:'Third Option'},1)
    " To have
    "        1:  First Option
    "        2:  Second Option
    "        3:  Third Option
    "        Please Choose One Above:1
    "
    "  the return value is the named option (in example: 'First Option'), otherwise none.
    "  You don't need numbers as KEYS, you may have letters or any string as KEYS:
    " Ex.
    " ChooseSomething('Do you want proceed?', {'yes':'Kaboon', 'no':'Failed'}, 'yes')

    if type(a:table) == type({}) && type(a:question) == type("") && type(a:default) == type("")
        for key in keys(a:table)
            echo key . ': ' a:table[key]
        endfor
        let choice = input(a:question, a:default)
        if has_key(a:table, choice)
            return a:table[choice]
        else
            echohl "Canceled!"
            return "none"
    else
        echo "Please See how to Call ChooseSomething()"
    endif
endfunction

fun SpellFile()
" Tres dicionarios:
" Técnico Computação
" Termos gerais
" Estrangeirismos
    let escolhas =
                \{'Tecnico': 'tecnico.utf-8.add', 'Geral': 'termos_gerais.utf-8.add',
                \    'Estrangeiro': 'estrangeirismos.uft-8.add'}
    let escolha = ChooseSomething('Escolha um Dicionário', escolhas, 'Tecnico')
    if escolha != "none"
        setlocal spellfile=escolha
    endif
endfun


function! UpSideDown()
    "TURN  UP/DOWN ARROWS A POWERFUL LIST CURSOR
  "PAGE-DOWN SHOWS LIST
    let options = {1: 'spell', 2: 'clist', 3: 'buffers', 4: 'erase'}
    let choice = ChooseSomething('Set Up/Down to what ?  ', options, 'none')

    if choice == "spell"
        nmap <UP> [s
        nmap <Down> ]s
    elseif choice == "clist"
        nmap <UP> :cprevious<CR>
        nmap <Down> :cnext<CR>
    nmap <PageDown> :clist<CR>
    elseif choice == "buffers"
        nmap <UP> :bp<CR>
        nmap <Down> :bn<CR>
    nmap <PageDown> :buffers<CR>
    elseif choice == "erase"
        unmap <Down>
        unmap <Up>
    unmap <PageDown>
    endif
endfunction

function Statistcs( work )
    " So you are working a lot ? How much ? Call
    " Statistcs( "time" ) or Statistcs( "commands" ) or Statistcs( "all" )
endfunction

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . '¿' . repeat(" ",fillcharcount) . foldedlinecount . '¿' . ' '
endfunction
set foldtext=MyFoldText()

" AutoCommands {{{1
"
au BufRead,BufNewFile *.t set filetype=perl | compiler perlprove

" statusline {{{1
" Note: Everything in this section from Caio Romao.
set laststatus=2
" From: http://stackoverflow.com/questions/164847/what-is-in-your-vimrc/1219114#1219114
" set statusline=%2*%n\|%<%*%-.40F%2*\|\ %2*%M\ %3*%=%1*\ %1*%2.6l%2*x%1*%1.9(%c%V%)%2*[%1*%P%2*]%1*%2B

" From: http://www.reddit.com/r/vim/comments/e19bu/whats_your_status_line/
set statusline=%f       "tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

" display current git branch
set statusline+=%{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%{StatuslineLongLineWarning()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
" set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2        " Always show status line

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning
autocmd bufwritepost * unlet! b:statusline_tab_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")
        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            " let b:statusline_long_line_warning = '[' .
            "             \ '#' . len(long_line_lens) . ',' .
            "             \ 'm' . s:Median(long_line_lens) . ',' .
            "             \ '$' . max(long_line_lens) . ']'
            let b:statusline_long_line_warning = '[>' .
                            \ (&tw ? &tw : 80) . ']'
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction
" }}}1
