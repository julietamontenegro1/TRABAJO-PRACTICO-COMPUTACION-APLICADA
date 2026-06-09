#!/bin/bash

LOG="/var/log/backup_full.log"

log() {
	echo "$(date '+%Y-%m-%d %H:%m:%s') - $1" >> $LOG
}

if  [ "$1" = "-help" ]; then
	echo "Uso: backup_full.sh <origen> <destino>"
	echo "Ejemplo: backup_full.sh /var/log/ /backup_dir"
	exit 0
fi

if [-z "$1" ] || [ -z "$2" ];then
	log "ERROR: faltan argumentos."
	echo "Error: faltan argumentos. Usa -help para ayuda."
	exit 1
fi


ORIGEN=$1
DESTINO=$2
FECHA=$(date +%Y%m%d)
NOMBRE=$(basename $ORIGEN)

if [ ! -d "$ORIGEN" ]; then
	log "ERROR: origen $ORIGEN no existe."
	echo "Error: origen $ORIGEN no existe."
	exit 1
fi

if [ ! -d "$DESTINO" ]; then
	log "ERROR: destino $DESTINO no existe."
	echo "Error: destino $DESTINO no existe."
	exit 1
fi

tar -czf "$DESTINO/${NOMBRE}_bkp_${FECHA}.tar.gz" "$ORIGEN"


if [ $? -eq 0 ]; then
	log "OK: backup de $ORIGEN guardado en $DESTINO/${NOMBRE}_bkp_${FECHA}.tar.gz"
	echo "Backup realizado correctamente."
else
	log "ERROR: fallo el backup de $ORIGEN."
	echo "Error: fallo el backup."
	exit 1
fi
