# Set default policy on INPUT and OUTPUT chains to DROP packets that dont match the rules
iptables -P INPUT DROP
iptables -P OUTPUT DROP

# Only accept packets on the INPUT chain that are ESTABLISHED or RELATED to a current connection
iptables -A INPUT -m state  --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -m state  --state ESTABLISHED,RELATED -j ACCEPT

# Allow ONLY packets with the following protocols and port numbers to be sent out
iptables -A OUTPUT -t filter -p tcp --dport http -j ACCEPT
iptables -A OUTPUT -t filter -p tcp --dport 53 -j ACCEPT
iptables -A OUTPUT -t filter -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -t filter -p tcp --dport https -j ACCEPT
iptables -A OUTPUT -t filter -p udp --dport https -j ACCEPT

# Allow ssh.
# iptables -A OUTPUT -t filter -p tcp --dport 22 -j ACCEPT

# allow just local connections.
iptables -A INPUT -t filter -p tcp -s localhost -j ACCEPT
iptables -A OUTPUT -t filter -p tcp -s localhost -j ACCEPT

# allow connections on 8000.
iptables -A INPUT -t filter -p tcp --dport 8000 -j ACCEPT
iptables -A OUTPUT -t filter -p tcp --dport 8000 -j ACCEPT
iptables -A OUTPUT -t filter -p tcp --dport 8245 -j ACCEPT

iptables -A OUTPUT -t filter -p tcp --dport 15675 -j ACCEPT
iptables -A OUTPUT -t filter -p tcp --dport 6667 -j ACCEPT
iptables -A OUTPUT -t filter -p tcp --dport 587 -j ACCEPT


# Save the rules manually.
iptables-save > /etc/iptables/iptables.rules

# There is an iptables service that can be enabled
# it automatically loads the rules from iptables.rules.
cat /usr/lib/systemd/system/iptables.service   
systemctl enable iptables

