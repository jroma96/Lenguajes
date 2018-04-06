reservadas	("clone"|"final"|"global"|"include_once"|"private"|"try"|"abstract"|"callable"|"enddeclare"|"finally"|"goto"|"instanceof"|"namespace"|"protected"|"static"|"yield"|"case"|"continue"|"insteadof"|"new"|"public"|"use"|"as"|"class"|"default"|"extends"|"function"|"include"|"print"|"require_once"|"trait")
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
cadenaDoble	\"[^\"]*\"
cadenaSimple	\'[^\"]*\'
expresion	{varID}[[:space:]]*({operadores}|{operadoresL})[[:space:]]*({varID}|{cadena}|{entero}|{Fnum}|{Exfnum})
inicioS	("{"|":"|"("|"[")
finalS	("}"|"endif"|"endwhile"|"endfor"|")"|"]")
cadena	({cadenaSimple}|{cadenaDoble})
identificador	[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*
constante	(("define("([[:space:]])*{cadena}([[:space:]])*","([[:space:]]*){cadena}([[:space:]])*")"([[:space:]])*";")|("const"[[:space:]]*{identificador}[[:space:]]*[=][[:space:]]*{cadena}[[:space:]]*";"))
varID		[\$]{identificador}
array		"array"[[:space:]]*
variable	{varID}[[:space:]]*[=][[:space:]]*({cadena}|{entero}|{Fnum}|{Exfnum}|{bool}|("&"{varID}))[[:space:]]*({operadores}[[:space:]]*({cadena}|{entero}|{Fnum}|{Exfnum}|{bool}|"&"{varID}))*[[:space:]]*";"
condicion	"("[[:space:]]*{varID}[[:space:]]*({operadoresL}[[:space:]]*({varID}|{cadena}|{entero}|{Fnum}|{Exfnum})[[:space:]]*)*")"
else	("else")
elseif	("elseif")[[:space:]]*{condicion}[[:space:]]*
if	("if")[[:space:]]*{condicion}[[:space:]]*
do		("do")
while		("while")[[:space:]]*{condicion}
condicionF	"("[[:space:]]*({expresion}?[[:space:]]*";")[[:space:]]*({expresion}?[[:space:]]*";")[[:space:]]*({varID}[[:space:]]*{operadores})?[[:space:]]*")"
for	"for"[[:space:]]*{condicionF}
condicionFE	"("[[:space:]]*({varID}|{array})[[:space:]]*"as"[[:space:]]*{varID}[[:space:]]*({operadoresL}[[:space:]]*{varID}[[:space:]]*)*")"
foreach	"foreach"[[:space:]]*{condicionFE}
case	"case"[[:space:]]*({cadena}|{entero})
switch	"switch"[[:space:]]*{condicion}
echo	"echo"[[:space:]]*({cadena}|{varID})[[:space:]]*((","|".")?[[:space:]]*({varID}|{cadena}))*";"
include	"include"[[:space:]]*({cadena}|{varID})[[:space:]]*((","|".")?[[:space:]]*({varID}|{cadena}))*";"
continue	"continue"[[:space:]]*({entero}[[:space:]]*)*";"
return	"return"[[:space:]]*(({entero}|{varID})[[:space:]]*)*";"
varPredef("superglobals"|"$globals"|"$_server"|"$_get"|"$_post"|"$_files"|"$_request"|"$_session"|"$_env"|"$_cookie"|"$php_errormsg"|"$http_raw_post_data"|"$http_response_header"|"$argc"|"$argv")
funciones	("function"[[:space:]]*)?{identificador}[[:space:]]*"("[[:space:]]*({varID}[[:space:]]*(","[[:space:]]*)?)*")"
comentarios	(("//"|"#")[^\"\n]*)|("/*"[^\"]*"*/")
BD	{varID}[[:space:]]*"["[[:space:]]*{identificador}?[[:space:]]*"]"
%array
%%

{reservadas}	printf("palabra reservada: %s\n", yytext);
{operadores}	printf("operador: %s\n", yytext);
{entero}	printf("entero: %s\n", yytext);
{bool}		printf("booleano: %s\n", yytext);
{Fnum}		printf("decimal: %s\n", yytext);
{cadena}	printf("cadena: %s\n", yytext);
{varID}		printf("varID: %s\n", yytext);
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
{array}		printf("arreglo: %s\n", yytext);
{echo}		printf("instruccion echo: %s\n", yytext);
","		printf("separador de elementos: %s\n", yytext);
";"		printf("fin de instruccion: %s\n", yytext);
[[:space:]]	/*69*/
{funciones}	printf("funcion: %s\n", yytext);
{comentarios}	printf("comentario: %s\n", yytext);
{BD}		printf("Acceso a base de datos: %s\n", yytext);funcion2(yytext);
.		printf("Token no reconocido: %s\n", yytext);funcion(yytext);
<<EOF>>		Min();yyterminate();
%%
#include <stdio.h>
#include <ctype.h>
int error = 0;
main()
{
	
	//printf("Enter file path:\n");
	scanf("%c");
	FILE *errores = fopen("/home/dres/Downloads/errores.txt", "w");
	fclose(errores);
	FILE *archivo = fopen("/home/dres/Downloads/prueba.txt", "r+");
	yyrestart(archivo);
	yylex();
}
funcion(cadena1)
{
	error++;
	FILE *errores = fopen("/home/dres/Downloads/errores.txt", "a");
	fprintf(errores,"Token no reconocido: %s\n", cadena1);
	fclose(errores);
}
Min()
{
	if(error <1)
	{
		int a;
		FILE *salida = fopen("/home/dres/Downloads/prueba.out", "w+");
		FILE *archivo = fopen("/home/dres/Downloads/prueba.txt", "r+");
		do
   		{
      			a = fgetc(archivo);
      			if ( a != EOF )
      			{
         			a = tolower(a);
         			fputc(a, salida);
      			}
   		} while (a != EOF);
		fclose(salida);
		fclose(archivo);
	}
}
