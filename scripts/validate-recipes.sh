#!/usr/bin/env bash
# Validates all recipe YAML examples and test fixtures against their JSON Schemas.
# Requires: python3 with pyyaml and jsonschema packages.
# Install: pip install pyyaml jsonschema

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCHEMA="${REPO_ROOT}/recipes/container-service/v1/schema/container-service.recipe.v1.schema.json"

PASS=0
FAIL=0

validate_file() {
  local file="$1"
  local expect_valid="${2:-true}"

  result=$(python3 - <<PYEOF
import json, sys
try:
    import yaml
except ImportError:
    print("ERROR: pyyaml not installed. Run: pip install pyyaml jsonschema")
    sys.exit(2)
try:
    import jsonschema
except ImportError:
    print("ERROR: jsonschema not installed. Run: pip install pyyaml jsonschema")
    sys.exit(2)

with open("${SCHEMA}") as f:
    schema = json.load(f)
with open("${file}") as f:
    data = yaml.safe_load(f)
try:
    jsonschema.validate(instance=data, schema=schema)
    print("VALID")
except jsonschema.ValidationError as e:
    print(f"INVALID: {e.message}")
PYEOF
  )

  if [ "$expect_valid" = "true" ]; then
    if [[ "$result" == "VALID" ]]; then
      echo "  PASS (valid): ${file#$REPO_ROOT/}"
      return 0
    else
      echo "  FAIL (expected valid): ${file#$REPO_ROOT/}"
      echo "       ${result}"
      return 1
    fi
  else
    if [[ "$result" == INVALID* ]]; then
      echo "  PASS (invalid as expected): ${file#$REPO_ROOT/}"
      return 0
    else
      echo "  FAIL (expected invalid but got valid): ${file#$REPO_ROOT/}"
      return 1
    fi
  fi
}

echo "=== Validating container-service/v1 examples ==="
for f in "${REPO_ROOT}/recipes/container-service/v1/examples/"*/runtime.yaml; do
  if validate_file "$f" "true"; then
    ((PASS++)) || true
  else
    ((FAIL++)) || true
  fi
done

echo ""
echo "=== Validating container-service/v1 valid fixtures ==="
for f in "${REPO_ROOT}/recipes/container-service/v1/tests/fixtures/valid/"*.yaml; do
  if validate_file "$f" "true"; then
    ((PASS++)) || true
  else
    ((FAIL++)) || true
  fi
done

echo ""
echo "=== Validating container-service/v1 invalid fixtures (expect failures) ==="
for f in "${REPO_ROOT}/recipes/container-service/v1/tests/fixtures/invalid/"*.yaml; do
  if validate_file "$f" "false"; then
    ((PASS++)) || true
  else
    ((FAIL++)) || true
  fi
done

echo ""
echo "=== Results ==="
echo "  Passed: ${PASS}"
echo "  Failed: ${FAIL}"

if [ "${FAIL}" -gt 0 ]; then
  echo "VALIDATION FAILED"
  exit 1
else
  echo "ALL VALIDATIONS PASSED"
  exit 0
fi
