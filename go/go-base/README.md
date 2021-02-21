# Readme

## install

1. install docker and docker-compose last version from docker web page instructions

## Debug - vscode

1. Install extension: ms-vscode-remote.remote-containers

2. Copy the files in working dir
```bash
cp -r .examples/.devcontainer ./
cp -r .examples/.vscode ./
```

3. Change the environment (dev|prod): 
.devcontainer/devcontainer.json 
  => dockerComposeFile:  "../../../docker-compose.{entorno}.yml"

4. Start the container:
vscode =>  Remote Container: Reopen in Container
