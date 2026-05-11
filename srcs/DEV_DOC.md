[tag_icon_md]: https://skillicons.dev/icons?i=md

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=rect&height=300&color=gradient&text=🐋𝕀𝕟𝕔𝕖𝕡𝕥𝕚𝕠𝕟%20&section=header&animation=scaleIn&fontSize=110&desc=Docker&descAlign=75&descAlignY=70&descSize=40&fontAlign=45"/>
</p>

<h1>𝔻evelopper Documentation</h1>

<p>
Before starting, make sur to have installed this:

-   Docker
-   Docker compose
-   make
</p>

h2>ℂonfiguration before launch</h2>

<h3>𝔼nvironment Variables and secrets</h3>

<p>

Before launching the containers, you need to configure the database information in the `.env` file located in `srcs/.env`.

Then, you need to configure your personal information in the files located in `srcs/.secrets/*`.  
(Default values are provided in the Makefile.)
</p>

### 𝕃ist of secret you have to configure

```
db_password : Database password

db_root_password : database root password

wp_admin_password : WordPress admin password

wp_user_password : Default WordPress user password
```

### ℂommand to start the project

```
make:   set up the environment and start all services

make up: start all services

make down: stop all services

make clean: stop and remove all services, including percistent data. 
```

### Use docker

```
docker ps # List running containers

docker logs <container_name> # Show container logs

docker images # List images

docker exec -it <container> sh # Access a running container
```

these command are useful to debug Docker.

## Data Persistence

Data is stored using bind mounts.

- MariaDB stores its database data in a directory on the host
- WordPress shares files with Nginx through a bind-mounted directory

All data is located on the host in:
`/home/tjooris/data/*`
Since bind mounts are directly linked to the host filesystem, the data persists even if containers are removed.