#! /bin/bash

RED='\033[91m'
GREEN='\033[92m'
YELOW='\033[93m'
ENDCOLOR='\033[0m'
LOG=$MY_PATH'/test.log'
#####################################################
echo -e "$GREEN######################################################################$ENDCOLOR"
echo -e "$GREEN##                         Запуск скрипта.                          ##$ENDCOLOR"
echo -e "$GREEN######################################################################$ENDCOLOR"

sudo apt-get update > $LOG 
######################################################
sudo apt install nginx -y
if [ $? -ne 0 ]; then
	echo -e "$RED######################################################################$ENDCOLOR"
	echo -e "$RED##                   Ошибка при установке NGINX                     ##$ENDCOLOR"
	echo -e "$RED######################################################################$ENDCOLOR"
else
	echo -e "$GREEN######################################################################$ENDCOLOR"
	echo -e "$GREEN##                 NGINX успешно установлен!                        ##$ENDCOLOR"
	echo -e "$GREEN######################################################################$ENDCOLOR"
fi
#####################################################
cd /var/www/html/
sudo rm -rf index.nginx-debian.html 
touch index.html
cat > index.html <<EOF
<!DOCTYPE html>
<html lang="ru">
<head>
	<meta charset="UTF-8">
	<title>Jazz</title>
	<link rel="stylesheet" href ="test.css">
	<link href="https://fonts.googleapis.com/css2?family=Lobster&display=swap" rel="stylesheet">
</head>
<body>

<button id="show">Hello, World!</button>
</body>
</html>
EOF

touch test.css 
cat > test.css <<END
* {
	font-family: "Lobster", sans-serif;
	box-sizing: border-box;
	font-weight: 300;
}
body {
	background: #FF5F6D;
	background: -webkit-linear-gradient(to right, #FFC371, #FF5F6D);
	background: linear-gradient(to right, #FFC371, #FF5F6D);

	color: white;
	padding: 50px;
}

#show {
	display: block;
	border: none;
	margin-top: 150px;

	background: #16BFFD;
	background: -webkit-linear-gradient(to right, #CB3066, #16BFFD);
	background: linear-gradient(to right, #CB3066, #16BFFD);
	border-radius: 10px;
	padding: 20px;
	color: white;
	outline: none;
	width: 100%;
	font-size: 20px;
	text-transform: uppercase;
	font-weight: bold;
	cursor: pointer;

}

#show:hover {
	opacity: .9;
}
END
#####################################################
if [ $? -ne 0 ]; then
        echo -e "$RED######################################################################$ENDCOLOR"
        echo -e "$RED##                  Ошибка при создании файла.                      ##$ENDCOLOR"
        echo -e "$RED######################################################################$ENDCOLOR"
else
        echo -e "$GREEN######################################################################$ENDCOLOR"
        echo -e "$GREEN##          Создаём и заполняем необходимые файлы.                      ##$ENDCOLOR"
        echo -e "$GREEN######################################################################$ENDCOLOR"
fi
cd /etc/nginx/sites-available/
sudo rm -rf default
sudo touch sett.conf
if [ $? -ne 0 ]; then
        echo -e "$RED######################################################################$ENDCOLOR"
        echo -e "$RED##                  Ошибка при создании файла.                      ##$ENDCOLOR"
        echo -e "$RED######################################################################$ENDCOLOR"
else
        echo -e "$GREEN######################################################################$ENDCOLOR"
        echo -e "$GREEN##               Создаём конфиг и даём ему права.                   ##$ENDCOLOR"
        echo -e "$GREEN######################################################################$ENDCOLOR"
fi
#######################################################
sudo chown alex sett.conf
sudo chmod 755 sett.conf 
sudo cat > sett.conf <<EOF
server {
        listen 80;
        root /var/www/html;
}
EOF
cd /etc/nginx/sites-enabled/
sudo rm -rf default
sudo ln -s ../sites-available/sett.conf
if [ $? -ne 0 ]; then
        echo -e "$RED######################################################################$ENDCOLOR"
        echo -e "$RED##                        Ошибка при настройке.                     ##$ENDCOLOR"
        echo -e "$RED######################################################################$ENDCOLOR"
else
        echo -e "$GREEN######################################################################$ENDCOLOR"
        echo -e "$GREEN##          Настраиваем конфиг файл NGINX и ссылку.                 ##$ENDCOLOR"
        echo -e "$GREEN######################################################################$ENDCOLOR"
fi
#######################################################
sudo systemctl restart nginx
if [ $? -ne 0 ]; then
        echo -e "$RED######################################################################$ENDCOLOR"
        echo -e "$RED##                        Ошибка при настройке.                     ##$ENDCOLOR"
        echo -e "$RED######################################################################$ENDCOLOR"
else
        echo -e "$GREEN######################################################################$ENDCOLOR"
        echo -e "$GREEN##                            Все готово!                           ##$ENDCOLOR"
        echo -e "$GREEN######################################################################$ENDCOLOR"
fi

