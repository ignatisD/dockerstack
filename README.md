# LAMP and MEAN Docker

>Use Docker first and learn about it later.

## Installation Instructions

### 1. Download and install [Docker](https://www.docker.com).

- For windows: [https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)
- For Mac: [https://download.docker.com/mac/stable/Docker.dmg](https://download.docker.com/mac/stable/Docker.dmg)
- For Ubuntu 16.04: 
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo systemctl status docker

curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

You just follow the on screen commands.

### 2. Clone the repository

```bash
git clone https://github.com/ignatisD/dockerstack.git
```

### 3. Setup your environment
Copy the `.env` file and point it to your project 
by editing the `APPLICATIONS` variable.
 
```bash
cd dockerstack
cp .env.example .env
```

### 4. Open the Menu

```bash
chmod +x dockerstack.sh
./dockerstack.sh
``` 
![Lamp menu preview](icons/dockerstackmenu.png?raw=true "LAMP & MEAN stack menu preview")

- Then choose number `0` to build the containers (this will initially take a lot of time)
- LAMP stack containers are: 
    - `apache2`
    - `mysql` 
    - `workspace` (php 7.0 / 7.3)
    - `php-fpm`  (php 5.6 / 7.0 / 7.2 / 7.3)
    - `mailhog`
- MEAN stack containers are:
    - `node`
    - `mongo`
    - `mailhog`
- Extra containers included:
    - `phpmyadmin`
    - `mariadb`
    - `rethinkdb`
    - `php-worker`
    - `elasticsearch`
    - `beanstalkd`
    - `redis`
    - `memcached`

### 5. Finally

That's it! You can start using the Docker containers in any combination.  

*If you are in windows run the `CREATE_SHORTCUTS.bat` batch file included in the ***dockerstack*** directory.  
It creates a shortcut for the menu file with all the available commands.  
Although, it assumes you have Git for Windows installed in `Program Files/Git/` directory.

Good luck   
***Ignatios***
