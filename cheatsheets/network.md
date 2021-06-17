# Basic

## resolve DNS: find ip of give domain
- `nslookup example.com`
- `ping example.com`

# iptables

## forward network packets sent to localhost:8000 to {ip:port}
`iptables -t nat -A DOCKER -p tcp --dport 8000 -j DNAT --to-destination {ip:port}`
- `-t nat -A DOCKER`: set rule under policy chain 'DOCKER' in table 'nat'.
- `-j DNAT --to-destination {ip:port}`: DNAT changes packet's destination from {localhost:8000} to {ip:port}
- `-p tcp`: only forward tcp packets

Rule takes effect immediately without iptables restart.

## check iptables configurations
`vim /etc/sysconfig/iptables`
