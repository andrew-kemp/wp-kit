# WP-Kit: Automated WordPress Deployment & Recovery Kit

```
     _         _                        _           _  __        __            _ ____                    
    / \  _   _| |_ ___  _ __ ___   __ _| |_ ___  __| | \ \      / /__  _ __ __| |  _ \ _ __ ___  ___ ___ 
   / _ \| | | | __/ _ \| '_ ` _ \ / _` | __/ _ \/ _` |  \ \ /\ / / _ \| '__/ _` | |_) | '__/ _ \/ __/ __|
  / ___ \ |_| | || (_) | | | | | | (_| | ||  __/ (_| |   \ V  V / (_) | | | (_| |  __/| | |  __/\__ \__ \
 /_/   \_\__,_|\__\___/|_| |_| |_|\__,_|\__\___|\__,_|    \_/\_/ \___/|_|  \__,_|_|   |_|  \___||___/___/
                                                                                                         

  ____             _                                  _      ___     ____                                    
 |  _ \  ___ _ __ | | ___  _   _ _ __ ___   ___ _ __ | |_   ( _ )   |  _ \ ___  ___ _____   _____ _ __ _   _ 
 | | | |/ _ \ '_ \| |/ _ \| | | | '_ ` _ \ / _ \ '_ \| __|  / _ \/\ | |_) / _ \/ __/ _ \ \ / / _ \ '__| | | |
 | |_| |  __/ |_) | | (_) | |_| | | | | | |  __/ | | | |_  | (_>  < |  _ <  __/ (_| (_) \ V /  __/ |  | |_| |
 |____/ \___| .__/|_|\___/|_|\__, |_| |_| |_|\___|_| |_|\__|  \___/\/ |_| \_\___|\___\___/ \_/ \___|_|   \__, |
            |_|            |___/                                                                       |___/ 
```

WP-Kit is a modular, automated tool for deploying, backing up, and recovering self-hosted WordPress servers.  
It uses a single launcher script (`wp-kit.sh`) to bootstrap the environment, fetching the latest deployment and recovery logic from GitHub as needed.

## Features

- **Automated WordPress Deployment**: Interactive installer for new sites, multi-site support, SSL (Let's Encrypt, self-signed, custom certs).
- **Automated Backup**: Scheduled daily backups to Azure Blob Storage, including WordPress files, databases, configs, and SSL certificates. Email notifications.
- **Automated Recovery**: Restore full server or selected sites from Azure Blob backup. Recovers databases, configs, SSL, and sends recovery reports.
- **Self-updating Modules**: Only the launcher (`wp-kit.sh`) is needed; deploy and rescue logic are always downloaded fresh from GitHub.

---

## Quick Start

### 1. **Download the Launcher**

```bash
curl -O https://raw.githubusercontent.com/andrew-kemp/wp-kit/refs/heads/main/wp-kit.sh
chmod +x wp-kit.sh
```

### 2. **Run the Launcher**

```bash
sudo ./wp-kit.sh
```

- **Root privileges are required.**

---

## How it Works

1. **Interactive Menu**: Choose to deploy a new server/site or recover from backup.
2. **Bootstrap Modules**: If the required module scripts (`wp-deploykit.sh` or `wp-rescuekit.sh`) are missing, `wp-kit.sh` downloads them from GitHub.
3. **Deployment**: 
   - Installs server prerequisites (Apache, PHP, MariaDB, Certbot, etc.)
   - Sets up WordPress, MariaDB, Apache vhosts, SSL, and initial backup configuration.
   - Configures scheduled backups and email notifications.
4. **Recovery**:
   - Restores all/selected sites from Azure Blob backup.
   - Recovers databases, configs, SSL certs, and sends restore report.

---

## Scripts

- **wp-kit.sh**: Main launcher and menu.
- **wp-deploykit.sh**: Automated installer, multi-site setup, backup configuration.
- **wp-rescuekit.sh**: Automated recovery, selective site restore, config and SSL recovery.

All scripts are fetched automatically from:

```
https://raw.githubusercontent.com/andrew-kemp/wp-kit/refs/heads/main/
```

---

## Backup & Recovery Details

- **Backup Target**: Azure Blob Storage (SAS URL required)
- **Backup Contents**: 
  - WordPress files
  - MariaDB databases
  - Apache vhost config
  - SSL certificates
  - Global config files (Postfix, backup config)
- **Backup Reports**: Email notifications sent after each backup

- **Recovery Options**:
  - Recover all sites or select specific sites
  - Regenerate database user passwords
  - Update wp-config.php automatically
  - Restore Apache, SSL, and mail config

---

## Security & Best Practices

- **Run as root** (`sudo`) for full automation.
- **Scripts are always downloaded fresh** for up-to-date logic.
- **Sensitive credentials** (DB passwords, SMTP) are stored locally in secure config files.
- **Backups and restores are logged and emailed for auditability.**

---

## Troubleshooting

- If a module script fails to download, check your internet connection and GitHub repo permissions.
- For SSL issues, verify your cert paths and restart Apache.
- For backup/recovery failures, check `/etc/selfhostedwp/` and `/usr/local/bin/backup.sh` for logs/config.

---

## Updating

- **To update logic**, just update the scripts in your GitHub repo.
- Users only need to re-download `wp-kit.sh` to get the latest bootstrapper; modules are always auto-downloaded as needed.

---

## License

MIT

---

## Contributors

- [Andrew Kemp](https://github.com/andrew-kemp)

---

## Example Usage

```bash
curl -O https://raw.githubusercontent.com/andrew-kemp/wp-kit/refs/heads/main/wp-kit.sh
chmod +x wp-kit.sh
sudo ./wp-kit.sh
```

---

## FAQ

- **Q: Can I run this on any Linux server?**  
  A: Designed for Ubuntu, but may work on similar distributions with minor edits.

- **Q: Do I need to download all scripts manually?**  
  A: No. Only download `wp-kit.sh`; it will fetch the others as needed.

- **Q: How do I restore only one site?**  
  A: Use the recovery menu to select specific sites.

- **Q: How do I update the backup schedule?**  
  A: Rerun `wp-kit.sh` and reconfigure during the deploy/recover process.

---

## Advanced

- To customize modules, fork the repo and update the respective `wp-deploykit.sh` or `wp-rescuekit.sh` scripts.
- You can run `wp-deploykit.sh` or `wp-rescuekit.sh` directly as standalone scripts if needed.

---
