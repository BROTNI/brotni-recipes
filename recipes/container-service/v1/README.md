# container-service/v1

> A container-service recipe describes how an immutable container candidate should be executed, observed, and evaluated inside a simulation campaign.

---

## What is a container-service candidate?

A container-service candidate is an immutable, containerized workload that:

- Runs as a long-lived service (not a one-shot batch job)
- Accepts inputs via mounted files or environment variables
- Produces structured outputs (metrics, decisions, traces, logs) at known paths
- Exposes a health check endpoint
- Can be started and stopped deterministically

---

## When to use this recipe

Use `container-service/v1` when your candidate:

- Is packaged as a container image
- Runs as a service that processes input and produces output
- Must be validated end-to-end inside a simulation campaign
- Should be referenced by immutable digest (`image@sha256:...`)

---

## When NOT to use this recipe

Do not use this recipe when your candidate:

- Runs to completion and exits (use `batch-job` when available)
- Is a configuration artifact with no runtime (use `config-bundle` when available)
- Is a Helm chart or Kubernetes resource set (use `helm-release` when available)

---

## Expected runtime behavior

The simulation environment will:

1. Pull the container image by digest.
2. Mount input files at the declared paths.
3. Start the container with the declared command, args, and environment variables.
4. Wait for the health check to pass.
5. Allow the workload to process inputs.
6. Collect declared outputs from the declared paths.
7. Stop the container gracefully within the declared shutdown timeout.
8. Record all outputs for evaluation.

---

## Input contract

Inputs are mounted as files at declared paths inside the container.

```yaml
inputs:
  mounts:
    - name: replay-events
      path: /brotni/input/events.ndjson
      required: true
```

The simulation environment guarantees that required inputs exist before the container starts.

---

## Output contract

Outputs are collected from declared paths after the simulation run.

```yaml
outputs:
  metrics:
    path: /brotni/output/metrics.json
    format: json
  decisions:
    path: /brotni/output/decisions.ndjson
    format: ndjson
  logs:
    path: /brotni/output/logs
  traces:
    path: /brotni/output/traces.json
```

The simulation environment reads these paths after the container exits or reaches its shutdown timeout.

---

## Health check behavior

The recipe supports HTTP health checks:

```yaml
healthcheck:
  http:
    path: /health
    port: 8080
  initialDelaySeconds: 5
  timeoutSeconds: 60
```

The simulation environment will not send inputs until the health check passes. If the health check does not pass within `timeoutSeconds`, the run is marked as failed.

---

## Reproducibility expectations

This recipe strongly recommends immutable image references:

```yaml
candidate:
  image: registry.example.com/my-service@sha256:replace-with-digest
```

Mutable tags (e.g., `latest`) are explicitly discouraged. Using a mutable tag undermines reproducibility guarantees because the image content may change between runs.

Set `reproducibility.requireImmutableImage: true` to enforce this at the recipe level.

---

## Security expectations

- Use immutable image digests.
- Do not mount secrets as environment variables unless your simulation runner supports secret injection.
- Input files are read-only by convention. Do not mutate inputs.
- Output paths should not be shared between concurrent simulation runs.

See [docs/security.md](docs/security.md) for more.

---

## Validation

Validate your recipe YAML against the JSON Schema:

```bash
./scripts/validate-recipes.sh
```

The schema is at:

```
recipes/container-service/v1/schema/container-service.recipe.v1.schema.json
```

See [tests/fixtures/valid/](tests/fixtures/valid/) for valid examples and [tests/fixtures/invalid/](tests/fixtures/invalid/) for examples of invalid configurations.

---

## apiVersion and kind

```yaml
apiVersion: recipe.brotni.com/v1
kind: ContainerServiceRecipe
```
