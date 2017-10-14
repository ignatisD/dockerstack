#!/usr/bin/env bash
while true; do
    clear
    echo "==============================="
    echo "==  Lamp stack using Docker  =="
    echo "==============================="
    echo "Press [q] to quit this menu"
    echo ""
    echo "1. Workspace"
    echo "2. Php-fpm"
    echo "3. Apache"
    echo "4. Mysql"
    echo "5. Beanstalkd"
    echo "6. PhpMyAdmin"
    echo "7. Redis"
    echo "8. Memcached"
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
            docker-compose exec php-fpm bash
            ;;
        3)
            docker-compose exec apache2 bash
            ;;
        4)
            docker-compose exec mysql bash
            ;;
        5)
            docker-compose exec beanstalkd bash
            ;;
        6)
            docker-compose exec phpmyadmin bash
            ;;
        7)
            docker-compose exec redis bash
            ;;
        8)
            docker-compose exec memcached bash
            ;;
        9)
            docker-compose ps
            read -p "Continue to menu..."
            ;;
        10)
            docker-compose up -d apache2_nolara workspace php-fpm mailhog
            read -p "Continue to menu..."
            ;;
        11)
            docker-compose stop
            docker-compose rm -f
            read -p "Continue to menu..."
            ;;
        12)
            docker-compose up -d mysql elasticsearch
            ;;
        13)
            docker-compose stop mysql elasticsearch
            docker-compose rm -f mysql elasticsearch
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
            docker-compose build apache2 mysql redis memcached beanstalkd elasticsearch workspace php-fpm mailhog phpmyadmin
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
