#!/usr/bin/env sh
sudo nft -f - <<'EOF'
table inet server {}
delete table inet server
table inet server {
    chain input {
        type filter hook input priority 0; policy accept;

        tcp dport 8080 ct state new \
            meter conn_rate { ip saddr limit rate over 10/minute } \
            counter drop
        tcp dport 8080 \
            meter conn_count { ip saddr ct count over 5 } \
            counter reject
    }
}
EOF
ncat -lk4C 8080 -m 50 -c 'nvim --headless -n -u NONE -i NONE -s server.vim 2>/dev/null' --output server.log
