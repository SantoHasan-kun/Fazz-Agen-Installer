# Final system setup and installation
echo -n "Start Downloading System ... Tergantung pada kecepatan jaringan server Anda, ini mungkin memerlukan waktu beberapa saat... "

# Spinner function
spinner() {
  local pid=$!
  local delay=0.1
  local spinstr='|/-\'
  while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
    local temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
}

# Start download with spinner
wget -qq --timeout=15 --tries=5 -O /usr/bin/RCUpdate --no-check-certificate https://lic.hidekihoster.id/RCUpdate & spinner

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Completed!${NC}"
  chmod +x /usr/bin/RCUpdate
  if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to set execute permission on /usr/bin/RCUpdate.${NC}"
  fi
else
  echo -e "${RED}File Downloading gagal.${NC}"
fi

if [ ! -d /usr/local/RCBIN ]; then
  wget -O /usr/local/RCBIN.zip https://lic.hidekihoster.id/RCBIN.zip > /dev/null 2>&1
  unzip /usr/local/RCBIN.zip -d /usr/local/ > /dev/null 2>&1
fi
chmod +x /usr/bin/RCUpdate

if [ ! -d /usr/local/HidekiHoster/module ]; then
  mkdir -p /usr/local/HidekiHoster > /dev/null 2>&1
  wget -O /usr/local/HidekiHoster/module https://lic.hidekihoster.id/module > /dev/null 2>&1
  chmod +x /usr/local/HidekiHoster/module
fi

if [ "$1" != "" ]; then
  /usr/local/HidekiHoster/module $1 "$website"
fi

# Display ASCII Art at the end
if command -v figlet > /dev/null && command -v lolcat > /dev/null; then
  echo ""
  figlet "Fazz-Agen ID" | lolcat
else
  echo ""
  echo "===== Fazz-Agen ID ====="
fi
