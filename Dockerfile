ARG NODE_EXPORTER_VERSION=v1.2.2

FROM prom/node-exporter:${NODE_EXPORTER_VERSION}
LABEL maintainer="Jürgen Löhel <juergen@loehel.de>"
LABEL org.opencontainers.image.title="Docker Swarm node-exporter"
LABEL org.opencontainers.image.authors=""
LABEL org.opencontainers.image.source="https://github.com/jloehel/docker-swarm-node-exporter"
LABEL org.opencontainers.image.url="https://ghcr.io/jloehel/swarm-node-exporter"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.description="node-exporter images with docker swarm node id/name"
LABEL org.node_exporter.version=${NODE_EXPORTER_VERSION}

USER root
COPY ./overlay /
RUN chown nobody:root /var/lib/node_exporter && chmod 775 /var/lib/node_exporter/

USER nobody
ENTRYPOINT  [ "/entrypoint.sh" ]
CMD [ "/bin/node_exporter" ]
