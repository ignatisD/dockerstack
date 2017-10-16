# LAMP and MEAN Docker

>Use Docker first and learn about it later.

## Installation Instructions

### 1. Download and install [Docker](https://www.docker.com).

- For windows: [https://download.docker.com/win/stable/InstallDocker.msi](https://download.docker.com/win/stable/InstallDocker.msi)
- For Mac: [https://download.docker.com/mac/stable/Docker.dmg](https://download.docker.com/mac/stable/Docker.dmg)
- For Ubuntu 16.04: 
```bash
sudo apt-get update
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
sudo apt-get update
apt-cache policy docker-engine
sudo apt-get install -y docker-engine
sudo systemctl status docker

curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

You just follow the on screen commands.

### 2. Clone the repository

```bash
git clone https://bitbucket.org/Ignatis/lamp_stack.git
```

### 3. Setup your environment
Copy the `.env` file and point it to your project 
by editing the `APPLICATIONS` variable.
 
```bash
cd lamp_stack
cp env_example .env
```

### 4. Open the Menu

```bash
chmod +x lampmenu.sh
./lampmenu.sh
``` 

- Then choose number 16 to build the containers (this will initially take a lot of time)

### 5. Finally

That's it! You can start using the Docker containers in any combination.  

*If you are in windows run the `CREATE_SHORTCUTS.bat` batch file included in the ***lamp_stack*** directory.  
It creates a shortcut for the menu file with all the available commands.  

Good luck   
***Ignatios***