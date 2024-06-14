""""""""""""""""""""""""""""""
" plug: ctrlp
""""""""""""""""""""""""""""""
" buffer mode in default
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_working_path_mode = 'ra'
" Use a custom file listing command
let g:ctrlp_user_command = 'find %s -type f'       " MacOSX/Linux
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_match_window = 'top'

let g:ctrlp_mruf_default_order = 0
