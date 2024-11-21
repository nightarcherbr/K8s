echo off
set VERSION=%date:~6,4%%date:~3,2%%date:~0,2%%time:~0,2%%time:~3,2%
echo Construindo imagem %VERSION%
docker build -t webserver:r%VERSION% .

docker run -p 8080:80 -d webserver:r%VERSION%