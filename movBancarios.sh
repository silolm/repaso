#!/bin/bash
file="$HOME/movimientos.dat"

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
	echo "--------------------------------------------------------------------"
	echo "		  Visualizar todos los movimientos"
	echo "--------------------------------------------------------------------"

	if [ -s "$file" ]; then
	   #lo vamos a ordenar por fecha
	   awk -F : '{print "Id: "$1" Concepto: "$2" Importe: "$3" Fecha de nacimiento: "$4"/"$5"/"$6}' "$file"
	   echo -e "\n\n\n"
	else
	   echo -e "No hay movimientos \n\n\n"
	fi


selectOption
}


# Function add new move

function newMove() {
	reDia='^[1-31]+$'
	reMes='^[1-12]+$'
	reAnyo='^[1900-2900]+$'

	echo "--------------------------------------------------------------------"
	echo "			Añadir nuevo movimiento"
	echo "--------------------------------------------------------------------"

	if [ -s "$file" ]; then
	   di=$(awk 'END {print NR}' "$file")
	else
	   di=0
	fi

			read -r -p "Introduce una descripción: " descripcion
			read -r -p "Introduce el importe: " importe
			echo "Fecha de nacimiento"

	while :
        	do
                	read -r -p "Día [1-31]: " dia
	                if [[ $dia =~ $reDia ]]; then
		                read -r -p "Mes [1-12]: " mes
        	        else
                	        echo -e "Fecha incorrecta \n"
				selectOption
               		fi

        	        if [[ $mes =~ $reMes ]]; then
	        	        read -r -p "Año: " anyo
	                else
        	                echo -e "Fecha incorrecta \n"
				selectOption
	                fi

                	if [[ $anyo =~ $reAnyo ]]; then
                        	echo "$di:$descripcion:$importe:$dia:$mes:$anyo" >> "$file"
				echo -e "\n\n"
				break
	                else
        	                echo -e "Fecha incorrecta \n"
				selectOption
                	fi
        done


	selectOption
}


# Function search operation

function searchOperation() {
	echo "--------------------------------------------------------------"
	echo "			Buscar operación"
	echo "--------------------------------------------------------------"

	read -r -p "Introduce el concepto o parte de él: " concepto

	grep "$concepto" "$file"

	selectOption
}


# Function search operation

function deleteOperation() {
	echo "--------------------------------------------------------------"
	echo "			Eliminar operación"
	echo "--------------------------------------------------------------"

	read -r -p "Indique el ID a eliminar: " del

	echo "¿Está seguro que quiere borrar el movimiento con el ID --> $del? [s/n]"
	read res;
	if [ "$res" == "s" ]; then
		sed -i /"$del"/d "$file"
		echo "El movimiento con ID --> $del ha sido borrado"
	else
		echo -e "Se ha cancelado la operación. \n\n"
	fi

	selectOption
}

function salir() {
	exit 0
}

selectOption
