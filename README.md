docker build -t development:1.0 --no-cache --pull -f Dockerfile .

docker run -d -p 80:80 --name development --hostname development --memory="1G" --mount type=bind,source=/home/tesla/workspace,target=/home/dorian/workspace --restart always development:1.0

mariadb 

docker run --detach -p 3306:3306 --name mariadb --hostname mariadb --e MARIADB_ROOT_PASSWORD=root mariadb:10

docker run --detach -p 3306:3306 --name mariadb --env MARIADB_USER=mariadb --env MARIADB_PASSWORD=mariadb --env MARIADB_ROOT_PASSWORD=root  mariadb:latest

Cambiar el archivo /usr/local/etc/php.ini-development
a
/usr/local/etc/php/php.ini

install mariadb client

sudo apt install mariadb-client

entrar a mariadb server

mariadb -h localhost -u root -proot nombredb a mariadb server

mariadb -h localhost -u root -proot database_name

instalar cliente universal

sudo snap install dbeaver-ce #o buscar el deb en internet

instalar mongodb

docker run -d -p 27017:27017 --name mongodb --hostname mongodb \
	-e MONGO_INITDB_ROOT_USERNAME=root \
	-e MONGO_INITDB_ROOT_PASSWORD=root \
	mongo:6.0.3

Descargar e instalar Studio 3T for free desde la página

Instalar postgresql

docker run -d \
	--name postgresql \
	-e POSTGRES_PASSWORD=postgres \
	postgres:15.1

o latest

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
