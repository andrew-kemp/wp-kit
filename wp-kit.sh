#!/usr/bin/env bash
set -Eeuo pipefail
clear

# --- Root Privilege Check ---
require_root() {
  if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root. Try: sudo bash $0" >&2
    exit 1
  fi
}
require_root

# --- Main Banner ---
cat <<'EOF'
     _         _                        _           _  __        __            _ ____                    
    / \  _   _| |_ ___  _ __ ___   __ _| |_ ___  __| | \ \      / /__  _ __ __| |  _ \ _ __ ___  ___ ___ 
   / _ \| | | | __/ _ \| '_ ` _ \ / _` | __/ _ \/ _` |  \ \ /\ / / _ \| '__/ _` | |_) | '__/ _ \/ __/ __|
  / ___ \ |_| | || (_) | | | | | | (_| | ||  __/ (_| |   \ V  V / (_) | | | (_| |  __/| | |  __/\__ \__ \
 /_/   \_\__,_|\__\___/|_| |_| |_|\__,_|\__\___|\__,_|    \_/\_/ \___/|_|  \__,_|_|   |_|  \___||___/___/
                                                                                                         

  ____             _                                  _      ___     ____                                    
 |  _ \  ___ _ __ | | ___  _   _ _ __ ___   ___ _ __ | |_   ( _ )   |  _ \ ___  ___ _____   _____ _ __ _   _ 
 | | | |/ _ \ '_ \| |/ _ \| | | | '_ ` _ \ / _ \ '_ \| __|  / _ \/\ | |_) / _ \/ __/ _ \ \ / / _ \ '__| | | |
 | |_| |  __/ |_) | | (_) | |_| | | | | | |  __/ | | | |_  | (_>  < |  _ <  __/ (_| (_) \ V /  __/ |  | |_| |
 |____/ \___| .__/|_|\___/ \__, |_| |_| |_|\___|_| |_|\__|  \___/\/ |_| \_\___|\___\___/ \_/ \___|_|   \__, |
            |_|            |___/                                                                       |___/ 

                                Automated WordPress Deployment & Recovery Kit
EOF

echo

echo
echo "Please choose an option below:"
echo "  1. WP DeployKit  - Install and configure WordPress on a new server or add additional sites to an existing server"
echo "  2. WP RescueKit  - Recover your server from the latest backup"
echo

# --- Script URLs ---
BASE_URL="https://raw.githubusercontent.com/andrew-kemp/wp-kit/refs/heads/main"
DEPLOY_SCRIPT="wp-deploykit.sh"
RESCUE_SCRIPT="wp-rescuekit.sh"

# --- Download function ---
download_script() {
  local script_name="$1"
  local url="${BASE_URL}/${script_name}"
  if [[ ! -f "$script_name" ]]; then
    echo "Downloading $script_name from $url ..."
    curl -fsSL -o "$script_name" "$url"
    chmod +x "$script_name"
  fi
}

# --- Main Menu ---
while true; do
  read -p "Enter your choice [1/2]: " USER_CHOICE
  case "$USER_CHOICE" in
    1)
      clear
      cat <<'DEPLOY'
 __        ______    ____             _             _  ___ _   
 \ \      / /  _ \  |  _ \  ___ _ __ | | ___  _   _| |/ (_) |_ 
  \ \ /\ / /| |_) | | | | |/ _ \ '_ \| |/ _ \| | | | ' /| | __|
   \ V  V / |  __/  | |_| |  __/ |_) | | (_) | |_| | . \| | |_ 
    \_/\_/  |_|     |____/ \___| .__/|_|\___/ \__, |_|\_\_|\__|
                               |_|            |___/            

        Automated WordPress Installer & Backup

DEPLOY
      download_script "$DEPLOY_SCRIPT"
      ./"$DEPLOY_SCRIPT"
      break
      ;;
    2)
      clear
      cat <<'RESCUE'
 __        ______    ____                           _  ___ _   
 \ \      / /  _ \  |  _ \ ___  ___  ___ _   _  ___| |/ (_) |_ 
  \ \ /\ / /| |_) | | |_) / _ \/ __|/ __| | | |/ _ \ ' /| | __|
   \ V  V / |  __/  |  _ <  __/\__ \ (__| |_| |  __/ . \| | |_ 
    \_/\_/  |_|     |_| \_\___||___/\___|\__,_|\___|_|\_\_|\__|
                                                               

        Automated WordPress Recovery & Restore        

RESCUE
      download_script "$RESCUE_SCRIPT"
      ./"$RESCUE_SCRIPT"
      break
      ;;
    *)
      echo "Invalid choice. Please enter 1 or 2."
      ;;
  esac
done
