#!/bin/sh
echo "Hola, ¿Quieres sabes cuentos archivos hay en este directorio?"
NUMFILES="$(ls -l | wc -l)"
RESULTADO=$(($NUMFILES-1))
echo "Hay: 			| ${RESULTADO} | "
