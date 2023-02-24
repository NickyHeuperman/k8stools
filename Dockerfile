FROM lachlanevenson/k8s-kubectl as builder
ARG YQ_VERSION=3.1.1
RUN wget -O /yq https://github.com/mikefarah/yq/releases/download/$YQ_VERSION/yq_linux_amd64 && \
    chmod +x /yq
FROM alpine/helm as helm
FROM alpine:3.11
COPY --from=builder /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=builder /yq /usr/local/bin/yq
COPY --from=helm /usr/bin/helm /usr/local/bin/helm
ENTRYPOINT ["/bin/sh -c"]
