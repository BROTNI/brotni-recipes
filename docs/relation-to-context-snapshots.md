# Relation to Context Snapshots

## What a context snapshot is

A **context snapshot** captures the external dependencies, data fixtures, and infrastructure state required for a simulation run to be meaningful.

Examples of what a context snapshot may include:

- Replay data (recorded traffic, events, requests)
- Database state at a point in time
- Feature flag configurations
- External service stubs or mocks
- Infrastructure topology descriptions

## How recipes depend on context snapshots

A recipe declares the *inputs* it expects — but does not manage the lifecycle of those inputs.

For example, a recipe declares:

```yaml
inputs:
  mounts:
    - name: replay-events
      path: /brotni/input/events.ndjson
      required: true
```

The simulation environment is responsible for materializing the context snapshot and making it available at the declared mount path before the candidate starts.

The recipe does not know or care where the replay events came from. That is the context snapshot's responsibility.

## Clear separation of concerns

| Concern | Owner |
|---------|-------|
| What inputs the candidate expects | Recipe |
| Where those inputs come from | Context snapshot |
| How the inputs are prepared and mounted | Simulation runner |

This separation means:

- The same recipe can be run against different context snapshots (e.g., different traffic patterns, different dates).
- Context snapshots can be updated independently of the recipe.
- Recipes remain vendor-neutral and environment-independent.

## Context snapshot lifecycle

A context snapshot is prepared before the simulation campaign starts. The recipe does not manage this preparation. The simulation runner coordinates context snapshot preparation and recipe execution.
