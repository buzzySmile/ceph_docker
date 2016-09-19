# ceph_docker
Ceph demo running on Docker example.

### Prerequisites:
- [Docker](https://www.docker.com/products/docker)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Instructions:
### Running Ceph:
- Clone this repository
- Get your IP (use `ifconfig`, or similar)
- Change docker-compose.yml file, adding your IP. Ex: If my IP is `192.168.0.13`, fill in the environment variables like this:
```
MON_IP: '192.168.0.13'
CEPH_PUBLIC_NETWORK: '192.168.0.0/24'
```
- Run the container:
```
$ docker-compose up
```
- Your Ceph will respond on `http://localhost:80`

### Creating admin user:
- Open the bash inside docker container
```
$ docker exec -it cephdocker_cluster_1 bash
```
- Setup the admin user inside the container. Ex: If you choose a user ID called `guilherme`
```
radosgw-admin user create --uid=guilherme --display-name="Guilherme" --email=guilherme@email.com
radosgw-admin caps add --uid=guilherme --caps="users=*"
radosgw-admin caps add --uid=guilherme --caps="buckets=*"
radosgw-admin caps add --uid=guilherme --caps="metadata=*"
radosgw-admin caps add --uid=guilherme --caps="usage=*"
radosgw-admin caps add --uid=guilherme --caps="zone=*"
```
- That's all, folks!!! =]

### About
Guilherme Cruz

guicruz.zs@gmail.com
