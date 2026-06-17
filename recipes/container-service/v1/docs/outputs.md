# Outputs — container-service/v1

## Overview

A container-service candidate declares its outputs in the `outputs` section of the recipe. The simulation environment collects these files after the run completes and makes them available for evaluation.

## Output types

### metrics

Structured performance or behavioral metrics:

```yaml
outputs:
  metrics:
    path: /brotni/output/metrics.json
    format: json
```

Supported formats: `json`, `ndjson`, `csv`, `prometheus`

### decisions

Structured records of decisions made by the candidate during the simulation:

```yaml
outputs:
  decisions:
    path: /brotni/output/decisions.ndjson
    format: ndjson
```

Supported formats: `json`, `ndjson`

### traces

Distributed trace data:

```yaml
outputs:
  traces:
    path: /brotni/output/traces.json
    format: json
```

Supported formats: `json`, `otlp`

### logs

Structured or plain-text log output:

```yaml
outputs:
  logs:
    path: /brotni/output/logs
```

Supported formats: `text`, `json`, `ndjson`

## Output path conventions

Brotni recommends placing all outputs under `/brotni/output/` inside the container. This convention makes it easy for simulation environments to mount a dedicated output volume at that path.

## Missing outputs

If a declared output path does not exist after the run, the simulation environment records a collection warning. Whether a missing output constitutes a run failure depends on the evaluation criteria in the simulation spec.

## Output isolation

Each simulation run should write outputs to a unique directory. Do not share output paths between concurrent runs.
