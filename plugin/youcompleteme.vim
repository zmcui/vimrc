""""""""""""""""""""""""""""""
" Vundle:YouCompleteMe
""""""""""""""""""""""""""""""
" libclang or clangd(recommanded)
let g:ycm_use_clangd = 1
" clangd memory consumption problem and UI freeze
" let g:ycm_clangd_args = ['-log=verbose', '-pretty', '--background-index=false']
let g:ycm_clangd_args = ['-log=verbose', '-pretty', '--background-index', '--header-insertion-decorators', '-header-insertion=iwyu']
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" use C/C++ syntax highlighting in the popup for C-family languages
augroup MyYCMCustom
  autocmd!
  autocmd FileType c,cpp let b:ycm_hover = {
    \ 'command': 'GetDoc',
    \ 'syntax': &filetype
    \ }
augroup END

set completeopt=menu,menuone "no completion in the preview window
let g:ycm_add_preview_to_completeopt = 0 "no add preview
" set splitbelow
let g:ycm_global_ycm_extra_conf='/home/zongmincui/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_show_diagnostics_ui = 1
" let g:ycm_enable_diagnostic_signs = 0
" let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" trigger semantic complete when type
let g:ycm_semantic_triggers =  {
                         \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                         \ 'cs,lua,javascript,cmake': ['re!\w{2}'],
                         \ }
highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

let g:ycm_filetype_whitelist = { 
	\ "c":1,
	\ "cpp":1, 
	\ "objc":1,
	\ "sh":1,
	\ "zsh":1,
	\ "markdown":1,
	\ "vim":1,
	\ "CMakeLists.txt":1,
	\ "python":1,
	\ "Kconfig":1,
	\ "Makefile":1,
	\ }

let g:ycm_filetype_blacklist = {
      \ 'tagbar': 1,
      \ 'notes': 1,
      \ 'markdown': 1,
      \ 'netrw': 1,
      \ 'unite': 1,
      \ 'text': 1,
      \ 'vimwiki': 1,
      \ 'pandoc': 1,
      \ 'infolog': 1,
      \ 'leaderf': 1,
      \ 'mail': 1,
      \ 'raw': 1,
      \}
" keymaps
nnoremap <leader>ga :YcmCompleter GoToAlternateFile<CR>
nnoremap <leader>gc :YcmCompleter GoToCallers<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gt :YcmCompleter GoToType<CR>
