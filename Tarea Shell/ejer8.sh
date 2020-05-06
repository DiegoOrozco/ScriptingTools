#!/bin/sh
CANTPERSONA=$1
COUNT=1
while [ $CANTPERSONA -gt 0 ]
do
	echo "Cual es el nombre?"
	read NOMBRE
	echo "Cual es el apellido?"
	read APELLIDO
	echo "Cual es la cedula?"
	read CEDULA

	touch "${CEDULA}_datos.txt"
done
