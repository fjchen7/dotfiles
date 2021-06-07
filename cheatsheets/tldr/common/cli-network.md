- Export tcp://172.17.0.19:8000 (container) to localhost:8001. Here *nat* is table name.
`iptables -t {{nat}} -A {{DOCKER}} -p {{tcp}} --dport {{8001}} -j DNAT --to-destination {{172.17.0.19:8000}}`
