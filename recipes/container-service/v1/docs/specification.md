# container-service/v1 Specification

## Overview

`ContainerServiceRecipe` v1 defines the execution contract for an immutable containerized service running inside a Brotni-compatible simulation campaign.

## apiVersion

```yaml
apiVersion: recipe.brotni.com/v1
```

## kind

```yaml
kind: ContainerServiceRecipe
```

## Required fields

| Field | Type | Description |
|-------|------|-------------|
| `apiVersion` | string | Must be `recipe.brotni.com/v1` |
| `kind` | string | Must be `ContainerServiceRecipe` |
| `metadata.name` | string | Unique name for this recipe instance |
| `candidate.image` | string | Container image reference |

## candidate.image

The `candidate.image` field strongly recommends immutable digest references:

```yaml
candidate:
  image: registry.example.com/my-service@sha256:replace-with-digest
```

Mutable tags (e.g., `latest`, `main`) are explicitly discouraged. A mutable tag cannot guarantee that two simulation runs use the same image, which breaks reproducibility.

## runtime

The `runtime` section controls how the container is launched:

- `command`: entrypoint override
- `args`: arguments
- `env`: environment variables as string key-value pairs
- `ports`: exposed ports for health check and traffic

## healthcheck

The simulation environment uses the health check to determine when the service is ready to receive inputs.

Only one of `http` or `exec` should be provided.

## inputs

Input mounts are files provided to the container by the simulation environment. Required mounts must exist before the container starts.

## outputs

The simulation environment collects declared output files after the run completes. Missing output files result in a collection warning (not necessarily a failure, depending on the simulation spec).

## resources

Resource hints are advisory. Simulation environments may ignore them or use them for scheduling decisions.

## timeouts

All timeouts are in seconds:

- `startupSeconds`: time allowed for the container to become healthy
- `runSeconds`: maximum duration of the simulation run
- `shutdownSeconds`: time allowed for graceful termination after `SIGTERM`

## reproducibility

Setting `requireImmutableImage: true` instructs the simulation environment to reject recipe executions where `candidate.image` does not contain a digest reference.
