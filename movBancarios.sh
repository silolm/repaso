#!/bin/bash
file="$HOME/movimientos.txt"


# Función Opciones del Menú

function menu() {
cat << options
     		   Registros Bancarios
  [1]  Visualizar todos los movimientos
  [2]  Añadir nuevo movimiento
  [3]  Buscar un movimiento
  [4]  Eliminar un movimiento
  [5]  Salir

options
}


# Función elegir opción del menu

function selectOption() {
# llamamos a la función menu"
menu
# seleccionamos una opción del menú"
read -r -p "Elige una opción: " option
clear

case "$option" in
	1) viewOperations ;;
	2) newMove ;;
	3) searchOperation ;;
	4) deleteOperation ;;
	5) salir ;;
esac
}



function viewOperations() {
	echo "--------------------------------------------------------"
	echo "		  Visualizar todos los movimientos"
	echo "--------------------------------------------------------"

#lo vamos a ordenar por fecha
awk '
BEGIN { FS = OFS = ":" }
{gsub(/\:/, "/", $4)} 1' "$file"


selectOption
}


# Function add new move

function newMove() {
	echo "--------------------------------------------------------"
	echo "			Añadir nuevo movimiento"
	echo "--------------------------------------------------------"

	read -r -p "Introduce una descripción: " descripcion
	read -r -p "Introduce el importe: " importe
	echo "Fecha de nacimiento"
	read -r -p "Día [1-31]: " dia
	read -r -p "Mes [1-12]: " mes
	read -r -p "Año : " anyo

	echo "$descripcion:$importe:$dia:$mes:$anyo" >> "$file"

	selectOption
}


# Function search operation

function searchOperation() {
	echo "--------------------------------------------------------"
	echo "			Buscar operación"
	echo "--------------------------------------------------------"

	read -r -p "Introduce el concepto o parte de él: " concepto

	grep "$concepto" "$file"

	selectOption
}


# Function search operation

function deleteOperation() {
	echo "--------------------------------------------------------"
	echo "			Eliminar operación"
	echo "--------------------------------------------------------"

	selectOption
}

function salir() {
	exit 0
}

selectOption
