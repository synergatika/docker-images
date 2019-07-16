FROM dyne/devuan:ascii

EXPOSE 80 443 1194 1194/udp

COPY --chown=root:root ["install.sh", "/root"]
ADD docker-entrypoint.sh /bin/docker-entrypoint.sh

RUN bash /root/install.sh

ENTRYPOINT ["/bin/bash"]

# CMD ["/usr/bin/tail", "-f", "/var/log/pritunl.log"]