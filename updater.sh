RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[0;36m'
NOCOLOR='\033[0m'
TITLE='\033[0;33m'
GIT='\033[1;35m'
echo "Auto-Updater"

if [ "$EUID" -ne 0 ]
  then echo -e "${TITLE}Preliminary Check Failed: ${RED}PLEASE RUN AS ROOT ${NOCOLOR}"
  exit
fi
echo -e "${TITLE}Preliminary Check: ${GREEN}Successful${NOCOLOR}"
echo -e "${TITLE}Phase Zero: ${GREEN}Setting-Up Auto Updater ${NOCOLOR}"
echo -e "${CYAN}Establishing connection with ${GREEN}www.anirudhrath.tech${NOCOLOR}"
cd /usr/local/sbin/
echo -e "${GREEN} Setting up script to run with Startup${NOCOLOR}"
wget https://www.anirudhrath.tech/hostFiles/updater.sh

echo -e "${GREEN}Setting up updater script as a Service${NOCOLOR}"
cd /etc/systemd/system/
wget https://www.anirudhrath.tech/hostFiles/updater.service

echo Enabling updater.service
sudo systemctl enable updater.service

echo -e "${TITLE}Phase One: ${GREEN}Pre-Configuring Packages${NOCOLOR}"
sudo dpkg --configure -a

echo

echo -e "${TITLE}Phase Two: ${GREEN}Fix & Attempt Broken Dependencies${NOCOLOR}"
sudo apt-get install -f

echo

echo -e "${TITLE}Phase Three: ${GREEN}Update Cache${NOCOLOR}"
sudo apt update -y

echo

echo -e "${TITLE}Phase Four: ${GREEN}Upgrade Packages${NOCOLOR}"
sudo apt upgrade -y

echo

echo -e "${TITLE}Phase Five: ${GREEN}Upgrade Distro${NOCOLOR}"
sudo apt dist-upgrade -y

echo

echo -e "${TITLE}Phase Six: ${GREEN}Uninstall Unused Packages${NOCOLOR}"
sudo apt --purge autoremove -y

echo

echo -e "${TITLE}Phase Seven: ${GREEN}Clean Up${NOCOLOR}"
sudo apt autoclean -y

echo

${GREEN}

echo Complete
