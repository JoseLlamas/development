Crear archivo .env con el siguiente contenido
###
WORKSPACE=/home/tesla/workspace/
DEFAULT_USER=dorian
TIME_ZONE=America/Mexico_City
NODE_VERSION=19.7
####

para levantarlo

docker compose up -d

para encender o apagar

docker compose start
docker compose stop

install mariadb client

sudo apt install mariadb-client

instalar cliente universal

sudo snap install dbeaver-ce #o buscar el deb en internet

Manejo de NVM

Ver versiones de nvm de manera remota:

nvm ls-remote
 
de manera local

nvm ls

instalar una versión de node en especifico

nvm install 13.10.1 #Specific minor release
nvm install 14 #Specify major release only

nvm install node #install latest version of node
nvm install --lts --latest-npm #instalar versión lts

usar una versión en especifico de node

nvm use node
 
o

nvm use 13.10.1

ver versión actual de node ejecutandose

nvm current

Ejemplo de virtual host

<VirtualHost *:80>
	# The ServerName directive sets the request scheme, hostname and port that
	# the server uses to identify itself. This is used when creating
	# redirection URLs. In the context of virtual hosts, the ServerName
	# specifies what hostname must appear in the request's Host: header to
	# match this virtual host. For the default virtual host (this file) this
	# value is not decisive as it is used as a last resort host regardless.
	# However, you must set it for any further virtual host explicitly.
	ServerName constanciasdejc.com
	ServerAlias www.constanciasdejc.com

	ServerAdmin abcd@gmail.com
	DocumentRoot /home/www/html/public

	# Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
	# error, crit, alert, emerg.
	# It is also possible to configure the loglevel for particular
	# modules, e.g.
	#LogLevel info ssl:warn

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>

o olvidar modificar el archivo /etc/hosts tanto del host como del huerped

