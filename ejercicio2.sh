#!/bin/bash

check_file_or_directory() {
    if [ -f "$1" ]; then
        echo "$1 es un archivo."
    elif [ -d "$1" ]; then
        echo "$1 es un directorio."
    else
        echo "$1 no existe."
    fi
}

get_size_in_mb() {
    if [ -e "$1" ]; then
        du -sh "$1" | awk '{print $1}'
    else
        echo "$1 no existe."
    fi
}

suggest_options() {
    echo "Por favor, pase uno de los siguientes argumentos:"
    echo "1. Comprobar si es archivo o directorio."
    echo "2. Obtener el tamaño en MB de un archivo o directorio."
    echo "3. Saludo personalizado."
    echo "4. Mostrar información de un comando."
    echo "5. Crear un backup comprimido en formato TAR-GZIP."
}

greet_user() {
    echo "Hola, $USER. Bienvenido a tty1."
}

show_command_info() {
    man "$1"
}

create_backup() {
    local timestamp=$(date +%H%M%S)
    local backup_name="backup-$timestamp.tar.gz"
    tar -czvf "$backup_name" /home/myusuario
    if [ $? -ne 0 ]; then
        echo "Hubo un error al crear el backup."
    else
        echo "Backup creado exitosamente: $backup_name"
    fi
}

OPCIONES=("1- Comprobar archivo/directorio" "2- Obtener tamaño en MB" "3- Saludo personalizado" "4- Mostrar información de un comando" "5- Crear backup" "6- Salir")
select opt in "${OPCIONES[@]}"; do
    case $REPLY in
        1)
            echo "Ingrese el nombre del archivo o directorio:"
            read input
            check_file_or_directory "$input"
            ;;
        2)
            echo "Ingrese el nombre del archivo o directorio:"
            read input
            get_size_in_mb "$input"
            ;;
        3)
            greet_user
            ;;
        4)
            echo "Ingrese el nombre del comando:"
            read input
            show_command_info "$input"
            ;;
        5)
            create_backup
            ;;
        6)
            echo "Saliendo..."
            break
            ;;
        *)
            suggest_options
            ;;
    esac
done

