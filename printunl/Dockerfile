FROM dyne/devuan:ascii

WORKDIR /service

EXPOSE 80 443 1194 1194/udp

COPY --chown=root:root ["install.sh", "/root"]

COPY docker-entrypoint.sh /usr/local/bin
RUN ln -s /usr/local/bin/docker-entrypoint.sh /

RUN bash /root/install.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["pritunl"]