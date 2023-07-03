FROM image-registry.openshift-image-registry.svc:5000/tars-images/node:14-buster-slim as builder

WORKDIR /opt/build

COPY ./ ./

RUN yarn install
RUN yarn generate

FROM image-registry.openshift-image-registry.svc:5000/tars-images/caddy:alpine

WORKDIR /opt/app

COPY Caddyfile /etc/caddy
COPY --from=builder /opt/build/public/ ./apps/api-event-guidelines

# expose ports
EXPOSE 3001/tcp
