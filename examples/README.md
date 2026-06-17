# Examples

This directory is a top-level index of all recipe examples.

## container-service/v1 examples

| Example | Description | Path |
|---------|-------------|------|
| minimal | Required fields only | [recipes/container-service/v1/examples/minimal/](../recipes/container-service/v1/examples/minimal/runtime.yaml) |
| http-service | HTTP service with health check | [recipes/container-service/v1/examples/http-service/](../recipes/container-service/v1/examples/http-service/runtime.yaml) |
| metrics-output | Service that produces metrics | [recipes/container-service/v1/examples/metrics-output/](../recipes/container-service/v1/examples/metrics-output/runtime.yaml) |
| decisions-output | Service that produces decisions | [recipes/container-service/v1/examples/decisions-output/](../recipes/container-service/v1/examples/decisions-output/runtime.yaml) |
| full | Full recipe with all fields | [recipes/container-service/v1/examples/full/](../recipes/container-service/v1/examples/full/runtime.yaml) |

## Using examples

Copy the example closest to your use case and replace placeholder values:

- `registry.example.com/my-service@sha256:replace-with-digest` → your actual image digest
- `example/my-service` → your repository path
- `replace-with-commit-sha` → your actual commit SHA

All examples are validated as part of CI. See [scripts/validate-recipes.sh](../scripts/validate-recipes.sh).
