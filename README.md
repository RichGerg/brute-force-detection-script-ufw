# 🔐 SSH Brute Force Blocker with UFW

A lightweight Bash script to detect and block SSH brute force attacks by parsing failed login attempts in the system authentication log. Suspicious IP addresses with repeated failed logins are automatically blocked using UFW (Uncomplicated Firewall).

---

## 📌 Objective

Enhance system security by identifying and blocking IP addresses involved in brute force attacks targeting the SSH service.

---

## 🛠️ Tools & Technologies

- Bash
- Linux (Debian-based)
- SSH
- Log Parsing (`auth.log`)
- UFW (Uncomplicated Firewall)
- awk

---

## 📖 Overview

This script monitors the system's `auth.log` file for repeated failed SSH login attempts. It extracts the offending IP addresses, counts the number of attempts per IP, and blocks those with **10 or more** failed login attempts using UFW.

> Inspired by a final project in cybersecurity training, this tool was built to serve as a proactive and transparent mitigation layer against brute force login attempts.

---

## ⚙️ How It Works

1. Parses `/var/log/auth.log` (or custom path) for lines containing:
   - A valid timestamp
   - The string `Failed password`
   - An IPv4 address

2. Counts occurrences of each offending IP address.

3. Filters IPs with **10 or more failed attempts**.

4. Blocks those IPs by inserting a `deny` rule at the top of the UFW firewall.

---

## 🧪 Sample Output

```bash
Blocking the following IP addresses with UFW:
192.168.1.25
203.0.113.42
```

---

## 🧠 Challenges & Lessons Learned

One key challenge was distinguishing between legitimate login errors and malicious brute force activity. By requiring 10 or more attempts from the same IP within the log file, the script avoids false positives while catching automated attack behavior.

This project also provided valuable hands-on experience with:

Real-time log monitoring

Pattern matching with awk

Defensive automation using Linux-native tooling

---

## 📂 Usage

Clone or copy the script into your Linux environment.

Update the log_file path if necessary (default: /var/log/auth.log).

Run the script as root or with sudo.

bash
Copy
Edit
sudo bash ssh-brute-blocker.sh
💡 Note: You must have UFW installed and active for the script to work.

---

## 🔑 Security Note

This script only targets brute force SSH login attempts found in auth.log. To defend against broader attack types (e.g., web app exploits, FTP brute force), consider extending this concept or implementing a modular system like Fail2Ban.

---

## 📄 License

This project is open source under the [MIT License](LICENSE).

---

## ✉️ Credits

Created by RichGerg - built as a lightweight a lightweight Bash script to detect and block SSH brute force attacks by parsing failed login attempts.
