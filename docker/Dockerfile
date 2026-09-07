ARG BASE_IMAGE=eclipse-temurin:21-jre-jammy
FROM ${BASE_IMAGE}

ARG MC_UID=10042
ARG MC_GID=10042

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends gosu && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g ${MC_GID} mcserver && \
    useradd -u ${MC_UID} -g mcserver -M -s /usr/sbin/nologin mcserver

ENV MC_DATA_DIR=/data
WORKDIR ${MC_DATA_DIR}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]