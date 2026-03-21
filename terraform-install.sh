#!/bin/bash

# Define Colors
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
CYAN='\e[36m'
NC='\e[0m' # No Color (resets the text attributes) 

# Use $HOME instead of ~ for better reliability in scripts
TERRAFORM_DIR="$HOME/opt/terraform"
BASHRC="$HOME/.bashrc"

# Dowload the Package zip
echo "${CYAN}Downloading Terraform zip file...${NC}"
curl -o ~/terraform.zip https://releases.hashicorp.com/terraform/1.1.3/terraform_1.1.3_linux_amd64.zip 

# Make Terraform's directory
echo "${CYAN}Making Terraform Directory...${NC}"
mkdir -p ~/opt/terraform

# Check for the 'unzip' program
if command -v unzip  >/dev/null 2>&1; then
  echo "${GREEN}unzip is installed. Proceeding with script...${NC}"
else
  echo "${YELLOW}Error: unzip is not installed...${NC}" >&2
  echo "${GREEN}Installing Unzip...${NC}"

  # Install
  sudo apt update && sudo apt install -y unzip
fi

### AUTOMATE UPDATING .bashrc ###
# Setup Varriables for check
LINE="export PATH=$PATH:$TERRAFORM_DIR"

# Check if the line is already present
# Add it in if necessary
if ! grep -Fxq "$LINE" "$BASHRC"; then
    echo "${CYAN}Adding file path $BASHRC...${NC}"
    echo "$LINE" >> "$BASHRC"
    echo "${GREEN}Path added to $BASHRC${NC}"
else
    echo "${CYAN}Path already exists in $BASHRC, Exiting...${NC}"
fi

echo "${GREEN}Terraform installation complete!${NC}"
