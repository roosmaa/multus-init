#!/bin/sh

# Install desired CNI plugins
mkdir -p /host/opt/cni/bin
for cni in $CNI_PLUGINS; do
    cp /opt/cni/bin/${cni} /host/opt/cni/bin/
done

# Install desired network definitions
mkdir -p /host/etc/cni/multus/net.d
if [ -z "$NET_DEFS_DIR" ]; then
    echo "NET_DEFS_DIR not set, not copying over any network definitions"
else
    cp /opt/net-defs/${NET_DEFS_DIR}/* /host/etc/cni/multus/net.d/
fi
