# Run AS3 Ninja Labs locally

## Prerequisites

To run the labs locally you will need:

- a Terminal with bash (zsh and fish might work as well)
- Docker installed
- git installed

## Setup your environment

First setup your environment:

```bash
# start an ephemeral container in the background
docker run -d --rm --name as3ninja_preload simonkowallik/as3ninja

# create new image from container
docker commit as3ninja_preload as3ninja

# stop the ephemeral container (it is deleted automatically)
docker container stop as3ninja_preload

# list new image with pre-loaded AS3 schemas
docker image ls as3ninja

# use the newly created image to run containers, example:
docker run --rm -it -p 8000:8000 as3ninja
```

Create vault docker instance:

```bash
# run vault in DEV mode
docker run -d --rm -name vault \
  -e SKIP_SETCAP=true \
  -e VAULT_DEV_ROOT_TOKEN_ID=myrootToken \
  -p 8200:8200 \
  vault

vaddr=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' vault)
export VAULT_TOKEN=myrootToken
export VAULT_ADDR=http://${vaddr}:8200
```

Then clone the Lab repository to your computer:

```bash
# Clone the GitHub Repo
git clone https://github.com/simonkowallik/as3ninjaLabs

# change to the cloned repo
cd as3ninjaLabs
```

Now configure vault:

```bash
# create secret files for vault
cicd/vault_create_secrets.sh

# hvac is required for the setup
pip3 install hvac

# setup secrets engines and secrets in vault
python3 cicd/vault_setup.py
```

## Ready?

[Start with your first Lab!](../Lab1)
