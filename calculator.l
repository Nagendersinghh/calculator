%option noyywrap nodefault yylineno
%{
#include "calculator.h"
#include "calculator.tab.h"
%}

 /* float component */
EXP	([Ee][-+]?[0-9]+)

%%

 /* single charactor ops */
"+" |
"-" |
"*" |
"/" |
"=" |
"|" |
"," |
";" |
"(" |
")"	{ return yytext[0]; }

 /* comparison ops */
">"	{ yylval.fn = 1; return CMP; }
"<"	{ yylval.fn = 2; return CMP; }
"<>"	{ yylval.fn = 3; return CMP; }
"=="	{ yylval.fn = 4; return CMP; } 
">="	{ yylval.fn = 5; return CMP; } 
"<="	{ yylval.fn = 6; return CMP; }

 /* keywords */
"if"	{ return IF; }
"then"	{ return THEN; }
"else"	{ return ELSE; }
"while"	{ return WHILE; }
"do"	{ return DO; }
"let"	{ return LET; }

 /* built-in functions */
"sqrt"	{ yylval.fn = B_sqrt; return FUNC; }
"exp"	{ yylval.fn = B_exp; return FUNC; }
"log"	{ yylval.fn = B_log; return FUNC; }
"print"	{ yylval.fn = B_print; return FUNC; }

 /* names */
[a-zA-Z][0-9a-zA-Z]*	{ yylval.s = lookup(yytext); return NAME; }

[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]*{EXP}?	{ yylval.d = atof(yytext); return NUMBER; }

"//".*
[ \t] /* ignore whitespaces */

\\\n	{ printf(">"); }	/* ignore line continuation */
\n	{ return EOL; }

.	{ yyerror("Mystery character %c\n", *yytext); }
%%

