Dockerfile - Dynomite
==============================

### Run ###
```
docker run -d --link redis-server-1:redis-server-1 --name dynomite.1 -p 8103:8102 -v $HOME/DynomiteDocker/conf:/etc/docker  sendgrid/dynomite -c /etc/docker/dynomite.1.yml
```
