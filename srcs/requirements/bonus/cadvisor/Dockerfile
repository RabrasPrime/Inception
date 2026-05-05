FROM alpine:3.22

RUN apk update && apk add --no-cache \
    libc6-compat \
    ca-certificates

ARG CADVISOR_VERSION=v0.49.1

RUN wget -O /usr/local/bin/cadvisor \
    https://github.com/google/cadvisor/releases/download/${CADVISOR_VERSION}/cadvisor-${CADVISOR_VERSION}-linux-amd64 && \
    chmod +x /usr/local/bin/cadvisor

EXPOSE 8081

ENTRYPOINT ["/usr/local/bin/cadvisor"]

CMD ["-port=8081"]
