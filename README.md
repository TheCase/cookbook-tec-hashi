when deploying a new vault, you'll want to manually init and unseal the vault:

```
vault init -address=http://<ip>:8200
vault unseal -address=http://<ip>:8200
```

on a new cluster creation, you'll want to enable Docker Swarm mode so that Portainer will show all the containers in the cluster in a single view:

https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/
