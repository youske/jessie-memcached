#!/bin/bash -eu

service memcached start

cat <<EOF >>~/.bashrc
trap "service memcached stop; exit 0" TERM
EOF

exec /bin/bash
