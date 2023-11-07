#!/bin/sh

# Install desired CNI plugins
mkdir -p /host/opt/cni/bin
for cni in $CNI_PLUGINS; do
    cp /opt/cni/bin/${cni} /host/opt/cni/bin/
done

# Install desired network definitions
mkdir -p /host/etc/cni/multus/net.d
if [ -z "$NET_DEFS_PREFIX" ]; then
    echo "NET_DEFS_PREFIX not set, not copying over any network definitions"
else
    for path in /opt/net-defs/${NET_DEFS_PREFIX}.*; do
        src=$(basename $path)
        dst=${src#${NET_DEFS_PREFIX}.} # strip prefix from source file name
        cp /opt/net-defs/${src} /host/etc/cni/multus/net.d/${dst}
    done
fi
