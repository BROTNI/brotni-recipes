# Contributing to brotni-recipes

Thank you for your interest in contributing to Brotni Recipes.

This repository defines public, versioned execution contracts for simulation-first validation. Contributions should maintain the quality, neutrality, and stability of those contracts.

---

## What belongs here

- New recipe family specifications (with schema, docs, examples, and fixtures)
- Corrections to existing specifications
- Additional examples that demonstrate practical use cases
- Documentation improvements
- Schema validation tooling improvements

## What does not belong here

- Private Brotni platform implementation code
- Simulation engine implementations
- Runner implementations
- Secrets, private endpoints, or customer data
- CI/CD workflow configurations for specific platforms

---

## Contribution process

1. **Open an issue first** for any significant change (new recipe family, breaking schema change, major documentation restructuring).
2. **Fork the repository** and create a feature branch.
3. **Implement the change** following the structure described below.
4. **Run validation** to ensure all examples pass schema validation.
5. **Submit a pull request** with a clear description of the change and its motivation.

---

## Adding a new recipe family

A new recipe family must include:

```
recipes/<family-name>/
  v1/
    README.md
    schema/
      <family-name>.recipe.v1.schema.json
    docs/
      specification.md
      security.md
      reproducibility.md
      outputs.md
      (additional docs as needed)
    examples/
      minimal/
        runtime.yaml
      (additional examples)
    tests/
      fixtures/
        valid/
          (valid YAML fixtures)
        invalid/
          (invalid YAML fixtures with comments explaining expected failure)
```

The recipe must also be:

- Added to the `Current recipe families` table in the root `README.md`
- Added to the `schemas/README.md` index
- Included in the CI validation workflow

---

## Schema requirements

Schemas must be valid JSON Schema (Draft 7 or later).

Schemas must:

- Use `$schema` to declare the JSON Schema version
- Include `title` and `description` fields
- Mark required fields explicitly
- Use `additionalProperties: false` where appropriate to prevent silent misconfigurations

---

## Style guide

- Keep YAML examples small, practical, and copyable.
- Use `image@sha256:...` style references in examples (not mutable tags).
- Do not include real registry URLs, real SHA digests, or real endpoints in examples.
- Use `example.com` or `registry.example.com` as placeholder domains.
- Write documentation in plain English. Avoid marketing language.

---

## Code of conduct

All contributors are expected to follow the [Code of Conduct](CODE_OF_CONDUCT.md).

---

## License

By contributing to this repository, you agree that your contributions will be licensed under the Apache License 2.0.
