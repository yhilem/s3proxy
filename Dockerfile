FROM docker.io/library/eclipse-temurin:21-jre
LABEL maintainer="Andrew Gaul <andrew@gaul.org>"

WORKDIR /opt/s3proxy

RUN apt-get update && \
    apt-get install -y dumb-init && \
    rm -rf /var/lib/apt/lists/*

COPY \
    target/s3proxy \
    src/main/resources/run-docker-container.sh \
    /opt/s3proxy/

ENV \
    LOG_LEVEL="info" \
    S3PROXY_AUTHORIZATION="aws-v2-or-v4" \
    S3PROXY_ENDPOINT="http://0.0.0.0:80" \
    S3PROXY_IDENTITY="local-identity" \
    S3PROXY_CREDENTIAL="local-credential" \
    S3PROXY_VIRTUALHOST="" \
    S3PROXY_KEYSTORE_PATH="keystore.jks" \
    S3PROXY_KEYSTORE_PASSWORD="password" \
    S3PROXY_CORS_ALLOW_ALL="false" \
    S3PROXY_CORS_ALLOW_ORIGINS="" \
    S3PROXY_CORS_ALLOW_METHODS="" \
    S3PROXY_CORS_ALLOW_HEADERS="" \
    S3PROXY_CORS_ALLOW_CREDENTIAL="" \
    S3PROXY_IGNORE_UNKNOWN_HEADERS="false" \
    S3PROXY_ENCRYPTED_BLOBSTORE="" \
    S3PROXY_ENCRYPTED_BLOBSTORE_PASSWORD="" \
    S3PROXY_ENCRYPTED_BLOBSTORE_SALT="" \
    S3PROXY_READ_ONLY_BLOBSTORE="false" \
    JCLOUDS_PROVIDER="filesystem-nio2" \
    JCLOUDS_ENDPOINT="" \
    JCLOUDS_REGION="" \
    JCLOUDS_REGIONS="us-east-1" \
    JCLOUDS_IDENTITY="remote-identity" \
    JCLOUDS_CREDENTIAL="remote-credential" \
    JCLOUDS_KEYSTONE_VERSION="" \
    JCLOUDS_KEYSTONE_SCOPE="" \
    JCLOUDS_KEYSTONE_PROJECT_DOMAIN_NAME="" \
    JCLOUDS_FILESYSTEM_BASEDIR="/data"

EXPOSE 80 443

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/opt/s3proxy/run-docker-container.sh"]
