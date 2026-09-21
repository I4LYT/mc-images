# mc-images

Container wrappers for Java runtime images that run the inherited application as a
consistent, configurable user and prepare its data directory with the right
permissions.

## Images

The GitHub Action builds these images weekly and publishes them to GHCR:

```text
ghcr.io/i4lyt/mc-images:21
ghcr.io/i4lyt/mc-images:25
ghcr.io/i4lyt/mc-images:26
```

The default base image is `eclipse-temurin:21-jre-jammy`. A compatible base can
also be selected at build time:

```bash
docker build \
	--build-arg BASE_IMAGE=eclipse-temurin:25-jre-jammy \
	-t my-wrapper:25 docker/
```

The base image must be Debian/Ubuntu-compatible and provide `apt-get`,
`groupadd`, `useradd`, and a shell. The wrapper replaces the base image's
`ENTRYPOINT`, but preserves its `CMD`.

## Runtime configuration

```bash
docker run --rm \
	-e MC_UID=10042 \
	-e MC_GID=10042 \
	-e MC_DATA_DIR=/server \
	-v "$PWD/server:/server" \
	ghcr.io/i4lyt/mc-images:21
```

Variables:

| Variable | Default | Purpose |
| --- | --- | --- |
| `MC_UID` | `10042` | Numeric UID used to run the application |
| `MC_GID` | `10042` | Numeric GID used to run the application |
| `MC_DATA_DIR` | `/data` | Directory created and recursively made writable |

The container starts with the base image's command. Pass a command after the
image name to override it, for example:

```bash
docker run --rm ghcr.io/i4lyt/mc-images:21 java -version
```

## Building locally

```bash
docker build -t mc-images:21 \
	--build-arg BASE_IMAGE=eclipse-temurin:21-jre-jammy \
	docker/
```

The workflow at `.github/workflows/build.yml` runs on pushes to `main`, manual
dispatches, and weekly on Sundays. It publishes both Java versions to GHCR.

# AI Usage
This was built with the help of GPT-5.6 Luna using Copilot, I did make some adjustments to it.