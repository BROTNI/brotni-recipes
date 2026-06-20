# config-bundle recipe v1 — specification

This document describes every field of the `ConfigBundleRecipe` v1 schema. The
authoritative contract is
[../schema/config-bundle.recipe.v1.schema.json](../schema/config-bundle.recipe.v1.schema.json).

## Top-level

| Field | Required | Description |
|-------|----------|-------------|
| `apiVersion` | yes | Must be `recipe.brotni.com/v1`. |
| `kind` | yes | Must be `ConfigBundleRecipe`. |
| `metadata` | yes | `name` (required) and optional `description`. |
| `configuration` | yes | The bundle under evaluation. See below. |
| `validation` | no | Schema and rule assertions applied before the run. |
| `apply` | no | How the configuration is materialized into the run. |
| `outputs` | no | Declared output paths the simulation collects. |
| `timeouts` | no | `runSeconds`. |
| `reproducibility` | no | Digest enforcement and audit recording. |

## `configuration`

Provide **exactly one** of `data` (inline content) or `ref` (external bundle).

| Field | Required | Description |
|-------|----------|-------------|
| `format` | yes | One of `json`, `yaml`, `toml`, `env`, `properties`, `ini`, `hcl`. |
| `data` | one-of | Inline configuration content as a string. |
| `ref` | one-of | `{ uri, digest }` reference to an external immutable bundle. |
| `digest` | no | `sha256:...` digest of inline `data` — the candidate's identity. |
| `appliesTo` | no | Logical target the configuration applies to. |
| `source` | no | `{ provider, repository, commit }` for traceability. |

## `validation`

| Field | Description |
|-------|-------------|
| `schema` | Path/URI of a schema the configuration must satisfy. |
| `rules[]` | `{ name, expression, severity }` assertions. `blocking` rules gate the candidate. |

## `apply`

| Field | Description |
|-------|-------------|
| `mountPath` | Path where the configuration is materialized inside the run. |
| `envPrefix` | If set, keys are also exposed as env vars with this prefix. |
| `reloadCommand[]` | Optional command to signal the target to reload configuration. |

## `outputs`

`metrics`, `decisions`, and `logs`, each `{ path, format }`. Metrics feed the
campaign's scoring engine; decisions and logs are collected for the report.

## `reproducibility`

| Field | Description |
|-------|-------------|
| `requireDigest` | Reject bundles without a content digest. |
| `recordConfigDigest` | Record the resolved configuration digest for audit. |
