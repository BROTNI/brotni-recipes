# Compatibility

## Schema compatibility

Recipe schemas follow semantic versioning principles:

- **Patch** (v1.0.1): Documentation corrections, description text improvements. No validation behavior changes.
- **Minor** (v1.1.0): New optional fields added. Existing valid recipes remain valid.
- **Major** (v2): Breaking changes to required fields, field types, or validation rules.

## Backward compatibility within a major version

A recipe valid against `container-service.recipe.v1.schema.json` version 1.0.0 must remain valid against all 1.x.y versions.

## Forward compatibility

Recipes that use only required fields will be most compatible with future minor versions.

## Cross-version migration

When a new major version is released, migration documentation is provided in the new version's `docs/` directory. Both versions will be maintained in this repository simultaneously for a deprecation period.

## Platform compatibility

Recipes are vendor-neutral by design. They do not assume:

- A specific container runtime (Docker, containerd, podman)
- A specific orchestration platform (Kubernetes, ECS, Nomad)
- A specific CI/CD system (GitHub Actions, GitLab CI, Jenkins)
- A specific cloud provider

Simulation environments are responsible for interpreting recipe fields in the context of their target platform.
