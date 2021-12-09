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

	#--------------------------------------------------------------------
	#							PEDIDO
	#--------------------------------------------------------------------

	#Pedimos el importe y controlamos que sea un valor numerico
	read -r -p "Introduce el importe: " importe

    compro=`expr $importe \* 1 2> /dev/null`
    while [ $? -ne 0 ]
    do
        echo "[RuizalBank] --> El importe introducido no es correcto"
        read -r -p "Introduce el importe: " importe
        #compro=`exrp $importe \* 1 2> /dev/null`
    done

    while [ $importe -gt 0 -o $importe -le 99999999 ]
    do
        echo "[RuizalBank] --> El importe introducido no es correcto"
        read -r -p "Introduce el importe: " importe
    done
			
	echo "Fecha del importe"
	
	#--------------------------------------------------------------------
	#								DÍA
	#--------------------------------------------------------------------

	trueDay = false;
	#Pedimos el dia /mes /año
    read -r -p "Dia: " dia
	#Hacemos el control de errores y hacemos la comprobacion
    compro=`expr $dia \* 1 2> /dev/null`

    while [ $? -ne 0 ]
    do
        echo "[RuizalBank] --> El dia introducido no es correcto"
        read -r -p "Día: " dia
        compro=`exrp $dia \* 1 2> /dev/null`
    done

    while [ $dia -lt 1 -o $dia -gt 31 ]
    do
        echo "[RuizalBank] --> El dia introducido no es correcto"
        read -r -p "Día: " dia
    done

	while [ !trueDay ]; do
		if [ $? -ne 0 ]; then
			echo "[RuizalBank] --> El dia introducido no es correcto"
        	read -r -p "Día: " dia
        	compro=`exrp $dia \* 1 2> /dev/null`
		else
			if [ $dia -ge 1 -o $dia -le 31 ]; then
				$trueDay = true;
			else
				if [ $? -ne 0 ]; then
					echo "[RuizalBank] --> El dia introducido no es correcto"
	        		read -r -p "Día: " dia
    		    	compro=`exrp $dia \* 1 2> /dev/null`
				fi
			fi
		fi
	done
	#--------------------------------------------------------------------
	#								MES
	#--------------------------------------------------------------------

    read -r -p "Mes: " mes

    compro=`expr $mes \* 1 2> /dev/null`
    while [ $? -ne 0 ]
    do
        echo "[RuizalBank] --> El mes introducido no es correcto"
        read -r -p "Mes: " mes
        compro=`exrp $mes \* 1 2> /dev/null`
    done

    while [ $mes -lt 1 -o $mes -gt 12 ]
    do
        echo "[RuizalBank] --> El mes introducido no es correcto"
        read -r -p "Mes: " mes
    done
        
	#--------------------------------------------------------------------
	#								AÑO
	#--------------------------------------------------------------------

    read -r -p "Año: " anyo

    compro=`expr $anyo \* 1 2> /dev/null`
    while [ $? -ne 0 ]
    do
        echo "[RuizalBank] --> El año introducido no es correcto"
        read -r -p "Año: " anyo
        compro=`exrp $anyo \* 1 2> /dev/null`
    done

    while [ $anyo -lt 1000 -o $anyo -gt 3000 ]
    do
        echo "[RuizalBank] --> El año introducido no es correcto"
        read -r -p "Año: " anyo
    done

    echo "$di:$descripcion:$importe:$dia:$mes:$anyo" >> "$datos"

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
