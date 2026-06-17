# Concepts

## Recipe

A **recipe** is a versioned, vendor-neutral specification that describes how a candidate artifact should be executed, observed, given inputs, expected to produce outputs, and evaluated inside a simulation campaign.

A recipe is the execution contract between a candidate artifact and a simulation environment.

## Candidate

A **candidate** is an artifact under evaluation. In simulation-first validation, a candidate is not deployed to production directly. Instead, it is first run inside a controlled simulation campaign according to the rules defined in a recipe.

Examples: a container image, a configuration bundle, a Helm chart, a script.

## Simulation campaign

A **simulation campaign** is a coordinated execution of one or more simulation runs against a candidate. Each run uses a recipe (the execution contract), a simulation spec (what to evaluate), and a context snapshot (what environment to use).

## Simulation spec

A **simulation spec** defines what should be evaluated in a campaign. It describes scenarios, hypotheses, replay data sources, and evaluation criteria.

A simulation spec answers: *what should be tested and how should results be judged?*

A recipe answers: *how does this candidate run?*

These are intentionally separate concerns.

## Execution contract

The **execution contract** is the formal agreement between a candidate and a simulation environment. The recipe is this contract.

It specifies: how to start the candidate, what inputs to provide, what outputs to collect, when the candidate is considered healthy, and when the run is considered complete.

## Runtime output

**Runtime output** is any structured data produced by a candidate during a simulation run. This includes metrics, decisions, traces, and logs. Outputs are declared in the recipe and collected by the simulation environment after the run.

## Reproducibility

**Reproducibility** means that two simulation runs with the same recipe, same inputs, and same context should produce comparable results.

At the recipe level, reproducibility is enforced by:

- Using immutable image references (`image@sha256:...` instead of mutable tags)
- Recording resolved environment variables
- Pinning source code references

Full determinism also requires the candidate itself to be deterministic, which is the candidate's responsibility, not the recipe's.
