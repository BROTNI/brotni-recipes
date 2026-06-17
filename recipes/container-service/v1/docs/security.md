# Security Considerations — container-service/v1

## Image immutability

Always reference images by digest:

```yaml
candidate:
  image: registry.example.com/my-service@sha256:replace-with-digest
```

Mutable tags allow images to be silently replaced between runs. This can introduce unexpected behavior changes and undermine the security of the validation process.

## No embedded secrets

Do not embed secrets in recipe files. Recipe files are intended to be committed to version control.

If your simulation run requires credentials (e.g., for external services), use a secret injection mechanism provided by your simulation runner. Do not place secrets in `env` fields in the recipe YAML.

## Input isolation

Input mounts are read-only by convention. Candidates should not attempt to modify mounted input files.

## Output path isolation

Output paths should be unique per simulation run. Do not share output directories between concurrent runs, as this can lead to data corruption and incorrect evaluation.

## Network isolation

Simulation environments should run candidates in isolated network environments unless explicit network access is required and declared.

## Registry access

The simulation environment must have read access to the image registry referenced in `candidate.image`. Ensure the registry is accessible from the simulation runner without embedding credentials in the recipe.

## Audit trail

Set `reproducibility.recordEnvironment: true` to record the resolved environment variable values for each run. This supports audit and forensic investigation of simulation results.
