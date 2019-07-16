#!/bin/bash

SCRIPT_VERSION="1.0.1"

set -Eeuo pipefail

if [ "$PRITUNL_DEBUG" == "true" ];
    then
        set -x
fi

log() {
    echo "$(date -u +%FT) <docker-entrypoint> $*"
}

log "INFO - Script version ${SCRIPT_VERSION} ${PRITUNL_DEBUG}"

PRITUNL=/usr/bin/pritunl

PRITUNL_OPTS="${PRITUNL_OPTS}"

pritunl_setup() {
    log "INFO - Insuring pritunl setup for container"

    ${PRITUNL} set-mongodb ${MONGODB_URI:-"mongodb://mongo:27017/pritunl"}

    ${PRITUNL} set app.reverse_proxy false
    ${PRITUNL} set app.server_ssl true
    ${PRITUNL} set app.server_port 443

    PRITUNL_OPTS="start ${PRITUNL_OPTS}"
}

# allow changing bind addr
if [ -z "$PRITUNL_BIND_ADDR" ]; then
    PRITUNL_BIND_ADDR="0.0.0.0"
fi

# if [ -z "$PRITUNL_DONT_WRITE_CONFIG" ]; then
#     cat << EOF > /etc/pritunl.conf
#     {
#         "mongodb_uri": "$PRITUNL_MONGODB_URI",
#         "server_key_path": "/var/lib/pritunl/pritunl.key",
#         "log_path": "/var/log/pritunl.log",
#         "static_cache": true,
#         "server_cert_path": "/var/lib/pritunl/pritunl.crt",
#         "temp_path": "/tmp/pritunl_%r",
#         "bind_addr": "$PRITUNL_BIND_ADDR",
#         "debug": $PRITUNL_DEBUG,
#         "www_path": "/usr/share/pritunl/www",
#         "local_address_interface": "auto"
#     }
# EOF

# fi

# exec /usr/bin/pritunl start -c /etc/pritunl.conf

