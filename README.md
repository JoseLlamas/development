Crear archivo .env con el siguiente contenido
###
WORKSPACE=/home/tesla/workspace/
DEFAULT_USER=dorian
TIME_ZONE=UTC
####
crear red

docker network create --driver=bridge --subnet=172.18.0.0/16 my-ne--driver=bridge --subnet=172.18.0.0/24 my-nett

instalar

docker compose build --no-cache --pull

levantar

docker compose up -d

Para instalar una versión de node, entrar y ejecutar

npmp env use --global lts

esto instalará la versión lts de node
