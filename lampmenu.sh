#!/usr/bin/env bash
if [ ! -f ".env" ]; then
    cp .env.example .env
fi;
while true; do
    clear
    echo "==============================="
    echo "= Lamp & Mean stack on Docker ="
    echo "==============================="
    echo "Press [q] to quit this menu"
    echo ""
    echo "1. Start LAMP containers"
    echo "2. Workspace root bash"
    echo "3. Hot reload nginx conf"
    echo "4. Php-fpm root bash"
    echo "5. Start MEAN containers"
    echo "6. Node root user"
    echo "7. Hot reload nginx-node conf"
    echo "8. Stop node and mongo containers"
    echo "9. Docker container list (ps)"
    echo "10. Stop all containers"
    echo "11. Start Mysql container"
    echo "12. Start PhpMyAdmin container"
    echo "13. Start Mailhog container"
    echo "14. Start Mongo container"
    echo "15. Start Redis, Memcached, Beanstalkd and Elasticsearch containers"
    echo "16. Build all containers"
    echo ""
    echo -n "Select a number or type a command: "
    read input

    case "$input" in
         1)
             docker-compose up -d apache2 mysql workspace php-fpm mailhog nginx
             ;;
         2)
             docker-compose exec workspace bash
             ;;
         3)
             docker-compose exec nginx bash -c "service nginx reload"
             ;;
         4)
             docker-compose exec php-fpm bash
             ;;
         5)
             docker-compose up -d redis node mongo mailhog nginx-node
             ;;
         6)
             docker-compose exec node bash
             ;;
         7)
             docker-compose exec nginx-node bash -c "service nginx reload"
             ;;
         8)
             docker-compose stop node mongo redis
             docker-compose rm -f
             ;;
         9)
             docker-compose ps
             ;;
         10)
             docker stop $(docker ps -a -q)
             docker-compose rm -f
             ;;
         11)
             docker-compose up -d mysql
             ;;
         12)
             docker-compose up -d phpmyadmin
             ;;
         13)
             docker-compose up -d mailhog
             ;;
         14)
             docker-compose up -d mongo
             ;;
         15)
             docker-compose up -d redis memcached beanstalkd elasticsearch
             ;;
         16)
             docker-compose stop
             docker-compose rm -f
             docker-compose build apache2 mysql workspace php-fpm mailhog node mongo redis memcached beanstalkd elasticsearch phpmyadmin nginx nginx-node
             ;;
         q)
             exit
             ;;
         *)
			 eval "$input"
 			 echo ""
             ;;
     esac
     read -p "Continue to menu..."
 done
