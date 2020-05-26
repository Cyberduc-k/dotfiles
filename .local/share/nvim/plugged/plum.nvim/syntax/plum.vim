" Vim syntax file
" Language: Plum
" Maintainer: Fluix <cyberduck_@outlook.com>

if exists("b:current_syntax")
    finish
endif

syn keyword plumVar var nextgroup=plumVarName skipwhite skipempty
syn keyword plumFunc fn nextgroup=plumFuncName skipwhite skipempty
syn keyword plumPrint print nextgroup=@plumExpr skipwhite skipempty

syn match plumVarName #[a-zA-Z_][a-zA-Z0-9_]*# contained nextgroup=plumTyAnn skipwhite skipempty
syn match plumFuncName #[a-zA-Z_][a-zA-Z0-9_]*# contained nextgroup=plumParams skipwhite skipempty

syn region plumParams start=#(# end=#)# contained contains=plumVarName

syn region plumTyAnn start=#:# end=#,\|)\|=\|$#me=e-1,he=e-1 contained contains=plumTy

syn cluster plumTy contains=plumTyPrim,plumTyFunc
syn keyword plumTyPrim bool char str int uint float u8 u16 u32 u64 u128 i8 i16 i32 i64 i128 f32 f64 contained
syn keyword PlumTyFunc fn contained nextgroup=plumTyParams skipwhite skipempty
syn region plumTyParams start=#(# end=#)# contained contains=@plumTy nextgroup=plumTyRet skipwhite skipempty
syn match plumTyRet #-># contained nextgroup=@plumTy skipwhite skipempty

syn cluster plumExpr contains=plumVariable,plumFuncName,@plumLiteral
syn match plumVariable #[a-zA-Z_][a-zA-Z0-9_]*#
syn match plumFunction #[a-zA-Z_][a-zA-Z0-9_]*\(\s*(\)\@=#
syn match plumTypeExpr #`# nextgroup=@plumTy skipwhite skipempty
syn match plumTypeOfExpr #\(\.\)\@<=\<type\>#

syn cluster plumLiteral contains=plumString,plumNumber
syn region plumString start=#"# skip=#\\.# end=#"#
syn match plumNumber #\v\d+#
syn match plumNumber #\v\d+\.\d+#

syn match plumComment "#.*$"

hi def link plumVar Keyword
hi def link plumFunc Keyword
hi def link plumPrint Keyword
hi def link plumVariable Identifier
hi def link plumVarName Identifier
hi def link plumFunction Function
hi def link plumFuncName Function
hi def link plumTyPrim Type
hi def link plumTyFunc Keyword
hi def link plumTypeOfExpr Keyword
hi def link plumString String
hi def link plumNumber Constant
hi def link plumComment Comment

let b:current_syntax = "plum"
