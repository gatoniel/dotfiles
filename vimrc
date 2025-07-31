set nocompatible              " required
filetype off                  " required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'python-mode/python-mode'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'prabirshrestha/vim-lsp'
" deprecated and replaced by ALE
" Plugin 'vim-syntastic/syntastic'
" replaces vim-syntastic/syntastic
" Plugin 'dense-analysis/ale'
" Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
" Seems to be outdated.
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'cespare/vim-toml'
"
" " add all your plugins here (note older versions of Vundle
" " used Bundle instead of Plugin)
"
" " ...
"
" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" make all tabs to spaces
" also standard tabstop size should be 4
" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When this option is enabled, vi will use spaces instead of tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" auto indentation
au BufNewFile, BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=88
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" mark extra whitespaces
:highlight BadWhitespace ctermfg=16 ctermbg=253 guifg=#000000 guibg=#F8F8F0
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Snakefile syntax highlighting
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake

set encoding=utf-8

let python_highlight_all=1
syntax on

if has('gui_running')
    set background=dark
    colorscheme solarized
else
    colorscheme zenburn
    set background=dark
endif
call togglebg#map("<F5>")

" set file numbering
set nu

" syntastic config (old, deprecated)
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_python_checkers = ['pylint']

" dense-analysis/ale
"let g:ale_keep_list_window_open = 1
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_insert_leave = 0

" from here
" https://stackoverflow.com/questions/22980938/how-do-i-keep-syntax-highlighting-for-a-buffer-for-the-duration-of-a-vim-session
" so the syntax higlighting does not get lost
set hidden

autocmd FileType python set textwidth=88
let g:pymode_options_max_line_length = 88

" https://vi.stackexchange.com/a/2163
set backspace=indent,eol,start

let @n = 'A  # noqa: E0602'

" Ruff
if executable('ruff')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'ruff',
        \ 'cmd': {server_info->['ruff', 'server']},
        \ 'allowlist': ['python'],
        \ 'workspace_config': {},
        \ })
endif
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes

    autocmd! BufWritePre *.py call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
let g:lsp_auto_enable = 1
