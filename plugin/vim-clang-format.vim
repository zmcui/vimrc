""""""""""""""""""""""""""""""
" Vundle: rhysd/vim-clang-format
""""""""""""""""""""""""""""""
let g:clang_format#detect_style_file = 1
" Your filetype specific options
let g:clang_format#filetype_style_options = {
    \   'cpp' : {
    \          "BasedOnStyle" : "Google",
    \          "ColumnLimit" : "0",
    \          "IndentCaseLabels" : "true",
    \          "IndentWidth" : 4,
    \          "ContinuationIndentWidth" : 4,
    \          "BreakBeforeBraces" : "Linux",
    \          "AlignConsecutiveDeclarations" : "false",
    \          "AlignConsecutiveAssignments" : "false",
    \          "AlignConsecutiveMacros" : "true",
    \          "Standard" : "Cpp11",
    \          "TabWidth" : 8,
    \          "UseTab" : "Never",
    \          "DeriveLineEnding": "false",
    \          "UseCRLF"  :  "false"
    \           },
    \   'c' : {
    \          "ColumnLimit" : "0",
    \          "IndentWidth" : 8,
    \          "BreakBeforeBraces" : "Linux",
    \          "AllowShortIfStatementsOnASingleLine" : "false",
    \          "AllowShortLoopsOnASingleLine" : "false",
    \          "AllowShortFunctionsOnASingleLine" : "false",
    \          "IndentCaseLabels" : "false",
    \          "AlignEscapedNewlinesLeft" : "false",
    \          "AlignTrailingComments" : "true",
    \          "SpacesBeforeTrailingComments" : 3,
    \          "AllowAllParametersOfDeclarationOnNextLine" : "false",
    \          "AlignAfterOpenBracket" : "true",
    \          "SpaceAfterCStyleCast" : "false",
    \          "MaxEmptyLinesToKeep" : 2,
    \          "BreakBeforeBinaryOperators" : "NonAssignment",
    \          "SortIncludes" : "false",
    \          "ContinuationIndentWidth" : 8,
    \          "AlignConsecutiveDeclarations" : "false",
    \          "AlignConsecutiveAssignments" : "false",
    \          "AlignConsecutiveMacros" : "true",
    \          "DerivePointerAlignment" : "false",
    \          "PointerAlignment" : "Right",
    \          "Standard" : "Cpp11",
    \          "TabWidth" : 8,
    \          "UseTab" : "Always",
    \          "DeriveLineEnding": "false",
    \          "UseCRLF"  :  "false"
    \         },
    \ }

