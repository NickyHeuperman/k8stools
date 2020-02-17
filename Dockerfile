FROM lachlanevenson/k8s-kubectl as builder
ARG YQ_VERSION=3.1.1
RUN wget -O /yq https://github.com/mikefarah/yq/releases/download/$YQ_VERSION/yq_linux_amd64 && \
    chmod +x /yq_linux_amd64 && \

FROM scratch
COPY --from=builder /kubectl /kubectl
COPY --from=builder /yq_linux_amd64 /yq
ENTRYPOINT ["/kubectl"]
