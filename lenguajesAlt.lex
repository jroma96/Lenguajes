reservadas	("__halt_compiler()"|"clone"|"die()"|"empty()"|"final"|"global"|"include_once"|"list()"|"private"|"return"|"try"|"abstract"|"callable"|"enddeclare"|"finally"|"goto"|"instanceof"|"namespace"|"protected"|"static"|"unset()"|"yield"|"case"|"continue"|"insteadof"|"new"|"public"|"use"|"array()"|"as"|"class"|"default"|"extends"|"function"|"include"|"isset()"|"print"|"require_once"|"trait")[[:space:]]*";"
operadores	("+"|"-"|"*"|"/"|"%"|"**"|"="|"++"|"--"|"+=")
operadoresL	("and"|"or"|"xor"|"!"|"&&"|"||"|"=="|"<"|">"|"<="|"=>")
decimal	([1-9][0-9]*)|0
octal	0[0-7]+
hexadecimal	0[xX][0-9a-fA-f]+
binario	0b[01]+
entero	[+-]?({decimal}|{octal}|{hexadecimal}|{binario})
bool	("TRUE"|"true"|"false"|"FALSE")
Dnum	[0-9]+
Fnum	([0-9]*[\.]{Dnum})|({Dnum}[\.][0-9]*)
break	[[:space:]]*"break"[[:space:]]*";"[[:space:]]*
Exfnum	[+-]?(({Dnum}|{Fnum})[eE][+-]?{Dnum})
cadenaDoble	\"[^\"\']*\"
cadenaSimple	\'[^\"\']*\'
expresion	{varID}[[:space:]]*({operadores}|{operadoresL})[[:space:]]*({varID}|{cadena}|{entero}|{Fnum}|{Exfnum})
inicioS	("{"|":"|"("|"[")
finalS	("}"|"endif"|"endwhile"|"endfor"|")"|"]")
cadena	({cadenaSimple}|{cadenaDoble})
identificador	[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*
constante	(("define("([[:space:]])*{cadena}([[:space:]])*","([[:space:]]*){cadena}([[:space:]])*")"([[:space:]])*";")|("const"[[:space:]]*{identificador}[[:space:]]*[=][[:space:]]*{cadena}[[:space:]]*";"))
varID		[\$]{identificador}
array		"array"[[:space:]]*"("[[:space:]]*({cadena}[[:space:]]*{operadoresL}[[:space:]]*{cadena}([[:space:]]*",")?)*[[:space:]]*")"[[:space:]]*";"
variable	{varID}[[:space:]]*[=][[:space:]]*({cadena}|{entero}|{Fnum}|{Exfnum}|{bool}|("&"{varID}))[[:space:]]*({operadores}[[:space:]]*({cadena}|{entero}|{Fnum}|{Exfnum}|{bool}|"&"{varID}))*[[:space:]]*";"
condicion	"("[[:space:]]*{varID}[[:space:]]*{operadoresL}[[:space:]]*({varID}|{cadena}|{entero}|{Fnum}|{Exfnum})[[:space:]]*")"
else	("else")
elseif	("elseif")[[:space:]]*{condicion}[[:space:]]*
if	("if")[[:space:]]*{condicion}[[:space:]]*
do		("do")
while		("while")[[:space:]]*{condicion}
condicionF	"("[[:space:]]*({expresion}*[[:space:]]*";")[[:space:]]*({expresion}*[[:space:]]*";")[[:space:]]*({varID}[[:space:]]*{operadores})[[:space:]]*")"
for	"for"[[:space:]]*{condicionF}
condicionFE	"("[[:space:]]*{varID}[[:space:]]*"as"[[:space:]]*{varID}[[:space:]]*({operadoresL}[[:space:]]*{varID}[[:space:]]*)*")"
foreach	"foreach"[[:space:]]*{condicionFE}
finI	";"
%%

{reservadas}	printf("palabra reservada: %s\n", yytext);
{operadores}	printf("operador: %s\n", yytext);
{entero}	printf("entero: %s\n", yytext);
{bool}		printf("booleano: %s\n", yytext);
{Fnum}		printf("decimal: %s\n", yytext);
{varID}		printf("varID: %s\n", yytext);
{identificador}	printf("identificador: %s\n", yytext);
{constante}	printf("constante: %s\n", yytext);
{variable}	printf("variable: %s\n", yytext);
{inicioS}	printf("inicio estructura: %s\n", yytext);
{finalS}	printf("final estructura: %s\n", yytext);
{if}		printf("estructura de control IF: %s\n", yytext);
{elseif}	printf("estructura de control elseIF: %s\n", yytext);
{else}		printf("estructura de control ELSE: %s\n", yytext);
{break}		printf("salida del bucle: %s\n", yytext);
{while}		printf("estructura de control WHILE: %s\n", yytext);
{do}		printf("estructura de control DO: %s\n", yytext);
{for}		printf("estructura de control FOR: %s\n", yytext);
{foreach}	printf("estructura de control forEACH: %s\n", yytext);
.		scanf("");
%%
#include <stdio.h>
char name[];
main()
{
	
	//printf("Enter file path:\n");
	scanf("%c");
	FILE *archivo = fopen("/home/dres/Downloads/prueba.txt", "r+");
	yyrestart(archivo);
	yylex();
}
