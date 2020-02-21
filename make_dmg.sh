#!/bin/sh

# Crea una imagen de disco que contiene bootstrappr y paquetes.

THISDIR=$(/usr/bin/dirname ${0})
DMGNAME="${THISDIR}/bootstrap.dmg"
if [[ -e "${DMGNAME}" ]] ; then
    /bin/rm "${DMGNAME}"
fi
/usr/bin/hdiutil create -fs HFS+ -srcfolder "${THISDIR}/bootstrap" "${DMGNAME}"
