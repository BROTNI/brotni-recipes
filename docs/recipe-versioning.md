# Recipe Versioning

## Repository name is stable

The repository name `brotni-recipes` is stable. It will not change when new recipe families are added or when existing recipes receive new major versions.

This is why the repository is not named `brotni-recipe-container-service.v1`. Embedding the version in the repository name would require a new repository for every version of every recipe family — an unmaintainable pattern for a growing specification set.

## Where versions live

Recipe versions are expressed in four places:

### 1. apiVersion field

```yaml
apiVersion: recipe.brotni.com/v1
```

### 2. Schema filenames

```
recipes/container-service/v1/schema/container-service.recipe.v1.schema.json
```

### 3. Recipe directory structure

```
recipes/container-service/v1/
```

### 4. Git tags and releases

```
container-service/v1.0.0
container-service/v1.1.0
```

## Adding a new version of an existing recipe

When a recipe family requires a breaking change:

1. Create a new directory: `recipes/container-service/v2/`
2. Add a new schema: `container-service.recipe.v2.schema.json`
3. Update `apiVersion` to `recipe.brotni.com/v2`
4. Keep `v1` unchanged — existing users should not be broken
5. Document migration guidance in `recipes/container-service/v2/docs/`

## Adding a new recipe family

Create a new top-level directory under `recipes/`:

```
recipes/batch-job/v1/
```

Follow the same structure as `container-service/v1`.

## Stability guarantees

- Published recipe versions (v1, v2, ...) are considered stable once tagged.
- Patch releases (v1.0.1, v1.0.2) may fix documentation errors or schema description text but do not change validation behavior.
- Minor releases (v1.1.0) may add optional fields but do not break existing valid recipes.
- Major versions (v2) may introduce breaking changes.
