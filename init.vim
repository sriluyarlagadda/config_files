set number relativenumber

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=5

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=1200

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" use 4 spaces as width
set tabstop=4
set expandtab
set shiftwidth=4
set fileformat=unix

" highlight results when searching incrementally
set incsearch

call plug#begin(stdpath('data') . '/plugged')
Plug 'tpope/vim-sensible' " Sensible defaults
Plug 'sheerun/vim-polyglot'
" this is for searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" only run on toggle of 'NerdTreeToggle
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" auto completion
Plug 'airblade/vim-rooter'
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
"Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'doums/darcula'
call plug#end()

" Editor settings
:let mapleader = " "
set splitright
set splitbelow


" vimrc mappings 
:nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
:nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

" Quick-save
nmap <leader>w :w<CR>
" Easy escape
inoremap jk  <ESC>l
xnoremap jk  <ESC>l

" make window navigation easy
nnoremap <c-h> <c-w>h<ESC> 
nnoremap <c-j> <c-w>j<ESC> 
nnoremap <c-k> <c-w>k<ESC> 
nnoremap <c-l> <c-w>l<ESC> 

" terminal exit
tnoremap jk <C-\><C-N>

" cancel highlight
nnoremap <leader>n :noh<CR>


" FZF configuration
" Open list of files in the project
nnoremap <c-p> :Files<CR>

" Search in bufers
nmap <leader>; :Buffers<CR>

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" <leader>s for Rg search
nmap <leader>s :Rg<CR>
" Empty value to disable preview window altogether
let g:fzf_preview_window = ''

" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

hi Pmenu guibg=white guifg=black

" coc configuration
" if hidden is not set, TextEdit might fail.
set hidden

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c


autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped" " by other  plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
      let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction


" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
              execute 'h '.expand('<cword>')
                else
                        call CocAction('doHover')
                          endif
                      endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nnoremap <leader>ff :<c-u>Prettier<CR>


" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature
" of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)


" Remap for do codeAction of selected region, aap for current
" paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>al  <Plug>(coc-codeaction-line)


" Do command for refactor
nmap <leader>r  <Plug>(coc-refactor)

" Using CocList
" Show the outline of the file
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>d  :<C-u>CocList diagnostics<cr>

" Search workspace symbols
nnoremap <silent> <leader>sy  :<C-u>CocList -I symbols<cr>

"Color scheme
colorscheme darcula
