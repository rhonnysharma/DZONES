#!/bin/bash

# Usage: ./axfr_scanner.sh domains.txt [parallel_jobs]

INPUT_FILE=$1
PARALLEL=${2:-10}   # default = 10 parallel jobs
RESULT_DIR="axfr_results"
mkdir -p "$RESULT_DIR"

# 🧹 Clean input file: remove http(s), paths, usernames, ports, etc.
CLEANED_FILE="cleaned_domains.txt"
cat "$INPUT_FILE" \
  | sed -E 's#https?://##g; s#/.*##g; s/.*@//; s/:[0-9]+//g' \
  | sort -u > "$CLEANED_FILE"

check_domain() {
    domain="$1"

    # Get nameservers
    ns_records=$(dig ns "$domain" +short)

    if [[ -z "$ns_records" ]]; then
        echo "$domain : Not Vulnerable / No NS found"
        return
    fi

    vulnerable=0
    for ns in $ns_records; do
        ns_clean=$(echo "$ns" | sed 's/\.$//')
        # Faster timeout + single try
        result=$(dig axfr @"$ns_clean" "$domain" +time=2 +tries=1 2>&1)

        if echo "$result" | grep -q "XFR size"; then
            echo "$domain : Vulnerable"
            echo "$result" > "$RESULT_DIR/${domain}_zone_${ns_clean}.txt"
            echo "Domain: $domain | NS: $ns_clean | PoC: dig axfr @$ns_clean $domain" >> "$RESULT_DIR/vulnerable_poc.txt"
            vulnerable=1
            break
        fi
    done

    if [[ $vulnerable -eq 0 ]]; then
        echo "$domain : Not Vulnerable"
    fi
}

export -f check_domain
export RESULT_DIR

# 🚀 Run in parallel
cat "$CLEANED_FILE" | xargs -n1 -P"$PARALLEL" bash -c 'check_domain "$@"' _
