#!/bin/bash

# Define Colors
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
CYAN='\e[36m'
NC='\e[0m' # No Color (resets the text attributes)

# Dowload the Package zip
echo "${CYAN}Downloading Terraform zip file.${NC}"
curl -o ~/terraform.zip https://releases.hashicorp.com/terraform/1.1.3/terraform_1.1.3_linux_amd64.zip 

# Make Terraform's directory
echo "${CYAN}Making Terraform Directory.${NC}"
mkdir -p ~/opt/terraform

# Check for the 'unzip' program
if command_exists unzip; then
  echo "${GREEN}unzip is installed. Proceeding with script.${NC}"
else
  echo "${YELLOW}Error: unzip is not installed${NC}" >&2
  echo "${GREEN}Installing Unzip${NC}"

  # Install
  sudo apt install unzip
fi

### AUTOMATE UPDATING .bashrc ###
# Setup Varriables for check
LINE='export PATH=$PATH:~/opt/terraform'
FILE="~/.bashrc"

# Check if the line is already present
if ! grep -Fxq "$LINE" "$FILE"; then
    echo "$LINE" >> "$FILE"
    echo "Path added to $FILE"
else
    echo "${GREEN}Path already exists in $FILE ${NC}"
fi
