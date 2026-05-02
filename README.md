# docker-wraps-docker-module
Implements module docker for docker wraps environment.

## Usage
Add `docker-wraps-docker-module` to as submodule to your project:
```bash
git submodule add https://github.com/RomaTk/docker-wraps-docker-module.git modules/<name-you-like>
```

## Wraps:
After that you will have the following wraps available:
- [File - buildx.json](./env-jsons/docker/buildx.json)
    - `docker-buildx-get-latest-version`
    - `docker-buildx-download-without-configs`
    - `docker-buildx-download-with-configs`
    - `docker-buildx-install`
    - `docker-buildx-with-docker-installed`
- [File - dind.json](./env-jsons/docker/dind.json)
    - `docker-dind`
- [File - docker-install.json](./env-jsons/docker/docker-install.json)
    - `docker-get-latest-version`
    - `docker-download-without-configs`
    - `docker-download-with-configs`
    - `docker-install`
- [File - dood.json](./env-jsons/docker/dood.json)
    - `docker-dood-base`
    - `docker-dood-with-docker-installed`
- [File - volume-path-replacer.json](./env-jsons/docker/volume-path-replacer.json)
    - `docker-volume-path-replacer` -> [Volume Path Replacer](./dockers/docker/volume-path-replacer/README.md) (recommended touse with `docker-dood` wrap)
- [FILE - test.json](./env-jsons/docker/test.json) - used for testing porposes
    - `docker-buildx-with-docker-installed-test`
    - `docker-dind-test`
    - `docker-dood-with-docker-installed-test`

# Download and install

Please check the 

## Requirements

To use you need to have modules:
- https://github.com/RomaTk/docker-wraps-backups-module.git
    - This module will allow to avoid rebuilding images if they are already built.
- https://github.com/RomaTk/docker-wraps-ubuntu-module.git
    - This module will allow to have ubuntu image as base for docker images. And also it will allow to have some utils preinstalled in the base image for docker images.
- https://github.com/RomaTk/docker-wraps-install-some-util-module.git
    - This module will provide env-scripts for common way to install some utils in the docker wraps environment.
- https://github.com/RomaTk/docker-wraps-sysbox-module.git
    - This module will allow to use sysbox as a runtime for docker containers. Nessary for dind wraps to run docker within them.