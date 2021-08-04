/*
* Filename          scan.l
* Date              4/7/2021
* Author            Toni Avila
* Email             txa180025@utdallas.edu
* Course            SE 3377.0W6 Spring 2021
* Version           1.0
* Copyright         2021, All Rights Reserved
*
* Description:
*
*   This lex program uses regex to match tokens in our input file.
*
*/



%option noyywrap
%option nounput
%option noinput

%{ #include <stdlib.h>
   #include "y.tab.h"
%}

%%

[ \t\r]+             {/* whitespace */}
(IX|IV|V?I{0,3})     {yylval.str = yytext; return ROMANTOKEN;}
[a-zA-Z]\.?          {yylval.str = yytext; return NAME_INITIAL_TOKEN;}
[a-zA-Z]+            {yylval.str = yytext; return NAMETOKEN;}
Sr.                  {return SRTOKEN;}
Jr.                  {return JRTOKEN;}
[\n]                 {return EOLTOKEN;}
[0-9]+               {yylval.value = atoi(yytext); return INTTOKEN;}
#                    {return HASHTOKEN;}
-                    {return DASHTOKEN;}
,                    {return COMMATOKEN;}
^[0-9]+[A-Za-z]+     {yylval.str = yytext; return IDENTIFIERTOKEN;}

%%
/* do not put main here*/
