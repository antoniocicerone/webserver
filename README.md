# webserver

$ docker pull antoniocicerone/webserver

$ docker container run -d --name webserver -p 80:80 -v ~/Desktop/aaa:/var/www/html antoniocicerone/webserver
