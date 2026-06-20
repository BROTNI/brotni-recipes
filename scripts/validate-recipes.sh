#!/usr/bin/env bash
# Validates all recipe YAML examples and test fixtures against their JSON Schemas.
# Requires: python3 with pyyaml and jsonschema packages.
# Install: pip install pyyaml jsonschema

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

PASS=0
FAIL=0

# validate_file <file> <schema> <expect_valid>
validate_file() {
  local file="$1"
  local schema="$2"
  local expect_valid="${3:-true}"

  result=$(SCHEMA="$schema" FILE="$file" python3 - <<'PYEOF'
import json, os, sys
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

with open(os.environ["SCHEMA"]) as f:
    schema = json.load(f)
with open(os.environ["FILE"]) as f:
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

# validate_family <family> <version> <schema>
validate_family() {
  local family="$1"
  local version="$2"
  local schema="$3"
  local base="${REPO_ROOT}/recipes/${family}/${version}"

  echo "=== Validating ${family}/${version} examples ==="
  for f in "${base}/examples/"*/*.yaml; do
    [ -e "$f" ] || continue
    if validate_file "$f" "$schema" "true"; then ((PASS++)) || true; else ((FAIL++)) || true; fi
  done

  echo ""
  echo "=== Validating ${family}/${version} valid fixtures ==="
  for f in "${base}/tests/fixtures/valid/"*.yaml; do
    [ -e "$f" ] || continue
    if validate_file "$f" "$schema" "true"; then ((PASS++)) || true; else ((FAIL++)) || true; fi
  done

  echo ""
  echo "=== Validating ${family}/${version} invalid fixtures (expect failures) ==="
  for f in "${base}/tests/fixtures/invalid/"*.yaml; do
    [ -e "$f" ] || continue
    if validate_file "$f" "$schema" "false"; then ((PASS++)) || true; else ((FAIL++)) || true; fi
  done
  echo ""
}

validate_family "container-service" "v1" \
  "${REPO_ROOT}/recipes/container-service/v1/schema/container-service.recipe.v1.schema.json"

validate_family "config-bundle" "v1" \
  "${REPO_ROOT}/recipes/config-bundle/v1/schema/config-bundle.recipe.v1.schema.json"

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
