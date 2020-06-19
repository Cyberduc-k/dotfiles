" Vim syntax file
" Language: Plum
" Maintainer: Fluix <cyberduck_@outlook.com>

if exists("b:current_syntax")
    finish
endif

syn keyword plumKeyword module nextgroup=plumModuleName skipwhite skipempty

syn region plumImport start=#\<import\># end=#$# contains=plumImportKeyword
syn keyword plumImportKeyword import qualified nextgroup=plumModuleName skipwhite skipempty
syn keyword plumImportKeyword as nextgroup=plumIdent skipempty skipwhite
syn keyword plumImportKeyword hiding

syn keyword plumKeyword trait nextgroup=plumTy skipwhite skipempty
syn keyword plumKeyword impl nextgroup=plumTy skipwhite skipempty
syn keyword plumKeyword infix infixl infixr nextgroup=plumNumber skipwhite skipempty

syn match plumModuleName #\(\<qualified\>\)\@![a-zA-Z_][a-zA-Z0-9_]*\(\.[a-zA-Z_][a-zA-Z0-9_]*\)*# contained

syn match plumDec #::# nextgroup=plumTy skipwhite skipempty
syn match plumDef #\(infix.*\)\@<!=# nextgroup=@plumExpr skipwhite skipempty
syn match plumFuncName #\(\<[a-zA-Z_][a-zA-Z0-9_]*\>\|([^a-zA-Z0-9_ \t\n\r()]\+)\)\(\s*::\s*.*->\)\@=#
syn region plumFuncName
            \ matchgroup=plumFuncName
            \ start=#\(\<[a-zA-Z_][a-zA-Z0-9_]*\>\|([^a-zA-Z0-9_ \t\n\r()]\+)\)\(\(\s\+\)\@>.\+=\)\@=#
            \ end=#=#me=e-1,he=e-1
            \ contains=plumParamName

syn match plumParamName #[a-zA-Z_][a-zA-Z0-9_]*# contained

syn region plumTy start=#.# end=#$# contains=plumTyCons,plumTyVar contained
syn match plumTyCons #[A-Z_][a-zA-Z0-9_]*# contained
syn match plumTyVar #[a-z_][a-zA-Z0-9_]*# contained

syn cluster plumExpr contains=plumFuncExpr,plumIdent,@plumLiteral,plumExprParens
syn cluster plumExprAtom contains=plumIdent,@plumLiteral,plumExprParens
syn match plumIdent #[a-zA-Z_][a-zA-Z0-9_]*# contained
syn region plumExprParens start=#(# end=#)# contains=@plumExpr contained
syn region plumFuncExpr matchgroup=plumFuncName start=#\<[a-zA-Z_][a-zA-Z0-9_]*\>\(\s*[a-zA-Z0-9_(]\)\@=# end=#$\|)# contains=@plumExprAtom contained

syn cluster plumLiteral contains=plumString,plumNumber
syn region plumString start=#"# skip=#\\.# end=#"#
syn match plumNumber #\d\+#
syn match plumNumber #\(\.\)\@<!\d\+\.\d\+#

syn match plumAttr #@[a-zA-Z_][a-zA-Z0-9_]*# nextgroup=plumAttrContent contained
syn region plumAttrContent start=#.# end=#$# contains=@plumLiteral,plumIdent contained
syn match plumAttrComment "#!.*$" contains=plumAttr
syn match plumComment "#\(!\)\@!.*$"

hi def link plumKeyword Keyword
hi def link plumImportKeyword Keyword

hi def link plumTyCons Type
hi def link plumTyVar Identifier

hi def link plumFuncName Function

hi def link plumString String
hi def link plumNumber Constant

hi def link plumAttr PreProc
hi def link plumAttrComment SpecialComment
hi def link plumComment Comment

let b:current_syntax = "plum"
