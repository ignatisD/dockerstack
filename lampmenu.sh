#!/usr/bin/env bash
while true; do
    clear
    echo "==============================="
    echo "= Lamp & Mean stack on Docker ="
    echo "==============================="
    echo "Press [q] to quit this menu"
    echo ""
    echo "1. Start LAMP containers"
    echo "2. Workspace root bash"
    echo "3. Workspace non-root bash"
    echo "4. Php-fpm root bash"
    echo "5. Start MEAN containers"
    echo "6. Node root user"
    echo "7. Node non-root user"
    echo "8. Stop node and mongo containers"
    echo "9. Docker container list (ps)"
    echo "10. Stop all containers"
    echo "11. Start Mysql container"
    echo "12. Start PhpMyAdmin container"
    echo "13. Start Mailhog container"
    echo "14. Start php-worker container"
    echo "15. Start Redis, Memcached, Beanstalkd and Elasticsearch containers"
    echo "16. Rebuild all containers"
    echo ""
    echo -n "Select a number or type a command: "
    read input

    case "$input" in
         1)
             docker-compose up -d apache2 mysql workspace php-fpm mailhog
             read -p "Continue to menu..."
             ;;
         2)
             docker-compose exec workspace bash
             ;;
         3)
             docker-compose exec --user laradock workspace bash
             ;;
         4)
             docker-compose exec php-fpm bash
             ;;
         5)
             docker-compose up -d node mongo mailhog
             read -p "Continue to menu..."
             ;;
         6)
             docker-compose exec node bash
             ;;
         7)
             docker-compose exec --user node node bash
             ;;
         8)
             docker-compose stop node mongo
             docker-compose rm -f
             read -p "Continue to menu..."
             ;;
         9)
             docker-compose ps
             read -p "Continue to menu..."
             ;;
         10)
             docker-compose stop
             docker-compose rm -f
             read -p "Continue to menu..."
             ;;
         11)
             docker-compose up -d mysql
             read -p "Continue to menu..."
             ;;
         12)
             docker-compose up -d phpmyadmin
             ;;
         13)
             docker-compose up -d mailhog
             ;;
         14)
             docker-compose up -d php-worker
             ;;
         15)
             docker-compose up -d redis memcached beanstalkd elasticsearch
             ;;
         16)
             docker-compose stop
             docker-compose rm -f
             docker-compose build apache2 mysql workspace php-fpm mailhog node mongo redis memcached beanstalkd elasticsearch phpmyadmin
             read -p "Continue to menu..."
             ;;
         q)
             exit
             ;;
         *)
 			 $input
 			 echo ""
             read -p "Continue to menu..."
             ;;
     esac
 done
