# Volume Path Replacer

This Docker image is designed to wrap the standard Docker CLI and modify volume mount paths based on specified replacement rules. It is particularly useful within the Dood (Docker Out Of Docker) environment to ensure that volume paths are correctly mapped between the host and the container.

## Volume
The image mounts the following volume:
- `/working-env/docker/volume-path-replacer/config.cfg`: Configuration file that defines the path replacement rules.
## Configuration
The configuration file should be in the following format:
```cfg
TO_REPLACE="<path_to_replace>"
REPLACE_WITH="<path_to_replace_with>"
```
## There help scripts to create and manage the configuration file:
- `create-config.sh`: Script to create the configuration file with specified paths.
- `get-replace-with.sh`: Script to retrieve the `REPLACE_WITH` value from the configuration file.
