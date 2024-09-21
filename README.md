# Setup

## Podman

If you want Podman to search all registries by default, you can set the registries.conf file to search all registries. To do this, edit the `/etc/containers/registries.conf` file and add the following line:
```conf
[registries.search]
registries = ['*']
```

## Pulsar

First, you need to pull the Apache Pulsar image from Docker Hub. Podman can use Docker Hub images directly.
```sh
podman pull apachepulsar/pulsar-all:3.3.1
```
Run Apache Pulsar in standalone mode to enable message processing and streaming capabilities. This setup allows for easy testing and development of Pulsar-based applications.
```sh
podman run -d --name pulsar-all \
  --replace \
  -p 6680:8080 -p 6650:6650 \
  -v $PWD/config/pulsar/broker.conf:/conf/broker.conf \
  apachepulsar/pulsar:3.3.1 \
  bin/pulsar standalone;
```
To verify that the container is running correctly, check check the container logs:
> This will show you the output of the container, including any errors or warnings.
```sh
podman logs -f pulsar-all
```
You can also check the container status:
```sh
podman ps -a
```
If you want to stop the container, you can use:
```sh
podman stop pulsar-all
```
And if you want to delete the container, you can use:
> Note that deleting the container will also delete any data stored in the container's filesystem.
```sh
podman rm pulsar-all
```
