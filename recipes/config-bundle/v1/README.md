# config-bundle recipe — v1

> Execution contract for **configuration and policy bundle** candidates: changes
> that alter system behaviour through configuration alone, with no new code or
> container image.

- **API version**: `recipe.brotni.com/v1`
- **Kind**: `ConfigBundleRecipe`
- **Schema**: [schema/config-bundle.recipe.v1.schema.json](schema/config-bundle.recipe.v1.schema.json)
- **Status**: Stable

## When to use this recipe

Use `config-bundle` when the candidate under evaluation is a configuration or
policy change rather than a code or image change — for example a routing policy,
feature-flag snapshot, rate-limit profile, or other config-as-code artifact.
This lets a [simulation campaign](../../../README.md) compare configuration
variants on the same goals and constraints as code or image candidates.

## Identity

A config bundle's identity is the **immutable content digest** of the
configuration, never a mutable version label. Provide either inline `data` (with
an optional `configuration.digest`) or an external `configuration.ref` pinned by
digest. Set `reproducibility.requireDigest: true` to reject unpinned bundles.

## Minimal example

```yaml
apiVersion: recipe.brotni.com/v1
kind: ConfigBundleRecipe
metadata:
  name: minimal-config-candidate
configuration:
  format: json
  data: |
    { "feature_flags": { "new_router": true } }
```

See [examples/](examples/) for a full example and
[docs/specification.md](docs/specification.md) for the complete field reference.

## Relationship to other layers

- A **simulation spec** says *what* to evaluate (goals, constraints, KPIs).
- This **recipe** says *how* the config-bundle candidate is materialized,
  applied, and observed.
- A **context** says *where and under what state* the run happens.

See the repository [README](../../../README.md) for the three-layer model.

## Validating

```bash
./scripts/validate-recipes.sh
```
