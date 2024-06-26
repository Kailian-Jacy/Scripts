""" lua require("main")

""" Get the rull path
""" 1 <C-g>

""" Main Configurations
filetype plugin indent on
" tab
set expandtab
set tabstop=4 softtabstop=4 shiftwidth=4 smarttab autoindent
"set expandtab
set incsearch ignorecase smartcase hlsearch
set wildmode=longest,list,full wildmenu
set ruler laststatus=2 showcmd showmode
set showbreak=↪\
set list listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set fillchars+=vert:\ 
set wrap breakindent
set encoding=utf-8
set textwidth=0
set hidden
set number relativenumber
set title
""" Only highlight the current line number
set cursorline
set cursorlineopt=number
set linebreak
set smoothscroll
autocmd ColorScheme * highlight CursorLineNr cterm=bold term=bold gui=bold

""" Filetype-Specific Configurations

" HTML, XML, Jinja
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango inoremap {{ {{  }}<left><left><left>
autocmd FileType htmldjango inoremap {% {%  %}<left><left><left>
autocmd FileType htmldjango inoremap {# {#  #}<left><left><left>

" Markdown and Journal
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType journal setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Functions and autocmds to run whenever changing colorschemes
""" function! TransparentBackground()
"""     highlight Normal guibg=NONE ctermbg=NONE
"""     highlight LineNr guibg=NONE ctermbg=NONE
"""     set fillchars+=vert:\│
"""     highlight WinSeparator gui=NONE guibg=NONE guifg=#444444 cterm=NONE ctermbg=NONE ctermfg=gray
"""     highlight VertSplit gui=NONE guibg=NONE guifg=#444444 cterm=NONE ctermbg=NONE ctermfg=gray
""" endfunction

" Use these colors for Pmenu, CmpPmenusBorder and TelescopeBorder when using dracula colorscheme
function! DraculaTweaks()
    " Pmenu colors when not using bordered windows
    highlight Pmenu guibg=#363948
    highlight PmenuSbar guibg=#363948
    " Completion/documentation Pmenu border color when using bordered windows
    highlight link CmpPmenuBorder NonText
    " Telescope borders
    highlight link TelescopeBorder Constant
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme dracula call DraculaTweaks()
    "autocmd ColorScheme * call TransparentBackground() " uncomment if you are using a translucent terminal and you want nvim to use that
augroup END

set termguicolors

""" Core plugin configuration (vim)

""" " Treesitter
""" augroup DraculaTreesitterSourcingFix
"""     autocmd!
"""     autocmd ColorScheme dracula runtime after/plugin/dracula.vim
"""     syntax on
""" augroup end
""" 
""" " nvim-cmp
""" set completeopt=menu,menuone,noselect
""" 
""" " signify
""" let g:signify_sign_add = '│'
""" let g:signify_sign_delete = '│'
""" let g:signify_sign_change = '│'
""" hi DiffDelete guifg=#ff5555 guibg=none
""" 
""" " indentLine
""" let g:indentLine_char = '▏'
""" let g:indentLine_defaultGroup = 'NonText'
""" " Disable indentLine from concealing json and markdown syntax (e.g. ```)
""" let g:vim_json_syntax_conceal = 0
""" let g:vim_markdown_conceal = 0
""" let g:vim_markdown_conceal_code_blocks = 0
""" 
""" " FixCursorHold for better performance
""" let g:cursorhold_updatetime = 100
""" 
""" " context.vim
""" let g:context_nvim_no_redraw = 1
""" 
""" " Neovim :Terminal
""" tmap <Esc> <C-\><C-n>
""" tmap <C-w> <Esc><C-w>
""" "tmap <C-d> <Esc>:q<CR>
""" autocmd BufWinEnter,WinEnter term://* startinsert
""" autocmd BufLeave term://* stopinsert
""" 
""" " Python
""" let g:python3_host_prog = '~/.config/nvim/env/bin/python3'
""" let g:pydocstring_doq_path = '~/.config/nvim/env/bin/doq'
""" 
""" """ Core plugin configuration (lua)
""" lua << EOF
""" servers = {
"""     'pyright',
"""     --'tsserver', -- uncomment for typescript. See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for other language servers
""" }
""" require('treesitter-config')
""" require('nvim-cmp-config')
""" require('lspconfig-config')
""" require('telescope-config')
""" require('lualine-config')
""" require('nvim-tree-config')
""" require('diagnostics')
""" EOF
""" 
""" """ Custom Functions
""" 
""" " Trim Whitespaces
""" function! TrimWhitespace()
"""     let l:save = winsaveview()
"""     %s/\\\@<!\s\+$//e
"""     call winrestview(l:save)
""" endfunction
""" 
""" """ Custom Mappings (vim) (lua custom mappings are within individual lua config files)
""" 
""" " Core
let mapleader = " "
map <silent> <leader>e :NvimTreeToggle<CR>

""" Hopping
nnoremap <silent> <leader><leader> :HopWord<CR>
nnoremap <silent> <leader>j :HopVerticalAC<CR>
nnoremap <silent> <leader>k :HopVerticalBC<CR>

vnoremap <silent> <leader>/ :call nerdcommenter#Comment('x', 'toggle')<CR>
""" nmap \ <leader>q
""" nmap <leader>r :so ~/.config/nvim/init.vim<CR>
""" nmap <leader>t :call TrimWhitespace()<CR>
""" xmap <leader>a gaip*
""" nmap <leader>a gaip*
""" nmap <leader>h :RainbowParentheses!!<CR>
""" nmap <leader>j :set filetype=journal<CR>
""" nmap <leader>k :ColorToggle<CR>
""" nmap <leader>l :Limelight!!<CR>
""" xmap <leader>l :Limelight!!<CR>
""" nmap <silent> <leader><leader> :noh<CR>

""" H and L are switching between tabs.
"nmap <silent> <Tab><Tab> :bnext<CR>
"nmap <silent> <S-Tab> :bprevious<CR>
"
""" nmap <leader>$s <C-w>s<C-w>j:terminal<CR>:set nonumber<CR><S-a>
""" nmap <leader>$v <C-w>v<C-w>l:terminal<CR>:set nonumber<CR><S-a>
""" 
""" " Python
""" autocmd Filetype python nmap <leader>d <Plug>(pydocstring)
""" autocmd FileType python nmap <leader>p :Black<CR>
""" 
""" " Solidity (requires: npm install --save-dev prettier prettier-plugin-solidity)
""" autocmd Filetype solidity nmap <leader>p :0,$!npx prettier %<CR>
""" 

""" Telescope mappings
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
vnoremap <leader>fg "zy:Telescope live_grep default_text=<C-r>z<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope command_history<cr>
nnoremap <leader>f/ <cmd>Telescope current_buffer_fuzzy_find<cr>
vnoremap <leader>f/ "zy:Telescope current_buffer_fuzzy_find default_text=<C-r>z<cr>
nnoremap <leader>ls <cmd>Telescope aerial<cr>
nnoremap <leader>le <cmd>Telescope diagnostics severity=1<cr>
nnoremap <leader>lw <cmd>Telescope diagnostics severity=2<cr>

""" Copy Pasting
nnoremap <leader>yy "+yy
nnoremap <leader>y  "+y
vnoremap <leader>y  "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

""" List all.
nnoremap <leader>fj <cmd>Telescope jumplist<cr>
nnoremap <leader>fm <cmd>Telescope marks<cr>

""" Finding in language
nnoremap <leader>fs <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
vnoremap <leader>fs "zy:Telescope lsp_dynamic_workspace_symbols default_text=<C-r>z<cr>
nnoremap gr <cmd>Telescope lsp_references<cr>
vnoremap <leader>gr "zy:Telescope lsp_references default_text=<C-r>z<cr>
nnoremap gi <cmd>Telescope lsp_implementations<cr>
vnoremap <leader>gi "zy:Telescope lsp_implementations default_text=<C-r>z<cr>
nnoremap gd <cmd>Telescope lsp_definitions<cr>
vnoremap <leader>gd "zy:Telescope lsp_definitions default_text=<C-r>z<cr>

""" Git related
nnoremap <leader>gg <cmd>LazyGit <cr>
nnoremap <leader>gc <cmd>Telescope git_commits<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>df <cmd>Gitsigns  diffthis<cr>
nnoremap <leader>gd <cmd>Gitsigns  preview_hunk<cr>
nnoremap <leader>gs <cmd>Telescope git_stash<cr>
""" nnoremap <leader>tr <cmd>Telescope treesitter<cr>
 
""" """ file browser
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fe <cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>

""" Debugging related
nnoremap <leader>df <cmd>Telescope dap frames<cr>
nnoremap <leader>db <cmd>Telescope dap list_breakpoints<cr>
nnoremap <leader>dv <cmd>Telescope dap variables<cr>

""" Control
nnoremap ZA :wqa<cr>

""" Navivage through Functions
nnoremap J <cmd>AerialPrev<CR>
nnoremap K <cmd>AerialNext<CR>

set statusline+=%{get(b:,'gitsigns_status','')}
hi TreesitterContextBottom gui=underline guisp=Grey
