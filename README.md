# Lenguajes
El archivo de entrada necesita estar en el directorio downloads ya que la ruta es estatica, sin embargo puede ser cambiado en el codigo donde esta la ruta del achivo.
Se debe utilizar el archivo *.lex junto con la herramienta "Flex".
luego se compila con gcc y se hace el link con -lcl.
esto genera un archivo ejecutable con extension *.out, llamado "miniPHP.out"
luego se ejecuta y el programa reconocera el lexico del archivo.
si el formato es correcto se escribira en el archivo con minisculas, de lo contrario se llevara un registro de los erorres encontrados en el archivo de entrada.
