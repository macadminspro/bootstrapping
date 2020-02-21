#!/bin/bash

# bootstrappr.sh
# Una secuencia de comandos para instalar paquetes y secuencias de comandos que se encuentran en una carpeta de paquetes en el mismo directorio
# como este script a un volumen seleccionado

if [[ $EUID != 0 ]] ; then
    echo "bootstrappr: Debe de ser root o correr como sudo."
    exit -1
fi

INDEX=0
OLDIFS=$IFS
IFS=$'\n'

echo "*** Bienvenido a bootstrappr! ***"
echo "Volumenes disponibles:"
for VOL in $(/bin/ls -1 /Volumes) ; do
    if [[ "${VOL}" != "OS X Base System" ]] ; then
        let INDEX=${INDEX}+1
        VOLUMES[${INDEX}]=${VOL}
        echo "    ${INDEX}  ${VOL}"
    fi
done
read -p "Volumen a instalar # (1-${INDEX}): " SELECTEDINDEX

SELECTEDVOLUME=${VOLUMES[${SELECTEDINDEX}]}

if [[ "${SELECTEDVOLUME}" == "" ]]; then
    exit 0
fi

echo
echo "Instalando paquetes en /Volumes/${SELECTEDVOLUME}..."

# dirname y basename no estan disponibles en modo Recovery
# así que podemos usar la coincidencia de patrones Bash
BASENAME=${0##*/}
THISDIR=${0%$BASENAME}
PACKAGESDIR="${THISDIR}packages"

for ITEM in "${PACKAGESDIR}"/* ; do
	FILENAME="${ITEM##*/}"
	EXTENSION="${FILENAME##*.}"
	if [[ -e ${ITEM} ]]; then
		case ${EXTENSION} in
			sh ) 
				if [[ -x ${ITEM} ]]; then
					echo "corriendo script:  ${FILENAME}"
					# pass the selected volume to the script as $1
					${ITEM} "/Volumes/${SELECTEDVOLUME}"
				else
					echo "${FILENAME} is not executable"
				fi
				;;
			pkg ) 
				echo "install package: ${FILENAME}"
				/usr/sbin/installer -pkg "${ITEM}" -target "/Volumes/${SELECTEDVOLUME}"
				;;
			* ) echo "extension no soportada: ${ITEM}" ;;
		esac
	fi
done

echo
echo "Paquetes instalados. Que desea hacer ahora?"
echo "    1  Reiniciar"
echo "    2  Apagar equipo"
echo "    3  Salir"
read -p "Escoja una opcion # (1-3): " WHATNOW

case $WHATNOW in
    1 ) /sbin/shutdown -r now ;;
    2 ) /sbin/shutdown -h now ;;
    3 ) echo ;;
esac
