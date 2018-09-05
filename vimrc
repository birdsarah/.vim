" Pathogen
filetype off
call pathogen#infect()
call pathogen#helptags()

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
" Make sure vim is installed with clipboard ($ vim --version | grep clipboard)
" On Fedora install gvim and alias 'gvim -v' to vim.

set pastetoggle=<F2>
set clipboard=unnamedplus

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color Scheme
set t_Co=256
syntax enable
set background=light
"let g:solarized_termcolors=256
colorscheme solarized

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype plugin indent on
syntax on

" Showing line numbers and length
set number " show line numbers
set tw=79 " width of document (used by gd)
set nowrap " don't automatically wrap on load
set fo-=t " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=102

" Markdown highlighting
let g:vim_markdown_folding_disabled=1

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Two line command height & cursorline
set cmdheight=2

" PyMode
let g:pymode_folding = 0
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pylint']
let g:pymode_lint_ignore = "C0111,E1120,W0201,C0301,F0401,E1002,R0201,W0621"
let g:pymode_options_max_line_length=120
let g:pymode_motion = 1
let g:pymode_doc_bind = 'K'

" Leave escape mode fast - https://powerline.readthedocs.org/en/latest/tipstricks.html
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" Vimux - run commands in tmux from vimux
" map <Leader>vt :call VimuxRunCommand("py.test " . bufname("%"))<CR>
map <Leader>vt :call VimuxRunCommand("py.test")<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vp :VimuxPromptCommand<CR>
let g:VimuxOrientation = "h"

if has("autocmd")
" always save when changing tabs etc
  au FocusLost * :wa

" Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json setlocal ft=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

" in human-language files, automatically format everything at 72 chars:
  au BufNewFile,BufRead admin.py setlocal filetype=python.django
  au BufNewFile,BufRead urls.py setlocal filetype=python.django
  au BufNewFile,BufRead models.py setlocal filetype=python.django
  au BufNewFile,BufRead views.py setlocal filetype=python.django
  au BufNewFile,BufRead settings.py setlocal filetype=python.django
  au BufNewFile,BufRead forms.py setlocal filetype=python.django

" for man pages don't show line numbers
  autocmd FileType man setlocal nonumber

endif


" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" " (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" have \th ("toggle highlight") toggle highlighting of search matches, and
" " report the change:
nnoremap <Leader>th :set invhls hls?<CR>

" Make ctrl-s save things
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a
:imap <c-s> <Esc><c-s>ms

" Snipmate


" Moving windows between tabs
function! MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    vert topleft split 
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function! MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    vert topleft split 
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

nnoremap mt :call MoveToNextTab()<CR>
nnoremap mT :call MoveToPrevTab()<CR>

" Clear highlighting after search
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
