#!/bin/sh -e

export NODE_ID=${NODE_ID:-none}
export NODE_NAME=${NODE_NAME:-$(cat /etc/nodename)}

echo "node_meta{node_id=\"$NODE_ID\", container_label_com_docker_swarm_node_id=\"$NODE_ID\", node_name=\"$NODE_NAME\"} 1" > /var/lib/node_exporter/node-meta.prom

set -- /bin/node_exporter --collector.textfile.directory=/var/lib/node_exporter/ "$@"

exec "$@"
