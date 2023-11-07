FROM alpine

COPY --from=ghcr.io/siderolabs/cni:v1.5.0 /opt/cni /opt/cni
COPY install.sh /

CMD /install.sh
