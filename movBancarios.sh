#!/bin/bash
file="$HOME/repaso/movimientos.dat"

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
				
	echo "Fecha del importe"
	
	#--------------------------------------------------------------------
	#								DÍA
	#--------------------------------------------------------------------

	trueDay=0
	#Pedimos el dia /mes /año
    read -r -p "Dia: " dia
	#Hacemos el control de errores y hacemos la comprobacion
    dayCheck=`expr $dia \* 1 2> /dev/null`

	while [[ "$trueDay" -eq 0 ]]; do
		if [ $? -ne 0 ]; then
			echo "[1] --> El dia introducido no es correcto"
        	read -r -p "Día: " dia
        	dayCheck=`exrp $dia \* 1 2> /dev/null`
		else
			if [ $dia -ge 1 -o $dia -le 31 ]; then
				$trueDay=1;
				break
			else
				if [ $? -ne 0 ]; then
					echo "[2] --> El dia introducido no es correcto"
	        		read -r -p "Día: " dia
    		    	dayCheck=`exrp $dia \* 1 2> /dev/null`
				fi
			fi
		fi
	done
	#--------------------------------------------------------------------
	#								MES
	#--------------------------------------------------------------------
	trueMonth=0
    read -r -p "Mes: " mes
    monthCheck=`expr $mes \* 1 2> /dev/null`

	while [[ "$trueMonth" -eq 0 ]]; do
		if [ $? -ne 0 ]; then
			echo "[1] --> El mes introducido no es correcto"
        	read -r -p "Mes: " mes
        	monthCheck=`exrp $mes \* 1 2> /dev/null`
		else
			if [ $mes -ge 1 -o $mes -le 12 ]; then
				$trueMonth=1;
				break
			else
				if [ $? -ne 0 ]; then
					echo "[2] --> El dia introducido no es correcto"
	        		read -r -p "mes: " mes
    		    	monthCheck=`exrp $mes \* 1 2> /dev/null`
				fi
			fi
		fi
	done
    
	#--------------------------------------------------------------------
	#								AÑO
	#--------------------------------------------------------------------0
	trueYear=0
    read -r -p "Año: " anyo
    yearCheck=`expr $anyo \* 1 2> /dev/null`

	while [[ "$trueYear" -eq 0 ]]; do
		if [ $? -ne 0 ]; then
			echo "[1] --> El año introducido no es correcto"
        	read -r -p "Año: " anyo
        	yearCheck=`exrp $mes \* 1 2> /dev/null`
		else
			if [ $anyo -ge 1 -o $anyo -le 3000 ]; then
				$trueYear=1;
				break
			else
				if [ $? -ne 0 ]; then
					echo "[2] --> El mes introducido no es correcto"
	        		read -r -p "Año: " anyo
    		    	yearCheck=`exrp $anyo \* 1 2> /dev/null`
				fi
			fi
		fi
	done

    echo "$di:$descripcion:$importe:$dia:$mes:$anyo" >> "$file"

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
