FROM debian:12

ARG CERT_FINGERPRINT

RUN apt update && apt install -y ocserv iptables openssl expect
WORKDIR /etc/ocserv
COPY ocserv.conf add_user.exp ./
COPY startup.sh /startup.sh
#COPY certs/fullchain.pem certs/privkey.pem ./
EXPOSE 443/tcp
EXPOSE 443/udp
ENTRYPOINT ["bash", "/startup.sh"]
CMD ["ocserv", "-c", "/etc/ocserv/ocserv.conf", "-f"]