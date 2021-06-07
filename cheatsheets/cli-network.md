# iptables
## forward network packets with destination localhost:8000 to {ip:port}
`iptables -t nat -A DOCKER -p tcp --dport 8000 -j DNAT --to-destination {ip:port}`
- `-t nat -A DOCKER`: rule is set under policy chain 'DOCKER' in table 'nat'.
- `-j DNAT --to-destination {ip:port}`: DNAT changes packet's destination ip to be {ip:port}.
- `-p tcp`: only tcp packets will be forwarded.
- Rule takes effect immediately without iptables restart.

## check iptables configurations
`vim /etc/sysconfig/iptables`
