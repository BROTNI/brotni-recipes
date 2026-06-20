# brotni-recipes

> Brotni Recipes define how simulation candidates are executed, observed, and evaluated before they are trusted for production.

> A recipe is not a CI/CD workflow. It is the execution contract between a candidate artifact and a simulation environment.

---

## What are Brotni Recipes?

A **Brotni Recipe** is a versioned, vendor-neutral specification that describes how a candidate artifact should be materialized, started, observed, given inputs, expected to produce outputs, and evaluated inside a Brotni-compatible simulation workflow.

Recipes are the execution contracts of the simulation-first validation model.

---

## Why do recipes exist?

Simulation-first validation requires a clear, reproducible description of how a candidate runs. Without a recipe:

- Different simulation environments would interpret the same artifact differently.
- Reproducibility guarantees would be impossible.
- Validation contracts would be implicit and fragile.

Recipes make execution contracts explicit, versioned, and portable.

---

## Why are recipes separate from CI/CD workflows?

A CI/CD workflow describes *when* and *how* to build and deploy artifacts. A recipe describes *how a specific artifact type runs inside a simulation campaign*.

Recipes are not GitHub Actions. They are not Kubernetes manifests. They are not deployment configs. They are execution contracts that simulation environments consume.

This means a recipe can be used across any CI/CD platform, any simulation runner, and any cloud — without coupling the contract to any specific orchestration tool.

---

## How recipes relate to simulation specs

A **simulation spec** answers: *what should be evaluated?* It defines the scenarios, hypotheses, and evaluation criteria.

A **recipe** answers: *how does this candidate run?* It defines the execution contract for the artifact under test.

See [docs/relation-to-simulation-specs.md](docs/relation-to-simulation-specs.md) for more.

---

## How recipes relate to context snapshots

A **context snapshot** answers: *what environment and state is used?* It captures the external dependencies, data fixtures, and infrastructure state required for the simulation.

A recipe depends on prepared context but does not manage the full lifecycle of that context itself.

See [docs/relation-to-context-snapshots.md](docs/relation-to-context-snapshots.md) for more.

---

## How this repository is versioned

The repository name `brotni-recipes` is stable. Recipe versions live inside the repository:

- In `apiVersion` fields (e.g., `recipe.brotni.com/v1`)
- In schema filenames (e.g., `container-service.recipe.v1.schema.json`)
- In recipe directory versions (e.g., `recipes/container-service/v1`)
- In git tags and releases (e.g., `container-service/v1.0.0`)

This is why the repository is not named `brotni-recipe-container-service.v1`. Embedding the version in the repository name would make it impossible to host multiple recipe families and versions in one place.

See [docs/recipe-versioning.md](docs/recipe-versioning.md) for more.

---

## Current recipe families

| Recipe | Version | Status |
|--------|---------|--------|
| [container-service](recipes/container-service/v1/) | v1 | Stable |
| [config-bundle](recipes/config-bundle/v1/) | v1 | Stable |

---

## Planned recipe families

The following recipe families are planned for future versions. They are **not yet implemented**.

- `batch-job` — for containerized batch workloads that run to completion
- `script-bundle` — for scripted execution candidates
- `helm-release` — for Kubernetes Helm chart candidates
- `package-runtime` — for language runtime package candidates
- `policy-bundle` — for policy-as-code artifacts
- `agent-strategy` — for autonomous agent candidates

---

## Validating examples

You can validate recipe YAML files against the JSON Schema using the provided script:

```bash
./scripts/validate-recipes.sh
```

This validates all examples in `recipes/container-service/v1/examples/` and test fixtures in `recipes/container-service/v1/tests/fixtures/`.

Requirements: `bash`, `python3` (for JSON Schema validation via `jsonschema`) or `ajv-cli`.

See [scripts/validate-recipes.sh](scripts/validate-recipes.sh) for details.

---

## How to contribute a future recipe

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full contribution guide.

To propose a new recipe family:

1. Open an issue describing the candidate type and use case.
2. Discuss the execution contract requirements.
3. Submit a PR with the recipe directory, schema, docs, examples, and fixtures.
4. Ensure the CI validation workflow passes.

---

## Repository structure

```
brotni-recipes/
  README.md
  LICENSE
  NOTICE
  CONTRIBUTING.md
  CODE_OF_CONDUCT.md

  recipes/
    container-service/
      v1/                        ← first recipe family, first version

  docs/                          ← cross-cutting concepts and versioning docs

  schemas/                       ← index of all published schemas

  examples/                      ← top-level examples index

  scripts/                       ← validation tooling
```

---

## License

Apache License 2.0. See [LICENSE](LICENSE).
