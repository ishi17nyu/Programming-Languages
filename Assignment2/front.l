%{
#include <stdio.h>
#include<string.h>
#define IDENT 11
#define INT_LIT 10
#define INT_CODE 35
#define FLOAT_CODE 36
#define ASSIGN_OP 20
#define ADD_OP 21
#define SUB_OP 22
#define MULT_OP 23
#define DIV_OP 24
#define LEFT_PAREN 25
#define RIGHT_PAREN 26
#define LESSTHEN_OP 27
#define MORETHEN_OP 28
#define FOR_CODE 30
#define IF_CODE 31
#define ELSE_CODE 32
#define WHILE_CODE 33
#define DO_CODE 34
#define SWITCH_CODE 37
#define LETTER 9
#define DIGIT 12
#define UNKNOWN 99
#define INVALID 98
#define EOFL -1
int tokenValue;
int nextToken;
int lookup(char ch);
int getToken(int ntoken);
int keyLookup(char *);

%}

%%
[a-z][_a-zA-Z0-9]*    	return LETTER;
[0-9][0-9]* 		        return DIGIT;
[ \t]                   ;
[\n]                    return EOFL;
.                       return UNKNOWN;
%%

int main(int argc, char *argv)
{

int ntoken,vtoken;
ntoken = yylex();
while(ntoken)
{
vtoken = getToken(ntoken);
printf("Next token is : %d Next lexeme is %s \n",vtoken,yytext);
ntoken = yylex();
}
return 0;
}

int getToken(int ntoken)
{
switch(ntoken)
{
case LETTER:
tokenValue = keyLookup(yytext);
break;

case DIGIT:
tokenValue = INT_LIT;
break;

case EOFL:
tokenValue = EOFL;
yytext = "EOF";
break;

case UNKNOWN:
tokenValue = lookup(yytext[0]);
break;

default:
tokenValue = INVALID;
}
return tokenValue;
}

int keyLookup(char *yytext)
{

if(strcmp(yytext,"for") == 0)
{
 nextToken = FOR_CODE;
}
else if(strcmp(yytext,"int") == 0)
{
 nextToken = INT_CODE;
}
else if(strcmp(yytext,"float") == 0)
{
 nextToken = FLOAT_CODE;
}
else if(strcmp(yytext,"if") == 0)
{
 nextToken = IF_CODE;
}
else if(strcmp(yytext,"else") == 0)
{
 nextToken = ELSE_CODE;
}
else if(strcmp(yytext,"do") == 0)
{
 nextToken = DO_CODE;
}
else if(strcmp(yytext,"while") == 0)
{
 nextToken = WHILE_CODE;
}
else if(strcmp(yytext, "switch") == 0)
{
 nextToken = SWITCH_CODE;
}
else
{
 nextToken = IDENT;
}
return nextToken;

}

int lookup(char ch)
{

switch (ch) {
case '(':
nextToken = LEFT_PAREN;
break;

case ')':
nextToken = RIGHT_PAREN;
break;

case '+':
nextToken = ADD_OP;
break;

case '-':
nextToken = SUB_OP;
break;

case '*':
nextToken = MULT_OP;
break;

case '/':
nextToken = DIV_OP;
break;

case '=':
nextToken = ASSIGN_OP;
break;

case '<':
nextToken = LESSTHEN_OP;
break;

case '>':
nextToken = MORETHEN_OP;
break;

default:
nextToken = INVALID;
}
return nextToken;
}
