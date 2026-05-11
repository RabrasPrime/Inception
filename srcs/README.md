*This project has been created by Tjooris.*

<!-- [Tag-test]: url "on hover" -->
[tag_icon_md]: https://skillicons.dev/icons?i=md

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=rect&height=300&color=gradient&text=🐋𝕀𝕟𝕔𝕖𝕡𝕥𝕚𝕠𝕟%20&section=header&animation=scaleIn&fontSize=110&desc=Docker&descAlign=75&descAlignY=70&descSize=40&fontAlign=45"/>
</p>

<details>
	<summary>
		<h1>𝕊ummary</h1>
	</summary>
<blockquote>

- [ℝesume](#resume)
- [𝕎hat is docker ?](#head)
	- [𝔻ocker](#docker)
	- [ℂontainer](#container)
	- [𝕀mage](#image)
	- [𝕍olume](#volume)
	- [𝕌tility](#utility)
- [ℙresentation](#presentation)
	- [ℍow to create a container](#tutorial)
	- [𝔸ll containers](#containers)
- [𝕀nstruction](#Instruction)
- [ℝesources](#Resources)



</details>

<details id= "resume">
	<summary>
		<h2>ℝesume</h2>
	</summary>
<blockquote>

<p>
This project has for purpose to use docker to have a "website" on wordpress, using multiple service (wordpress, nginx and mariadb)
</p>

</details>

<details id="head">
	<summary>
		<h2>𝕎hat is docker ?</h2>
	</summary>

<blockquote>
<details id="docker">
	<summary>
		<h3>𝔻ocker</h3>
	</summary>
<p>

	Docker is an engine who create containers of isolated service environement.
</p>
</details>

<details id="container">
	<summary>
		<h3>ℂontainer</h3>
	</summary>

<p>

	A container is a lightweight, standalone, and executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries, and settings.
</p>

</details>

<details id="image">
	<summary>
		<h3>𝕀mage</h3>
	</summary>

<p>

An image is a read-only file that contains the source code, libraries dependencies, tools, and other files needed for an application to run.
</p>
</details>

<details id="volume">
	<summary>
		<h3>𝕍olume</h3>
	</summary>

<p>

By default, containers are ephemeral. This means that if a container is deleted or rebuilt, all data created inside its filesystem is lost forever. To prevent this, we use Docker Volumes.

A volume is a specially designated directory on the host machine that is mounted into the container.
</p>
</details>

<details id="utility">
	<summary>
		<h3>𝕌tility</h3>
	</summary>
<h4>Docker vs Virtual machine</h4>
<p>

Unlike a VM, which embeds a full Guest OS and its own kernel, Docker leverages the host kernel through isolation, resulting in much lower overhead.
</p>

<h4>Secrets vs Environment Variables</h4>

<p>

Environment variables and Secrets serve a similar purpose, but while environment variables are easily accessible and visible in the process tree, Secrets are stored securely and mounted as files, making them accessible only to the intended container service.
</p>

<h4>Docker Network vs Host Network</h4>

<p>

	In a Bridge network (default), Docker creates a virtual network and isolates the container, requiring port mapping to communicate with the host. In Host network mode, the container shares the host's networking stack directly, removing isolation but improving performance by eliminating network overhead.
</p>

<h4>Docker Volumes vs Bind Mounts</h4>

<p>
While Bind Mounts depend on the specific directory structure of the host machine, Volumes are completely managed by Docker, making them more secure, portable, and easier to back up.
</p>

</details>
</details>

<details id="presentation">
	<summary>
		<h2>ℙresentation</h2>
	</summary>

<p> 
For the mandatory, we have to create three containers, one for nginx, one for mariadb and one for wordpress, and to create these container, we will create an image of each daemons we will use.
</p>

<details id="tutorial">
	<summary>
		<h3>ℍow to create a container</h3>
	</summary>

<p>
To create a container, we use a Dockerfile and an entrypoint script.

<strong>Dockerfile</strong>: This is a configuration file containing all the instructions needed to assemble an Image. In this project, we must use a specific base OS. While the subject suggests the penultimate stable version of Debian, I chose Alpine 3.22 for its light weight and security.

<strong>Note</strong>: It is important to distinguish that Alpine is a Distribution (OS), not a Kernel. All containers share the Host's Kernel.

<strong>Building the Image</strong>: Starting from this base, we install all the necessary dependencies and tools required for our service (for example, installing PHP and its extensions for WordPress).

<strong>Entrypoint</strong>: Once the environment is set up via the Dockerfile, the entrypoint.sh script is executed. Its role is to perform the final runtime configurations (like setting up database users or checking service connectivity) and then launch the main process to keep the container running.
</details>

<details id="containers">
	<summary>
		<h3>𝔸ll containers</h3>
	</summary>
<h4>Mariadb</h4>

<p>
We started with MariaDB because of the service dependencies: Nginx relies on WordPress, and WordPress requires MariaDB to function. We initialized the database for WordPress and configured two users, including one with administrative privileges
</p>

<h4>Wordpress</h4>
<p>
WordPress acts as the application layer. It connects to the MariaDB container to retrieve and store content, while using PHP-FPM to process dynamic scripts. We configured the WordPress container to communicate with MariaDB using the database credentials and the specific network name defined in our Docker setup.
</p>

<h4>Nginx</h4>
<p>
Nginx is the final layer of our infrastructure, acting as a web server and a Reverse Proxy. It is the only container exposed to the host network via port 443 (HTTPS). Its role is to receive client requests, handle SSL/TLS encryption, and forward PHP requests to the WordPress container using the FastCGI protocol.
</p>

<i>=-=-=-=BONUS PART=-=-=-=</i>

<h4>Adminer</h4>
<p>
Adminer is a lightweight database management tool. We added it to our infrastructure to easily manage MariaDB through a web interface. It runs as a separate container and connects to the same internal network as MariaDB, allowing us to execute SQL queries and inspect tables without using the CLI.
</p>

<h4>Redis</h4>
<p>
We integrated Redis as an Object Cache for WordPress. Instead of querying the MariaDB database for every request, WordPress stores frequently accessed data in Redis's memory (RAM). This significantly reduces database load and improves the overall response time of the website.
</p>

<h4>FTP server</h4>
<p>
We deployed an FTP server (vsftpd) to allow remote file management of the WordPress site. The FTP container is configured to mount the same volume as the WordPress container. This provides a secure and easy way to upload or modify themes and plugins directly from a local FTP client like FileZilla.
</p>

<h4>Static website</h4>
<p>
We added a static website as an additional service to showcase a simple, non-dynamic site. It runs on its own lightweight Nginx or Apache server and is isolated from the WordPress infrastructure. This demonstrates how Docker can efficiently serve light content with minimal resource overhead.
</p>

<h4>cAdvisor</h4>
<p>
We integrated cAdvisor to monitor our infrastructure's performance. It is a tool developed by Google that collects, aggregates, and exposes resource usage and performance data from all running containers. By accessing the cAdvisor interface, we can track CPU usage, memory consumption, and network throughput for every service in our stack.
</p>
</details>
</details>

<details id="Instruction">
	<summary>
		<h2>𝕀nstruction</h2>
	</summary>

```
make		# General command used to set up and build all containers
```
```
make setup	# Command used to set up the environment (secret, .env, ...)
```
```
make build	# Command used to build the images
```
```
make up		# Starts the existing containers defined in the Docker Compose file without triggering a new build
```
```
make stop	# Gracefully stops all running containers without removing them.
```
```
make down	# Stops and removes containers and networks defined in the Compose file.
```
```
make clean	# Removes containers, networks, and all unused Docker images. It also clears the persistent data stored on the host machine.
```
```
make re		# Performs a complete clean followed by a fresh all to restart the infrastructure from scratch.
```
</details>

<details id="Resources">
	<summary>
		<h2>ℝesources</h2>
	</summary>


Most of the Information went from [`Docker doc`](https://docs.docker.com/ "Docker doc")

then for nginx, we've used [`Nginx Documentation`](https://nginx.org/en/docs/ "Nginx Documentation")

for mariadb [`Mariadb Doc`](https://mariadb.com/docs/server/server-management/automated-mariadb-deployment-and-administration/docker-and-mariadb/installing-and-using-mariadb-via-docker "Mariadb Doc")

for wordpress [`Docker wordpress`](https://www.docker.com/blog/how-to-dockerize-wordpress/ "Docker wordpress")

for redis [`redis tutorials`](https://redis.io/tutorials/what-is-redis/ "redis tutorials")

for adminer [`docker hub adminer`](https://hub.docker.com/_/adminer/ "docker hub adminer")

for the ftp server [`docker hub adminer`](https://www.howtoforge.com/tutorial/how-to-install-and-configure-vsftpd/ "docker hub adminer")

for cAdvisor [`prometheus`](https://prometheus.io/docs/guides/cadvisor/ "prometheus")
</details>