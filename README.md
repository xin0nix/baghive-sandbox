# Setup

```sh
sudo apt-get install -y podman podman-compose postgresql-client
```

## Podman

If you want Podman to search all registries by default, you can set the registries.conf file to search all registries. To do this, edit the `/etc/containers/registries.conf` file and add the following line:
```conf
[registries.search]
registries = ['docker.io']
```
By default, podman-compose looks for a file named podman-compose.yaml or podman-compose.yml in the current working directory. If it finds one of these files, it will use it as the configuration file.
```sh
podman-compose up
```
> The -d flag tells Podman Compose to run the container in detached mode, meaning it will run in the background.
If you want to suppress podman-compose output, use it.

To verify that the container is running, you can use the following command:
```sh
podman ps
```
This will list all running containers, including the one created by Podman Compose.

To stop the container, you can use the following command:
```sh
podman-compose down
```

To verify that the container is running correctly, check the container logs.
> This will show you the output of the container, including any errors or warnings.
Pulsar broker:
```sh
podman logs -f pulsar-all
```
Postgres database:
```sh
podman logs -f postgres
```
Here's how you can connect to the PostgreSQL database using the psql command-line client:
```sh
podman exec -it postgres psql -U myuser baghive_db
```