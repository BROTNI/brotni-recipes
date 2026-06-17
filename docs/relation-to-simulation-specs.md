# Relation to Simulation Specs

## Three separate concerns

Simulation-first validation uses three separate contracts:

| Contract | Answers |
|----------|---------|
| **Recipe** | How does this candidate run? |
| **Simulation spec** | What should be evaluated? |
| **Context snapshot** | What environment and state is used? |

Each is a separate document. They are composed by the simulation campaign, not merged into one file.

## What a simulation spec defines

A simulation spec defines:

- Which scenarios to run
- What replay data to use
- What hypotheses to test
- What evaluation criteria determine success or failure
- How to aggregate results across multiple runs

## What a recipe defines

A recipe defines:

- The candidate artifact (image reference, source traceability)
- How to start the candidate (command, args, env, ports)
- When the candidate is ready (health check)
- What inputs to provide (mounted files)
- What outputs to collect (metrics, decisions, traces, logs)
- Resource hints and timeouts
- Reproducibility enforcement

## Why they are separate

Separating the execution contract (recipe) from the evaluation contract (simulation spec) means:

- The same recipe can be used across multiple simulation specs.
- The same simulation spec can be applied to different candidate versions.
- Recipe changes can be reviewed independently from evaluation criteria changes.
- The recipe is owned by the candidate team; the simulation spec may be owned by a platform team.

## Example composition

A simulation campaign might combine:

```
recipe: recipes/container-service/v1/examples/full/runtime.yaml
simulation-spec: specs/routing-scenarios/v1/routing.spec.yaml    (separate repository)
context-snapshot: snapshots/production-traffic-2024-01-15.yaml   (separate repository)
```

The recipe repository (`brotni-recipes`) contains only the execution contract.
