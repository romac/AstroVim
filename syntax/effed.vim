" " Effed.vim - Syntax file for Effed language
"
" if exists("b:current_syntax")
"   finish
" endif
"
" syntax keyword EffedKeyword effect val handler handle with if then else return finally resume do new def
"
" " Define syntax highlighting for the Effed language
" syntax match EffedFunction /\v\w+\s*\(.*\)/
" syntax match EffedOperator /=>\|\|/
" syntax match EffedIdentifier /\v\w+/
" syntax match EffedBuiltin /\v#\w+/
" syntax match EffedType /\v[A-Z]\w*/
" syntax match EffedNumber /\v\d+/
" syntax match EffedBoolean /\vTrue|False/
" syntax region EffedString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell
"
" " Define syntax highlighting for comments
" syntax match EffedComment "//.*" contains=@Spell
" syntax region EffedComment start="/\*" end="\*/" contains=@Spell
"
" " Define the colors for each syntax group
" highlight link EffedKeyword Keyword
" highlight link EffedFunction Function
" highlight link EffedOperator Operator
" highlight link EffedIdentifier Identifier
" highlight link EffedBuiltin Special
" highlight link EffedType Type
" highlight link EffedNumber Number
" highlight link EffedBoolean Boolean
" highlight link EffedComment Comment
" highlight link EffedString String
"
" let b:current_syntax = "effed"
