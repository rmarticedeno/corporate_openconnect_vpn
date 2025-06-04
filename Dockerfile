FROM debian:12

ARG CERT_FINGERPRINT

RUN apt update && apt install -y ocserv iptables openssl
WORKDIR /etc/ocserv
COPY ocserv.conf /etc/ocserv/ocserv.conf
COPY startup.sh /startup.sh
#COPY certs/fullchain.pem certs/privkey.pem ./
#RUN openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout /etc/ocserv/privkey.pem -out /etc/ocserv/fullchain.pem -subj $CERT_FINGERPRINT
EXPOSE 443/tcp
EXPOSE 443/udp
ENTRYPOINT ["bash", "/startup.sh"]
CMD ["ocserv", "-c", "/etc/ocserv/ocserv.conf", "-f"]