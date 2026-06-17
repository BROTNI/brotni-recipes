# Reproducibility — container-service/v1

## What reproducibility means for recipes

A simulation run is reproducible if:

1. The same image is used (same bits, not just the same tag).
2. The same inputs are provided.
3. The same environment variables are set.
4. The same resource constraints apply.

## Immutable image references

The primary mechanism for ensuring image reproducibility is the SHA256 digest:

```yaml
candidate:
  image: registry.example.com/my-service@sha256:replace-with-digest
```

A digest uniquely identifies a specific image layer set. Once an image is pushed with a given digest, that digest always refers to exactly those bytes — forever.

Mutable tags (`latest`, `main`, `v1`) do not provide this guarantee. The same tag may resolve to different images on different days.

## Source traceability

The `candidate.source` field supports linking the image to its source code:

```yaml
candidate:
  source:
    provider: github
    repository: example/my-service
    commit: replace-with-commit-sha
```

This creates a traceable link from the simulation result back to the exact source code that produced the candidate.

## Environment recording

Set `reproducibility.recordEnvironment: true` to instruct the simulation environment to record all resolved environment variable values. This supports debugging and audit.

## Enforcement

Set `reproducibility.requireImmutableImage: true` to make the simulation environment reject recipes that use mutable image tags. This is strongly recommended for production validation campaigns.

## Determinism

Reproducibility at the recipe level (same image, same inputs) is necessary but not sufficient for fully deterministic simulation results. Candidates that rely on external state, random number generators, or wall-clock time may still produce different outputs across runs. This is expected and should be accounted for in the simulation spec's evaluation criteria.
