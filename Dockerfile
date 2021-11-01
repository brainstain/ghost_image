FROM ghost:4.20.4-alpine as gcloud
WORKDIR $GHOST_INSTALL/current
RUN su-exec node yarn add ghost-google-cloud-storage

FROM ghost:4.20.4-alpine
RUN mkdir -p $GHOST_INSTALL/content/adapters/storage
COPY --chown=node:node --from=gcloud $GHOST_INSTALL/current/node_modules $GHOST_INSTALL/current/node_modules
COPY --chown=node:node --from=gcloud $GHOST_INSTALL/current/node_modules/ghost-google-cloud-storage $GHOST_INSTALL/current/core/server/adapters/storage/gcloud
RUN set -ex; \
    su-exec node ghost config storage.active gcloud;
