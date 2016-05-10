A vagrant script to build PHP development environment with Docker

Features
---

- [x] Making a VM automatic by vagrant
- [x] Using CentOS 7.2
- [x] Run services (PHP, NGINX, MariaDB, Redis) with Docker
- [x] Allow customize port and password

Requirement
---

- vagrant
- virtualbox

Install
---

1. Clone this project

   ```
   ~ $ git clone git@github.com:oanhnn/my-centos-docker.git /your-path
   ```

2. Copy your public and private key to `keys` directory

   ```
   ~ $ cp /your-public-key /your-path/keys/id_rsa.pub
   ~ $ cp /your-private-key /your-path/keys/id_rsa
   ```

3. Fix path to source code in `Vagrantfile` file and environment variables in `.env` file

   ```
   ~ $ vi /your-path/Vagrantfile
   ~ $ vi /your-path/.env
   ```

4. Run `vagrant up` and waiting

   ```
   ~ $ cd /your-path && vagrant up
   ```

Usage
---
// TODO:
