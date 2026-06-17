# Health Checks — container-service/v1

## Purpose

The health check tells the simulation environment when the container is ready to receive inputs. Before the health check passes, the environment will not mount inputs or consider the run active.

## HTTP health check

```yaml
healthcheck:
  http:
    path: /health
    port: 8080
  initialDelaySeconds: 5
  timeoutSeconds: 60
```

The simulation environment sends an HTTP GET request to `http://localhost:<port><path>`. A 2xx response indicates the service is healthy.

## Exec health check

```yaml
healthcheck:
  exec:
    command: ["./health-check.sh"]
  initialDelaySeconds: 2
  timeoutSeconds: 30
```

The simulation environment runs the specified command inside the container. An exit code of 0 indicates the service is healthy.

## Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `initialDelaySeconds` | Seconds to wait before starting health checks | 0 |
| `periodSeconds` | How often to run the health check | 10 |
| `timeoutSeconds` | Maximum seconds to wait for the service to become healthy | 30 |

## Failure behavior

If the health check does not pass within `timeoutSeconds`, the simulation run is marked as a startup failure. No inputs are provided and no outputs are collected.

## Recommendations

- Set `initialDelaySeconds` to account for JVM warm-up, dependency initialization, or similar startup overhead.
- Keep `timeoutSeconds` generous enough for your service but tight enough to detect real startup failures quickly.
- Implement a `/health` endpoint that verifies internal readiness, not just process liveness.
