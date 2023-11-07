
%{
#include <kiraz/token.h>
using namespace kiraz::token;
using kiraz::Token;
%}


%option noyywrap
%option yylineno

OP_RETURNS ->
OP_EQUALS  ==
OP_ASSIGN  =
OP_GT      >
OP_LT      <
OP_GE      >=
OP_LE      <=
OP_LPAREN  \(
OP_RPAREN  \)
OP_LBRACE  \{
OP_RBRACE  \}
OP_PLUS    \+
OP_MINUS   \-
OP_MULT    \*
OP_DIVF    \/
OP_COMMA   ,
OP_NEWLINE \n
OP_COLON   :
OP_SCOLON  ;
OP_DOT     \.
OP_NOT     !

KW_IMPORT  import
KW_FUNC    func
KW_IF      if
KW_WHILE   while
KW_CLASS   class

LC_DEC     [0-9]
LC_HEX     [0-9A-Fa-f]
LC_TRUE    true
LC_FALSE   false

IDENTIFIER [a-zA-Z_][0-9a-zA-Z_]*
IGNORED    [ \t]

%%

{KW_IMPORT}     { Token::char_pos+=yyleng;  return Token::feed(KeywordImport()); }
{KW_FUNC}       { Token::char_pos+=yyleng;  return Token::feed(KeywordFunc()); }
{KW_IF}         { Token::char_pos+=yyleng;  return Token::feed(KeywordIf()); }
{KW_WHILE}      { Token::char_pos+=yyleng;  return Token::feed(KeywordWhile()); }
{KW_CLASS}      { Token::char_pos+=yyleng;  return Token::feed(KeywordClass()); }
{LC_TRUE}       { Token::char_pos+=yyleng;  return Token::feed(Boolean(true)); }
{LC_FALSE}      { Token::char_pos+=yyleng;  return Token::feed(Boolean(false)); }

{LC_DEC}+       { Token::char_pos+=yyleng;  return Token::feed(Integer::createDecimalInteger(yytext)); }
0x{LC_HEX}+     { Token::char_pos+=yyleng;  return Token::feed(Integer::createHexadecimalInteger(yytext)); }
\"[^\"]+\"      { Token::char_pos+=yyleng;  return Token::feed(String(yytext)); }

{OP_RETURNS}    { Token::char_pos+=yyleng;  return Token::feed(OperatorReturns()); }
{OP_EQUALS}     { Token::char_pos+=yyleng;  return Token::feed(OperatorEquals()); }
{OP_ASSIGN}     { Token::char_pos+=yyleng;  return Token::feed(OperatorAssign()); }
{OP_GT}         { Token::char_pos+=yyleng;  return Token::feed(OperatorGt()); }
{OP_LT}         { Token::char_pos+=yyleng;  return Token::feed(OperatorLt()); }
{OP_GE}         { Token::char_pos+=yyleng;  return Token::feed(OperatorGe()); }
{OP_LE}         { Token::char_pos+=yyleng;  return Token::feed(OperatorLe()); }
{OP_LPAREN}     { Token::char_pos+=yyleng;  return Token::feed(OperatorLParen()); }
{OP_RPAREN}     { Token::char_pos+=yyleng;  return Token::feed(OperatorRParen()); }
{OP_LBRACE}     { Token::char_pos+=yyleng;  return Token::feed(OperatorLBrace()); }
{OP_RBRACE}     { Token::char_pos+=yyleng;  return Token::feed(OperatorRBrace()); }
{OP_PLUS}       { Token::char_pos+=yyleng;  return Token::feed(OperatorPlus()); }
{OP_MINUS}      { Token::char_pos+=yyleng;  return Token::feed(OperatorMinus()); }
{OP_MULT}       { Token::char_pos+=yyleng;  return Token::feed(OperatorMult()); }
{OP_DIVF}       { Token::char_pos+=yyleng;  return Token::feed(OperatorDivF()); }
{OP_COMMA}      { Token::char_pos+=yyleng;  return Token::feed(OperatorComma()); }
{OP_NEWLINE}+   { Token::char_pos=0;  return Token::feed(OperatorNewline()); }
{OP_COLON}      { Token::char_pos+=yyleng;  return Token::feed(OperatorColon()); }
{OP_SCOLON}+    { Token::char_pos+=yyleng;  return Token::feed(OperatorScolon()); }
{OP_DOT}        { Token::char_pos+=yyleng;  return Token::feed(OperatorDot()); }
{OP_NOT}        { Token::char_pos+=yyleng;  return Token::feed(OperatorNot()); }

{IDENTIFIER}    { Token::char_pos+=yyleng;  return Token::feed(Identifier(yytext)); }

{IGNORED}+      {Token::char_pos+=yyleng; };
.               { Token::char_pos+=yyleng;  return Token::feed(Rejected(yytext)); }

%%