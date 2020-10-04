#!/usr/bin/env bash
if [[ ! -f ".env" ]]; then
    cp .env.example .env
fi
export $(egrep -v '^#' .env | xargs)
if [[ ! -f "ssl/server.crt.pem" ]] || [[ ! -f "ssl/server.key.pem" ]]; then
    cp ssl/default/server.bundle.pem ssl/server.bundle.pem
    cp ssl/default/server.crt.pem ssl/server.crt.pem
    cp ssl/default/server.key.pem ssl/server.key.pem
fi
function check() {
    result=$(echo "$1" | grep "$2" | sed -n -r 's/dockerstack_[a-zA-Z0-9\-]*_[0-9].*(Up).*/\1/p')
    if [[ "$result" != "Up" ]]; then
        echo "Start"
    else
        echo "Stop"
    fi
}
function dockerps() {
    export status=$(docker-compose ps)
    export LAMP=$(check "$status" apache2)
    export MEAN=$(check "$status" nginx-node)
    export MAIL=$(check "$status" mailhog)
    export MYSQL=$(check "$status" mysql)
    export PHPMY=$(check "$status" phpmyadmin)
    export MONGO=$(check "$status" mongo)
    export REDIS=$(check "$status" redis)
    export MEMCA=$(check "$status" memcached)
    export BEANSTA=$(check "$status" beanstalkd)
    export ELAS=$(check "$status" elasticsearch)
}
dockerps
while true; do
    clear
    echo "==============================="
    echo "= Lamp & Mean stack on Docker ="
    echo "==============================="
    echo "Press [q] to quit this menu"
    echo ""
    echo "1. $LAMP LAMP containers"
    echo "2. Workspace root bash"
    echo "3. Hot reload nginx conf"
    echo "4. Php-fpm root bash"
    echo "5. $MEAN MEAN containers"
    echo "6. Node root user"
    echo "7. Hot reload nginx-node conf"
    echo "8. Npm start"
    echo "9. Docker container list (ps)"
    echo "10. Stop all containers"
    echo "11. $MYSQL Mysql container"
    echo "12. $PHPMY PhpMyAdmin container"
    echo "13. $MAIL Mailhog container"
    echo "14. $MONGO Mongo container"
    echo "15. $REDIS Redis containers"
    echo "16. $MEMCA Memcached container"
    echo "17. $ELAS Elasticsearch container"
    echo "18. $BEANSTA Beanstalkd and Beanstalkd console containers"
    echo "19. composer install"
    echo "20. composer dump-autoload"
    echo "21. Build LAMP containers"
    echo "22. Build MEAN containers"
    echo "==============================="
    echo "23. Deploy LAMP Stack"
    echo "24. Remove LAMP Stack"
    echo "25. Reload LAMP Stack"
    echo "==============================="
    echo "0. Edit .env file"
    echo ""
    echo -n "Select a number or type a command: "
    read input

    case "$input" in
    1)
        if [[ "$LAMP" != "Stop" ]]; then
            docker-compose up -d mysql workspace php-fpm apache2 mailhog nginx
            LAMP="Stop"
            MAIL="Stop"
            MYSQL="Stop"
        else
            docker-compose stop nginx apache2 workspace php-fpm mailhog mysql
            docker-compose rm -f
            LAMP="Start"
            MAIL="Start"
            MYSQL="Start"
        fi
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
        if [[ "$MEAN" != "Stop" ]]; then
            docker-compose up -d node mongo mailhog nginx-node
            MEAN="Stop"
            MAIL="Stop"
            MONGO="Stop"
        else
            docker-compose stop nginx-node node mailhog mongo
            docker-compose rm -f
            MEAN="Start"
            MAIL="Start"
            MONGO="Start"
        fi
        ;;
    6)
        docker-compose exec node bash
        ;;
    7)
        docker-compose exec nginx bash -c "service nginx reload"
        ;;
    8)
        x-terminal-emulator -e "docker-compose exec --user node node bash -c \"npm start\"" &
        disown
        ;;
    9)
        dockerps
        echo "$status"
        ;;
    10)
        docker stop $(docker ps -a -q)
        docker-compose rm -f
        dockerps
        ;;
    11)
        if [[ "$MYSQL" != "Stop" ]]; then
            docker-compose up -d mysql
            MYSQL="Stop"
        else
            docker-compose stop mysql
            docker-compose rm -f
            MYSQL="Start"
        fi
        ;;
    12)
        if [[ "$PHPMY" != "Stop" ]]; then
            docker-compose up -d phpmyadmin
            PHPMY="Stop"
        else
            docker-compose stop phpmyadmin
            docker-compose rm -f
            PHPMY="Start"
        fi
        ;;
    13)
        if [[ "$MAIL" != "Stop" ]]; then
            docker-compose up -d mailhog
            MAIL="Stop"
        else
            docker-compose stop mailhog
            docker-compose rm -f
            MAIL="Start"
        fi
        ;;
    14)
        if [[ "$MONGO" != "Stop" ]]; then
            docker-compose up -d mongo
            MONGO="Stop"
        else
            docker-compose stop mongo
            docker-compose rm -f
            MONGO="Start"
        fi
        ;;
    15)
        if [[ "$REDIS" != "Stop" ]]; then
            docker-compose up -d redis
            REDIS="Stop"
        else
            docker-compose stop redis
            docker-compose rm -f
            REDIS="Start"
        fi
        ;;
    16)
        if [[ "$MEMCA" != "Stop" ]]; then
            docker-compose up -d memcached
            MEMCA="Stop"
        else
            docker-compose stop memcached
            docker-compose rm -f
            MEMCA="Start"
        fi
        ;;
    17)
        if [[ "$ELAS" != "Stop" ]]; then
            docker-compose up -d elasticsearch
            ELAS="Stop"
        else
            docker-compose stop elasticsearch
            docker-compose rm -f
            ELAS="Start"
        fi
        ;;
    18)
        if [[ "$BEANSTA" != "Stop" ]]; then
            docker-compose up -d beanstalkd beanstalkd-console
            BEANSTA="Stop"
        else
            docker-compose stop beanstalkd beanstalkd-console
            docker-compose rm -f
            BEANSTA="Start"
        fi
        ;;
    19)
        if [[ "$LAMP" != "Start" ]]; then
            docker-compose exec -u 1000 workspace bash -c 'composer install'
        fi
        ;;
    20)
        if [[ "$LAMP" != "Start" ]]; then
            docker-compose exec -u 1000 workspace bash -c 'composer dump-autoload'
        fi
        ;;
    21)
        docker-compose stop
        docker-compose rm -f
        docker-compose build mysql workspace php-fpm apache2 mailhog nginx
        dockerps
        ;;
    22)
        docker-compose stop
        docker-compose rm -f
        docker-compose build node mongo mailhog nginx-node
        dockerps
        ;;
    23)
        docker stack deploy -c lamp-compose.yml dev
        docker stack deploy -c lampsql-compose.yml dev
        ;;
    24)
        docker service rm dev_workspace dev_php-fpm dev_nginx dev_apache2 dev_mysql dev_mailhog dev_phpmyadmin
        ;;
    25)
        docker service rm dev_workspace dev_php-fpm dev_nginx dev_apache2
        export $(egrep -v '^#' .env | xargs)
        sleep 3
        docker stack deploy -c lamp-compose.yml dev
        ;;
    0)
        if command -v gedit >/dev/null; then
            gedit .env &
        elif command -v nano >/dev/null; then
            nano .env
        else
            start notepad++ .env
        fi
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
