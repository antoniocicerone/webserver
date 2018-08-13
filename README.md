# webserver

$ docker pull antoniocicerone/webserver

$ docker container run -d --name webserver -p 80:80 -v ~/Desktop/Progetti:/var/www/html antoniocicerone/webserver

$ docker container run -d --name webserver -p 80:80 -v ~/Desktop/Progetti:/var/www/html antoniocicerone/webserver:7.1

$ docker logs --tail 250 webserver
