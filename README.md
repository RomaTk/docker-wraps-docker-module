# docker-wraps-docker-module
Implements module docker for docker wraps environment.

## Usage
Add `docker-wraps-docker-module` to as submodule to your project:
```bash
git submodule add https://github.com/RomaTk/docker-wraps-docker-module.git modules/<name-you-like>
```

## Wraps:
After that you will have the following wraps available:
- `docker-get-latest-version`
- `docker-download-without-configs`
- `docker-download-with-configs`
- `docker-install`
- `docker-dood`
    - This wrap will allow to run docker outside of docker (dood) setup. It will use host docker deamon and will not require to have docker deamon running inside the container.
- `docker-dind`
    - This wrap will allow to run docker in docker (dind) setup. It will not run docker deamon when container starts, but only when docker becomes used and only during the time it is used. This will allow to avoid having docker deamon running all the time when it is not needed.
    - If a lot of docker commands are used in a row, recommended to start the deamon manually with `dockerd` command.
    - To use this wrap you need to have `sysbox` installed and added as wrap named `use-sysbox`. Recommended to use https://github.com/RomaTk/docker-wraps-sysbox-module.git 

You can specify which version of docker you want to use by modifying `build.run.before` in `docker-install` wrap. Within:
```bash
source ./env-scripts/docker/install/prepare-before-build.sh && main "<VERSION>" "linux" "./dockers/docker"
```
if no version is specified, latest version will be used.

## Requirements

To use you need to have modules:
- https://github.com/RomaTk/docker-wraps-backups-module.git
    - This module will allow to avoid rebuilding images if they are already built.
- https://github.com/RomaTk/docker-wraps-ubuntu-module.git
    - This module will allow to have ubuntu image as base for docker images.
- https://github.com/RomaTk/docker-wraps-install-some-util-module.git
    - This module will provide env-scripts for common way to install some utils in the docker wraps environment.

