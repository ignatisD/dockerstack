#!/usr/bin/env bash
while true; do
    clear
    echo "==============================="
    echo "==  Lamp stack using Docker  =="
    echo "==============================="
    echo "Press [q] to quit this menu"
    echo ""
    echo "1. Workspace root"
    echo "2. Workspace non-root"
    echo "3. Restart applications"
    echo "4. Start node and mongo containers"
    echo "5. Stop node and mongo containers"
    echo "6. Node non-root user"
    echo "7. Start Basic containers"
    echo "8. Stop all containers"
    echo "9. Docker container list (ps)"
    echo "10. Start Basic containers"
    echo "11. Stop all containers"
    echo "12. Start Redis and Memcached containers"
    echo "13. Stop Redis and Memcached containers"
    echo "14. Start elasticsearch extra container"
    echo "15. Stop elasticsearch extra container"
    echo "16. Rebuild all containers"
    echo ""
    echo -n "Select a number or type a command: "
    read input

    case "$input" in
        1)
            docker-compose exec workspace bash
            ;;
        2)
            docker-compose exec --user laradock workspace bash
            ;;
        3)
            docker-compose up applications
            ;;
        4)
            docker-compose up -d node mongo
            ;;
        5)
            docker-compose stop node mongo
            docker-compose rm -f node mongo
            ;;
        6)
            docker-compose exec --user node node bash
            ;;
        7)
            docker-compose up -d apache2_nolara mysql phpmyadmin workspace php-fpm mailhog
            read -p "Continue to menu..."
            ;;
        8)
            docker-compose stop
            docker-compose rm -f
            read -p "Continue to menu..."
            ;;
        9)
            docker-compose ps
            read -p "Continue to menu..."
            ;;
        10)
            docker-compose up -d mysql elasticsearch
            ;;
        11)
            docker-compose stop mysql elasticsearch
            docker-compose rm -f mysql elasticsearch
            ;;
        12)
            docker-compose up -d redis memcached
            ;;
        13)
            docker-compose stop redis memcached
            docker-compose rm -f redis memcached
            ;;
        14)
            docker-compose up -d php-worker
            ;;
        15)
            docker-compose stop php-worker
            docker-compose rm -f php-worker
            ;;
        16)
            docker-compose stop
            docker-compose rm -f
            docker-compose build apache2 mysql redis memcached beanstalkd elasticsearch workspace php-fpm mailhog phpmyadmin node mongo
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
