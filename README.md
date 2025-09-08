# DZONES

🔎 AXFR Misconfiguration Scanner

A fast Bash-based tool to scan domains for DNS Zone Transfer (AXFR) misconfigurations.
Zone transfers should only be allowed between trusted DNS servers. If misconfigured, attackers can download the entire DNS zone (subdomains, internal records, IPs, etc.).

🚀 Features

Cleans and normalizes domain input (removes http(s)://, ports, paths, usernames).

Resolves authoritative nameservers (NS) automatically.

Attempts zone transfers (AXFR) against each NS.

Runs scans in parallel (default: 10 jobs).

Saves vulnerable results in axfr_results/.

Creates a PoC command file for easy reproduction.

Lightweight: requires only bash, dig, and xargs.

📦 Requirements

Linux / macOS

dig (from dnsutils or bind-utils)

xargs (usually part of GNU coreutils)

Install on Debian/Ubuntu:

sudo apt update && sudo apt install dnsutils -y


Install on RedHat/CentOS:

sudo yum install bind-utils -y

⚙️ Usage
git clone https://github.com/<your-username>/axfr-scanner.git
cd axfr-scanner
chmod +x axfr_scanner.sh

Run the scanner:
./axfr_scanner.sh domains.txt [parallel_jobs]


domains.txt → file with list of domains

[parallel_jobs] → optional, default = 10

Example:

./axfr_scanner.sh domains.txt 20

📝 Example Output
example.com : Not Vulnerable
test.com : Vulnerable


If vulnerable → full zone transfer is saved in:

axfr_results/test.com_zone_ns1.test.com.txt


A PoC reference is saved in:

axfr_results/vulnerable_poc.txt


Example vulnerable_poc.txt:

Domain: test.com | NS: ns1.test.com | PoC: dig axfr @ns1.test.com test.com

⚠️ Disclaimer

This tool is for educational and authorized security testing only.
Do not use against domains you don’t own or have explicit permission to test.
Misuse may violate laws and could result in severe penalties.

👨‍💻 Author

Your Name

GitHub: @yourusername

Twitter/LinkedIn (optional)

👉 Do you want me to also make a nice badge-style README (with shields like “Built with Bash”, “License MIT”, etc.) so it looks more professional on GitHub?

You said:
make only for ubumntu and kali linux
ChatGPT said:

Got it ✅ You want the README tailored only for Ubuntu & Kali Linux users, since those are the most common for security testing.
Here’s a clean and focused version of the README for your GitHub repo:

🔎 AXFR Misconfiguration Scanner

A fast Bash-based tool to scan domains for DNS Zone Transfer (AXFR) misconfigurations.

Zone transfers should only be allowed between trusted DNS servers. If misconfigured, attackers can download the entire DNS zone (subdomains, internal records, IPs, etc.).

🚀 Features

Cleans and normalizes domain input (removes http(s)://, ports, paths, usernames).

Automatically finds authoritative nameservers (NS).

Attempts zone transfers (AXFR) against each NS.

Runs scans in parallel (default: 10 jobs).

Saves vulnerable results in axfr_results/.

Generates PoC commands for easy reproduction.

📦 Installation (Ubuntu / Kali Linux)

Make sure you have dig and xargs installed.

sudo apt update && sudo apt install dnsutils -y


Clone the repo and make the script executable:

git clone https://github.com/<your-username>/axfr-scanner.git
cd axfr-scanner
chmod +x axfr_scanner.sh

⚙️ Usage
./axfr_scanner.sh domains.txt [parallel_jobs]


domains.txt → file containing list of domains (one per line)

[parallel_jobs] → optional, number of parallel checks (default = 10)

Example:

./axfr_scanner.sh domains.txt 20

📝 Example Output
example.com : Not Vulnerable
target.com : Vulnerable


Vulnerable domain zone dump saved in:

axfr_results/target.com_zone_ns1.target.com.txt


PoC command saved in:

axfr_results/vulnerable_poc.txt


Example vulnerable_poc.txt:

Domain: target.com | NS: ns1.target.com | PoC: dig axfr @ns1.target.com target.com

⚠️ Disclaimer

This tool is for educational and authorized security testing only.
Do not scan domains you don’t own or have explicit permission to test.
Unauthorized use may violate the law.

👨‍💻 Author

Your Name

GitHub: @yourusername
