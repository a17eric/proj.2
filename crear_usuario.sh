#!/bin/bash

# Asegura que el script es ejecutado por el superusuario.
if [[ "${UID}" -ne 0 ]]
then
	echo "No ets superusuari, no pots axecutar l'escript."
	exit 1
else
#Si el usuario no introduce ningun argumento, se le ayuda.
if [ -z "$1" ]
then
	echo "No es pot executar. El script requereix de parametres."
	exit 2
else
# Primer parametro para el nombre de usuario.
USER_NAME="$1"
# El resto de parametros para el campo de comentarios.
shift
COMMENT="$*"
# Genera una contraseña aleatoria de 8 caracters de minúscules i números.
PASSWORD=`cat /dev/urandom | tr -dc "a-z0-9" | head -c 8`

# Crear usuario.
useradd -m -c "${COMMENT}" ${USER_NAME}
# Comprobar que el usuario se a creado correctamente.
echo Comprobacion del usuario se a creado correctamente:
cat /etc/passwd | grep ${USER_NAME}
# Introducir contraseña.
echo "${USER_NAME}:${PASSWORD}" | chpasswd ${USER_NAME}
# Comprobar si se ha introducido la contraseña correctamente.
echo Comprobacion de la contraseña se a creado correctamente:
cat /etc/shadow | grep ${USER_NAME}
# Obligar a cambiar la contraseña en el primer login del usuario.
passwd -e ${USER_NAME}
# Mostrar el usuario, password y el host en el que se ha creado.
echo Usuari creat:
echo ${USER_NAME}
echo Password creat:
echo ${PASSWORD}
echo "Host en el que s'ha creat l'usuari:"
hostname
fi
fi
