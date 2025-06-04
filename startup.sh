#!/bin/bash
iptables -t nat -A POSTROUTING -j MASQUERADE
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
if [ ! -f /etc/ocserv/privkey.pem ]; then
    openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout /etc/ocserv/privkey.pem -out /etc/ocserv/fullchain.pem -subj "$CERT_FINGERPRINT"
fi
exec "$@"