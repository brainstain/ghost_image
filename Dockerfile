FROM ghost:4.21.0 as gcloud
WORKDIR $GHOST_INSTALL/current
RUN gosu node yarn add ghost-gcp-storage

FROM ghost:4.21.0
RUN mkdir -p $GHOST_INSTALL/content/adapters/storage
COPY --chown=node:node --from=gcloud $GHOST_INSTALL/current/node_modules $GHOST_INSTALL/current/node_modules
COPY --chown=node:node --from=gcloud $GHOST_INSTALL/current/node_modules/ghost-gcp-storage $GHOST_INSTALL/current/core/server/adapters/storage/gcloud

