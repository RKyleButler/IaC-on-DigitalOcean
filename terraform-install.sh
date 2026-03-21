#!/bin/bash
set -e  # Ensures the script stops and triggers the trap on any error

# Define Colors
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
CYAN='\e[36m'
NC='\e[0m' # No Color (resets the text attributes) 

# Variables for better reliability
TERRAFORM_DIR="$HOME/opt/terraform"
BASHRC="$HOME/.bashrc"
ZIP_FILE="$HOME/terraform.zip"

# 2. Error Handler Function
failure() {
  echo -e "\n${RED}ERROR: Installation failed at line $1.${NC}" >&2
  exit 1
}

# 3. Traps: Run failure function on error, and cleanup on exit
trap 'failure $LINENO' ERR
trap 'rm -f "$ZIP_FILE"' EXIT

# Dowload the Package zip
echo -e "${CYAN}Downloading Terraform zip file...${NC}"
curl -fLo ~/terraform.zip https://releases.hashicorp.com/terraform/1.1.3/terraform_1.1.3_linux_amd64.zip 

# Make Terraform's directory
echo -e "${CYAN}Making Terraform Directory...${NC}"
mkdir -p $TERRAFORM_DIR

# Check for the 'unzip' program
if command -v unzip  >/dev/null 2>&1; then
  echo -e "${GREEN}unzip is installed. Proceeding with script...${NC}"
else
  echo -e "${YELLOW}Error: unzip is not installed...${NC}" >&2
  echo -e "${GREEN}Installing Unzip...${NC}"

  # Install
  sudo apt update && sudo apt install -y unzip
fi

#Unzip the terraform directory
echo -e "${CYAN}Unzipping Terraform to $TERRAFORM_DIR...${NC}"
unzip -o $ZIP_FILE -d $TERRAFORM_DIR

### AUTOMATE UPDATING .bashrc ###
# Setup Varriables for check
LINE="export PATH=\$PATH:$TERRAFORM_DIR"

# Check if the line is already present
# Add it in if necessary
if ! grep -Fxq "$LINE" "$BASHRC"; then
    echo -e "${CYAN}Adding file path $BASHRC...${NC}"
    echo "$LINE" >> "$BASHRC"
    echo -e "${GREEN}Path added to $BASHRC${NC}"
else
    echo -e "${CYAN}Path already exists in $BASHRC, Exiting...${NC}"
fi

# Cleanup - Remove the zip file to keep the home directory clean
echo -e "${CYAN}Cleaning up zip file...${NC}"
rm "$ZIP_FILE"

# VERIFICATION
echo -e "${YELLOW}Verifying installation...${NC}"
# Use the full path for the check since the current shell hasn't sourced .bashrc yet
"$TERRAFORM_DIR/terraform" --version

echo -e "${GREEN}Terraform installation complete!${NC}"
echo -e "${YELLOW}Note: Run 'source ~/.bashrc' in your terminal to start using 'terraform' globally.${NC}"
