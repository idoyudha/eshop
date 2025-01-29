FROM redis:7-alpine

EXPOSE 26379

RUN mkdir -p /etc/redis /data && \
    chown redis:redis /etc/redis /data

ADD sentinel.conf /etc/redis/sentinel.conf
RUN chown redis:redis /etc/redis/sentinel.conf && \
    chmod 777 /etc/redis/sentinel.conf  # Give full permissions

ENV SENTINEL_QUORUM 2
ENV SENTINEL_DOWN_AFTER 5000
ENV SENTINEL_FAILOVER 15000
ENV REDIS_MASTER_PASSWORD password

COPY sentinel-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/sentinel-entrypoint.sh

USER redis

ENTRYPOINT ["sentinel-entrypoint.sh"]