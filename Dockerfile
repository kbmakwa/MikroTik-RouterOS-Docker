FROM alpine:3.11

# For access via VNC
EXPOSE 5900

# Expose Ports of RouterOS
EXPOSE 1194 1701 1723 1812/udp 1813/udp 21 22 23 443 4500/udp 50 500/udp 51 2021 2022 2023 2027 5900 80 8080 8291 8728 8729 8900

# Change work dir (it will also create this folder if is not exist)
WORKDIR /routeros

# Install dependencies
RUN set -xe \
 && apk add --no-cache --update \
    netcat-openbsd qemu-x86_64 qemu-system-x86_64 \
    busybox-extras iproute2 iputils \
    bridge-utils  unzip iptables jq bash python3

# Environments which may be change
ENV ROUTEROS_VERSON="7.8"
ENV ROUTEROS_IMAGE="chr-7.8.vdi"

ENV ROUTEROS_PATH="https://download.mikrotik.com/routeros/7.8/chr-7.8.vdi.zip"
#"https://download.mikrotik.com/routeros/$ROUTEROS_VERSON/$ROUTEROS_IMAGE"
#RUN  unzip chr-7.8.vdi.zip
# Download VDI image from remote site
RUN wget "$ROUTEROS_PATH" -O "/routeros/chr-7.8.vdi.zip"

RUN  unzip /routeros/chr-7.8.vdi.zip -d /routeros

RUN  rm -rf  /routeros/chr-7.8.vdi.zip	

# Copy script to routeros folder
ADD ["./scripts", "/routeros"]

ENTRYPOINT ["/routeros/entrypoint_for_docker_8interfaces.sh"]
