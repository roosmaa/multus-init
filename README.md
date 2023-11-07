# multus-init

Docker container meant to be run as an init container for [multus CNI](https://github.com/k8snetworkplumbingwg/multus-cni) pods. It copies over desired [CNI plugins](https://github.com/containernetworking/plugins) and also host specific [multus attachment definitions](https://github.com/k8snetworkplumbingwg/multus-cni/blob/master/docs/how-to-use.md#networkattachmentdefinition-with-cni-config-file).

## Usage

```yaml
# <snip>
volumes:
  - name: cnibin
    hostPath:
      path: /opt/cni/bin
  - name: cnimultus
    hostPath:
      path: /etc/cni/multus/net.d
  - name: netdefs
    secret:
      secretName: host-net-defs
# <snip>
initContainers:
  - name: install-net-definitions
    image: ghcr.io/roosmaa/multus-init:main
    env:
      - name: CNI_PLUGINS
        # space separated list of CNI plugin binary names
        value: bridge macvlan
      - name: NET_DEFS_PREFIX
        # nodeName can be used as the prefix for host specific network-definitions
        valueFrom:
          fieldRef:
            fieldPath: spec.nodeName
    volumeMounts:
      - name: cnibin
        mountPath: /host/opt/cni/bin/
      - name: cnimultus
        mountPath: /host/etc/cni/multus/net.d/
      - name: netdefs
        mountPath: /opt/net-defs/
        readOnly: true
# <snip>
```
