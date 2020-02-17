FROM lachlanevenson/k8s-kubectl as builder
ARG YQ_VERSION=3.1.1
RUN wget -O /yq https://github.com/mikefarah/yq/releases/download/$YQ_VERSION/yq_linux_amd64 && \
    chmod +x /yq

FROM scratch
COPY --from=builder /usr/local/bin/kubectl /kubectl
COPY --from=builder /yq /yq
ENTRYPOINT ["/kubectl"]
