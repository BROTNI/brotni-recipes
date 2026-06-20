# Schemas

This directory is an index of all published JSON Schemas for Brotni recipe families.

## Published schemas

| Schema | Recipe | Version | Path |
|--------|--------|---------|------|
| `container-service.recipe.v1.schema.json` | container-service | v1 | [recipes/container-service/v1/schema/](../recipes/container-service/v1/schema/container-service.recipe.v1.schema.json) |
| `config-bundle.recipe.v1.schema.json` | config-bundle | v1 | [recipes/config-bundle/v1/schema/](../recipes/config-bundle/v1/schema/config-bundle.recipe.v1.schema.json) |

## Schema locations

Schemas are co-located with their recipe family and version:

```
recipes/<family>/v<n>/schema/<family>.recipe.v<n>.schema.json
```

This ensures schemas are versioned together with their specifications and examples.

## Using schemas

Validate a recipe YAML file using the provided script:

```bash
./scripts/validate-recipes.sh
```

Or validate directly using any JSON Schema validator (Draft 7 compatible):

```bash
# Using ajv-cli
ajv validate -s recipes/container-service/v1/schema/container-service.recipe.v1.schema.json \
             -d your-recipe.yaml

# Using Python jsonschema
python3 -c "
import json, yaml, jsonschema
schema = json.load(open('recipes/container-service/v1/schema/container-service.recipe.v1.schema.json'))
data = yaml.safe_load(open('your-recipe.yaml'))
jsonschema.validate(data, schema)
print('Valid')
"
```
