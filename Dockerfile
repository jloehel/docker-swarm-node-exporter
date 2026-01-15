ARG NODE_EXPORTER_VERSION=1.10.2

FROM prom/node-exporter:v${NODE_EXPORTER_VERSION}

ARG NODE_EXPORTER_VERSION

LABEL maintainer="Jürgen Löhel <juergen@loehel.de>"
LABEL org.opencontainers.image.title="Docker Swarm node-exporter"
LABEL org.opencontainers.image.authors="Jürgen Löhel"
LABEL org.opencontainers.image.source="https://github.com/jloehel/docker-swarm-node-exporter"
LABEL org.opencontainers.image.url="https://ghcr.io/jloehel/swarm-node-exporter"
LABEL org.opencontainers.image.description="node-exporter image with docker swarm node id/name"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.node_exporter.version="${NODE_EXPORTER_VERSION}"

USER root
COPY ./overlay /
RUN chown nobody:root /var/lib/node_exporter && chmod 775 /var/lib/node_exporter/

USER nobody
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/node_exporter"]
