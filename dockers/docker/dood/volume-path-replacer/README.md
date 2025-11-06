# Volume Path Replacer

This Docker image is designed to wrap the standard Docker CLI and modify volume mount paths based on specified replacement rules. It is particularly useful within the Dood (Docker Out Of Docker) environment to ensure that volume paths are correctly mapped between the host and the container.

## There are two build arguments:
- `REPLACE_WITH`: The path that will replace the specified path in volume mounts.
- `TO_REPLACE`: The path that will be replaced in volume mounts.

## Usage
To build the Docker image, use the following options, replacing the placeholders with your desired paths:

```bash
--build-arg REPLACE_WITH="/new/path"
```
```bash
--build-arg TO_REPLACE="/old/path"
```