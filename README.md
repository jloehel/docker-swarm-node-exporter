# Docker Swarm Node Exporter

[![Release Build](https://github.com/jloehel/docker-swarm-node-exporter/actions/workflows/release-build.yml/badge.svg)](https://github.com/jloehel/docker-swarm-node-exporter/actions/workflows/release-build.yml)

Prometheus node-exporter image with Docker Swarm node ID and name labels.

## Features

- Adds `node_meta` metric with Swarm node ID and name
- Automatic upstream version checks with issue creation
- Multi-registry publishing (GHCR + Docker Hub)

## Usage

### Docker Swarm Stack

```yaml
services:
  node-exporter:
    image: ghcr.io/jloehel/swarm-node-exporter:latest
    environment:
      - NODE_ID={{.Node.ID}}
      - NODE_NAME={{.Node.Hostname}}
    volumes:
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /:/rootfs:ro
    command:
      - '--path.procfs=/host/proc'
      - '--path.sysfs=/host/sys'
      - '--path.rootfs=/rootfs'
      - '--collector.filesystem.mount-points-exclude=^/(sys|proc|dev|host|etc)($$|/)'
    deploy:
      mode: global
    networks:
      - monitoring

networks:
  monitoring:
    driver: overlay
```

### Exported Metric

```prometheus
node_meta{node_id="abc123", container_label_com_docker_swarm_node_id="abc123", node_name="swarm-node-1"} 1
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `NODE_ID` | `none` | Docker Swarm node ID |
| `NODE_NAME` | `localhost` | Docker Swarm node hostname |

## Supported Tags

| Tag | Description |
|-----|-------------|
| `latest` | Latest release |
| `1.10.2` | Specific node-exporter version |

## Building

```bash
docker build -t swarm-node-exporter .
```

With specific version:

```bash
docker build --build-arg NODE_EXPORTER_VERSION=1.10.2 -t swarm-node-exporter:1.10.2 .
```

## License

MIT License
