set tabstop=4
set shiftwidth=4

let g:python_indent={}
let g:python_indent.open_paren=shiftwidth()

colorscheme catppuccin-latte
set background=dark

autocmd FileType sql setlocal expandtab
autocmd FileType sql setlocal commentstring=--\ %s

autocmd FileType json setlocal commentstring=#\ %s
autocmd FileType yaml setlocal commentstring=#\ %s

" Fast Folding Activate
let g:markdown_folding = 1
let g:rst_fold_enabled = 1
let g:tex_fold_enabled = 1
let g:vimsyn_folding = 'af'
let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
let g:zsh_fold_enable = 1
let g:ruby_fold = 1
let g:perl_fold = 1
let g:perl_fold_blocks = 1
let g:r_syntax_folding = 1
let g:rust_fold = 1
let g:php_folding = 1
let g:fortran_fold=1
let g:clojure_fold = 1
let g:baan_fold=1
let g:clipboard = 'osc52'
" Avaiable packages for all environments
let g:python3_host_prog = ''

" LSP
let g:ale_linters = {
\ 'python':	['jedi_language_server'],
\ 'rust':	['rust_analyzer', 'cargo']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_completion_enabled=1

" if client.server_capabilities.inlayHintProvider then
"   vim.g.inlay_hints_visible = true
"   vim.lsp.inlay_hint(bufnr, true)
" else
"   print("no inlay hints available")
" end
"
