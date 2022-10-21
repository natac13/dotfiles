"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" drop vi support - kept for vim compatibility but not needed for nvim
" Probably not needed with Vim 8+
set nocompatible

" Enable filetype plugins
filetype plugin on 
filetype indent on

" set number of line VIM remembers as history
set history=500

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\<space>"

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Search down into subfolders
" Provides tab-completion for all file-related tasks
" Search recursively downward from CWD; provides TAB completion for filenames
" e.g., `:find vim* <TAB>`
set path+=**

" Display all matching files when we tab complete
set wildmenu

set encoding=utf-8
syntax enable

" Show matching brackets when text indicator is over them
set showmatch
" Show line numbers
set number
" Show numbers relative to cursor
set relativenumber
set showcmd
set showmode
" Highlight search results
set hlsearch
set ignorecase
" When search try to be smart about case
set smartcase
" Makes search act like search in modern browsers
set incsearch
" For regular expressions turn magic on
set magic
set ruler
set cmdheight=1
set wildmenu

" Delete characters outside of insert area
set backspace=indent,eol,start
set display+=lastline
set scrolloff=1
" Always show the status line
set laststatus=2

" show invisibles
set list
set listchars=
set listchars+=tab:·\
set listchars+=trail:·
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:░

" ===============================================
"                    THEME
" ===============================================
try
  " For Neovim 0.1.3 and 0.1.4
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  " Or if you have Neovim >= 0.1.5
  if (has("termguicolors"))
    set termguicolors
  endif

  " Theme
  set background=dark
	" colorscheme gruvbox8

  " Set contrast.
  " This configuration option should be placed before `colorscheme gruvbox-material`.
  " Available values: 'hard', 'medium'(default), 'soft'
  " let g:gruvbox_material_background = 'medium'
  let g:gruvbox_material_enable_italic = 1
  packadd! gruvbox-material
  colorscheme gruvbox-material

catch
  colorscheme desert
endtry

" turn on italics for comments
highlight Comment cterm=italic gui=italic


" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Remapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap jk <ESC>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowritebackup
set noswapfile

set updatetime=300
set timeoutlen=500

set pumheight=10

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Linebreak on 500 characters
" set lbr
" set tw=500

set autoindent "Auto indent
set si "Smart indent

" line warp
set wrap
set linebreak
set textwidth=0
set wrapmargin=0

" set code folding for indented lines
set foldmethod=indent
set nofoldenable
" Delete empty space from the end of lines on every save
" autocmd BufWritePre * :%s/\s\+$//e
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><enter> :noh<cr>

" Smart way to move between windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Use mouse
set mouse=a

" Always show tabs
set showtabline=2

" Share system clipboard
set clipboard+=unnamedplus
"set clipboard=unnamed

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ariline (statusbar)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#hunks#enabled=0
" let g:airline#extensions#branch#enabled=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " \   'left': [ [ 'mode', 'paste' ],
  " \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
let g:lightline = {
  \ 'colorscheme': 'gruvbox_material',
  \ 'active': {
  \   'left': [ [ 'paste' ],
  \             [ 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'percent', 'cocstatus' ],
  \              [ 'lineinfo' ],
  \              [ 'currentfunction', 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead',
  \   'cocstatus': 'coc#status',
  \   'currentfunction': 'CocCurrentFunction',
  \   'fileformat': 'LightlineFileformat',
  \   'filetype': 'LightlineFiletype',
  \   'filename': 'LightLineFilename'
  \ },
  \ 'tab': {
  \   'active': [ 'tabnum', 'filename', 'modified'],
  \   'inactive': [' tabnum', 'filename', 'modified']
  \ },
  \ }

function! LightLineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
	let name = ""
  let path = expand('%')

  if path[:len(root)-1] ==# root
    let subs = split(path[len(root)+1:], '/')
  else
    let subs = split(path, '/')
  endif

	let i = 1
	for s in subs
		let parent = name
		if  i == len(subs)
			let name = parent . '/' . s
    elseif i+1 == len(subs)
			let name = parent . '/' . s
		else
			let name = parent . '/' . strpart(s, 0, 3)
		endif
		let i += 1
	endfor

  return name
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-p> :Files<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>s :BLines<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  COC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc config
let g:coc_global_extensions = [
  \ 'coc-cfn-lint',
  \ 'coc-css',
  \ 'coc-docker',
  \ 'coc-emoji',
  \ 'coc-eslint',
  \ 'coc-explorer',
  \ 'coc-graphql',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-pairs',
  \ 'coc-prettier',
  \ 'coc-sh',
  \ 'coc-snippets',
  \ 'coc-solidity',
  \ 'coc-spell-checker',
  \ 'coc-sql',
  \ 'coc-tailwindcss',
  \ 'coc-tsserver',
  \ 'coc-yaml'
  \ ]
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)


" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>ex  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


nnoremap <leader>e :CocCommand explorer<CR>
nnoremap <leader>O :call CocAction('runCommand', 'editor.action.organizeImport')
" autocmd VimEnter *  CocCommand explorer
nmap <expr> <silent> <C-d> <SID>select_current_word()
function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc



" Snippets
" " Use <C-l> for trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)
"
" " Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)
"
" " Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'
"
" " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'
"
" " Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
"
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)


"""""""""""""""""""""""""""""""""""""""""""""""""
"  Netrw
"""""""""""""""""""""""""""""""""""""""""""""""""
" tree view
let g:netrw_liststyle = 3
" removes banner at the top
let g:netrw_banner = 0
" sets the size of the oening window, whether explorer or file
let g:netrw_winsize = 70
" open in prior window
let g:netrw_browse_split = 4
" vsplit netrw to the left window
let g:netrw_altv = 1
" hsplit netrw to the top window
let g:netrw_alto = 1
let g:netrw_list_hide=netrw_gitignore#Hide()
" nnoremap <leader>e :Lexplore<CR>
"
"""""""""""""""""""""""""""""""""""""""""""""""""
" Yats.vim
"""""""""""""""""""""""""""""""""""""""""""""""""
set re=0 " docs says this helps with performance

"
" tComment
let g:tcomment#filetype#guess_typescript = 1
let g:tcomment#filetype#guess_typescriptreact = 1
