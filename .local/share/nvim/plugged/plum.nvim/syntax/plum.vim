" Vim syntax file
" Language: Plum
" Maintainer: Fluix <cyberduck_@outlook.com>

if exists("b:current_syntax")
  finish
endif

" Values
syn match plumIdentifier "\<[_a-z]\(\w\)*\>"
syn match plumName "\<[_a-zA-Z]\(\w\)*\>"
syn match plumNumber "0[xX][0-9a-fA-F]\+\|0[oO][0-7]\|[0-9]\+"
syn match plumFloat "[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\="
syn keyword plumBoolean true false

" Delimiters
syn match plumDelimiter "[,;|.()[\]{}]"

" Type
syn match plumType "\%(\<class\s\+\)\@15<!\<\u\w*\>" contained
  \ containedin=plumTypeAlias
  \ nextgroup=plumType,plumTypeVar skipwhite
syn match plumTypeVar "\<[_a-z]\(\w\)*\>" contained
  \ containedin=plumData,plumNewtype,plumTypeAlias,plumFunctionDecl
syn region plumTypeExport matchgroup=plumType start="\<[A-Z]\(\S\&[^,.]\)*\>("rs=e-1 matchgroup=plumDelimiter end=")" contained extend
  \ contains=plumConstructor,plumDelimiter

" Constructor
syn match plumConstructor "\%(\<class\s\+\)\@15<!\<\u\w*\>"
syn region plumConstructorDecl matchgroup=plumConstructor start="\<[A-Z]\w*\>" end="\(|\|$\)"me=e-1,re=e-1 contained
  \ containedin=plumData,plumNewtype
  \ contains=plumType,plumTypeVar,plumDelimiter,plumOperatorType,plumOperatorTypeSig,@plumComment


" Function
syn match plumFunction "\%(\<instance\s\+\|\<class\s\+\)\@18<!\<[_a-z]\(\w\)*\>" contained
" syn match plumFunction "\<[_a-z]\(\w\)*\>" contained
syn match plumFunction "(\%(\<class\s\+\)\@18<!\(\W\&[^(),\"]\)\+)" contained extend
syn match plumBacktick "`[_A-Za-z][A-Za-z0-9_\.]*`"

" Class
syn region plumClassDecl start="^\%(\s*\)class\>"ms=e-5 end="\<where\>\|$"
  \ contains=plumClass,plumClassName,plumOperatorType,plumOperator,plumType,plumWhere
  \ nextgroup=plumClass
  \ skipnl
syn match plumClass "\<class\>" containedin=plumClassDecl contained
  \ nextgroup=plumClassName
  \ skipnl
syn match plumClassName "\<[A-Z]\w*\>" containedin=plumClassDecl contained

" Module
syn match plumModuleName "\(\u\w\*\.\?\)*" contained excludenl
syn match plumModuleKeyword "\<module\>"
syn match plumModule "^module\>\s\+\<\(\w\+\.\?\)*\>"
  \ contains=plumModuleKeyword,plumModuleName
  \ nextgroup=plumModuleParams
  \ skipwhite
  \ skipnl
  \ skipempty
syn region plumModuleParams start="(" skip="([^)]\{-})" end=")" fold contained keepend
  \ contains=plumClassDecl,plumClass,plumClassName,plumDelimiter,plumType,plumTypeExport,plumStructure,plumModuleKeyword,@plumComment
  \ nextgroup=plumImportParams skipwhite

" Import
syn match plumImportKeyword "\<\(foreign\|import\)\>"
syn match plumImport "\<import\>\s\+\<\(\w\+\.\?\)*"
  \ contains=plumImportKeyword,plumModuleName
  \ nextgroup=plumImportParams,plumImportAs,plumImportHiding
  \ skipwhite
syn region plumImportParams
  \ start="("
  \ skip="([^)]\{-})"
  \ end=")"
  \ contained
  \ contains=plumClass,plumClass,plumStructure,plumType,plumIdentifier
  \ nextgroup=plumImportAs
  \ skipwhite
syn keyword plumAsKeyword as contained
syn match plumImportAs "\<as\>\_s\+\u\w*"
  \ contains=plumAsKeyword,plumModuleName
  \ nextgroup=plumModuleName
syn keyword plumHidingKeyword hiding contained
syn match plumImportHiding "hiding"
  \ contained
  \ contains=plumHidingKeyword
  \ nextgroup=plumImportParams
  \ skipwhite

" Function declaration
syn region plumFunctionDecl
  \ excludenl start="^\z(\s*\)\(\(foreign\)\_s\+\)\?[_a-z]\(\w\)*\_s\{-}\(::\)"
  \ end="^\z1\=\S"me=s-1,re=s-1 keepend
  \ contains=plumFunctionDeclStart,plumForall,plumOperatorType,plumOperatorTypeSig,plumType,plumTypeVar,plumDelimiter,@plumComment
syn region plumFunctionDecl
  \ excludenl start="^\z(\s*\)where\z(\s\+\)[_a-z]\(\w\)*\_s\{-}\(::\|∷\)"
  \ end="^\(\z1\s\{5}\z2\)\=\S"me=s-1,re=s-1 keepend
  \ contains=plumFunctionDeclStart,plumForall,plumOperatorType,plumOperatorTypeSig,plumType,plumTypeVar,plumDelimiter,@plumComment
syn region plumFunctionDecl
  \ excludenl start="^\z(\s*\)let\z(\s\+\)[_a-z]\(\w\)*\_s\{-}\(::\|∷\)"
  \ end="^\(\z1\s\{3}\z2\)\=\S"me=s-1,re=s-1 keepend
  \ contains=plumFunctionDeclStart,plumForall,plumOperatorType,plumOperatorTypeSig,plumType,plumTypeVar,plumDelimiter,@plumComment
syn match plumFunctionDeclStart "^\s*\(\(foreign\|let\|where\)\_s\+\)\?\([_a-z]\(\w\)*\)\_s\{-}\(::\)" contained
  \ contains=plumImportKeyword,plumWhere,plumLet,plumFunction,plumOperatorType
syn keyword plumForall forall

" Keywords
syn keyword plumConditional if then else
syn keyword plumStatement do case of in ado
syn keyword plumLet let
syn keyword plumWhere where
syn match plumStructure "\<\(data\|newtype\|type\|kind\)\>"
  \ nextgroup=plumType skipwhite
syn keyword plumStructure derive
syn keyword plumStructure instance
  \ nextgroup=plumFunction skipwhite

" Infix
syn match plumInfixKeyword "\<\(infix\|infixl\|infixr\)\>"
syn match plumInfix "^\(infix\|infixl\|infixr\)\>\s\+\([0-9]\+\)\s\+\(type\s\+\)\?\(\S\+\)\s\+as\>"
  \ contains=plumInfixKeyword,plumNumber,plumAsKeyword,plumConstructor,plumStructure,plumFunction
  \ nextgroup=plumFunction,plumOperator,@plumComment

" Operators
syn match plumOperator "\([-!#$%&\*\+/<=>\?@\\^|~:]\|\<_\>\)"
syn match plumOperatorType "\%(\<instance\>.*\)\@40<!\(::\)"
  \ nextgroup=plumForall,plumType skipwhite skipnl skipempty
syn match plumOperatorFunction "\(->\|<-\|[\\]\)"
syn match plumOperatorTypeSig "\(->\|<-\|=>\|<=\|::\)" contained
  \ nextgroup=plumType skipwhite skipnl skipempty

" Type definition
syn region plumData start="^data\s\+\([A-Z]\w*\)" end="^\S"me=s-1,re=s-1 transparent
syn match plumDataStart "^data\s\+\([A-Z]\w*\)" contained
  \ containedin=plumData
  \ contains=plumStructure,plumType,plumTypeVar
syn match plumForeignData "\<foreign\s\+import\s\+data\>"
  \ contains=plumImportKeyword,plumStructure
  \ nextgroup=plumType skipwhite

syn region plumNewtype start="^newtype\s\+\([A-Z]\w*\)" end="^\S"me=s-1,re=s-1 transparent
syn match plumNewtypeStart "^newtype\s\+\([A-Z]\w*\)" contained
  \ containedin=plumNewtype
  \ contains=plumStructure,plumType,plumTypeVar

syn region plumTypeAlias start="^type\s\+\([A-Z]\w*\)" end="^\S"me=s-1,re=s-1 transparent
syn match plumTypeAliasStart "^type\s\+\([A-Z]\w*\)" contained
  \ containedin=plumTypeAlias
  \ contains=plumStructure,plumType,plumTypeVar

" String
syn match plumChar "'[^'\\]'\|'\\.'\|'\\u[0-9a-fA-F]\{4}'"
syn region plumString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell

" Attribute
syn region plumAttrComment matchgroup=plumAttrComment start="--|" end="$"
  \ contains=plumAttr,plumName,plumNumber,plumFloat,plumString,plumChar,plumDelimiter,plumOperator,@Spell
syn match plumAttr "@[a-zA-Z_][a-zA-Z0-9_]*"

" Comment
syn match plumLineComment "--\([^|].*\)\?$" contains=@Spell
" syn region plumBlockComment start="{-" end="-}" fold
  " \ contains=plumBlockComment,@Spell
syn cluster plumComment contains=plumLineComment,@Spell

syn sync minlines=50

" highlight links
highlight def link plumModule Include
highlight def link plumImport Include
highlight def link plumModuleKeyword plumKeyword
highlight def link plumImportAs Include
highlight def link plumModuleName Include
highlight def link plumModuleParams plumDelimiter
highlight def link plumImportKeyword plumKeyword
highlight def link plumAsKeyword plumKeyword
highlight def link plumHidingKeyword plumKeyword

highlight def link plumConditional Conditional
highlight def link plumWhere plumKeyword
highlight def link plumInfixKeyword plumKeyword

highlight def link plumBoolean Boolean
highlight def link plumNumber Number
highlight def link plumFloat Float

highlight def link plumDelimiter Delimiter

highlight def link plumOperatorTypeSig plumOperatorType
highlight def link plumOperatorFunction plumOperatorType
highlight def link plumOperatorType plumOperator

highlight def link plumConstructorDecl plumConstructor
highlight def link plumConstructor plumFunction

highlight def link plumTypeVar Identifier
highlight def link plumForall plumStatement

highlight def link plumChar String
highlight def link plumBacktick plumOperator
highlight def link plumString String
highlight def link plumMultilineString String

highlight def link plumLineComment plumComment
" highlight def link plumBlockComment plumComment

highlight def link plumAttrComment SpecialComment
highlight def link plumAttr PreProc
highlight def link plumName plumIdentifier

" plum general highlights
highlight def link plumClass plumKeyword
highlight def link plumClassName Type
highlight def link plumStructure plumKeyword
highlight def link plumKeyword Keyword
highlight def link plumStatement Statement
highlight def link plumLet Statement
highlight def link plumOperator Operator
highlight def link plumFunction Function
highlight def link plumType Type
highlight def link plumComment Comment

let b:current_syntax = "plum"
