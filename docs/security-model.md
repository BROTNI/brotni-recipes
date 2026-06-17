# Security Model

## Scope

This document describes the security model for the recipe specification itself. It does not describe the security of any specific simulation runner or Brotni platform implementation.

## Recipe files are not secrets

Recipe files are intended to be committed to version control and shared openly. They must not contain:

- Credentials or API keys
- Private endpoints
- Customer data
- Internal network addresses

## Image references

Images should be referenced by immutable digest:

```yaml
candidate:
  image: registry.example.com/my-service@sha256:replace-with-digest
```

This prevents silent image substitution between runs.

## Environment variables

Environment variables in a recipe are configuration, not secrets. If your simulation requires secret values, use a secret injection mechanism provided by your simulation runner — do not embed secrets in recipe YAML.

## Trust model

A recipe expresses the *intent* of how a candidate should run. The simulation environment is responsible for enforcing security boundaries:

- Network isolation
- Filesystem isolation
- Resource limits
- Secret injection

The recipe specification does not define how these boundaries are enforced — that is the responsibility of the simulation runner.

## Reporting security issues

If you discover a security issue in this specification repository, please report it via the repository's security advisory mechanism rather than opening a public issue.
