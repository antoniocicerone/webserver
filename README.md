# webserver

$ docker pull antoniocicerone/webserver

$ docker container run -d --name webserver -p 80:80 -v ~/Desktop/Progetti:/var/www/html antoniocicerone/webserver
