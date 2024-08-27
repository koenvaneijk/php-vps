#!/bin/bash

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo -e "${GREEN}Welcome to the PHP Hosting with Automatic HTTPS setup wizard!${NC}"

# DNS and Cloudflare token setup instructions
echo -e "\n${YELLOW}Before we begin, please complete the following steps:${NC}"

echo -e "\n1. Create a Cloudflare API token:"
echo -e "   a. Log in to your Cloudflare account and go to 'My Profile' > 'API Tokens'"
echo -e "   b. Click 'Create Token' and use the 'Edit zone DNS' template"
echo -e "   c. Under 'Zone Resources', select 'Include' > 'Specific zone' > your domain"
echo -e "   d. Complete the token creation and copy the generated token"

echo -e "\n2. Set up DNS records for your domain(s) in your Cloudflare dashboard:"
echo -e "   For each domain, create the following DNS records:"
echo -e "   a. An 'A' record for @ (root domain) pointing to your server's IP address"
echo -e "   b. An 'A' record for * (wildcard) pointing to your server's IP address"
echo -e "\n   Example:"
echo -e "   Type  Name  Content"
echo -e "   A     @     your_server_ip"
echo -e "   A     *     your_server_ip"
echo -e "\n   Replace 'your_server_ip' with the actual IP address of this server."
echo -e "   Ensure that the proxy status (orange cloud icon) is turned on for both records."

echo -e "\n${YELLOW}Press Enter when you have completed these steps to continue...${NC}"
read -p ""

# Check and install Docker if needed
if ! command_exists docker; then
    echo -e "${YELLOW}Docker is not installed. Installing Docker...${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    
    # Reload group configuration
    exec sudo su -l $USER
fi

# Set up .env file
echo -e "${YELLOW}Setting up .env file...${NC}"
read -p "Enter your Cloudflare API token: " cf_token
read -p "Enter your domain(s) separated by commas (e.g., example.com,example.net): " domains

echo "CLOUDFLARE_API_TOKEN=$cf_token" > .env
echo "DOMAINS=$domains" >> .env

echo -e "${GREEN}.env file created successfully.${NC}"

# Create necessary directories
mkdir -p sites caddy_data caddy_config

# Start the containers
echo -e "${YELLOW}Starting the containers...${NC}"
docker compose up -d

echo -e "${GREEN}Setup complete! Your PHP hosting environment is now running.${NC}"
echo -e "You can add your PHP files to the 'sites' directory."
echo -e "To add a new site, create a new directory in 'sites' with your domain name and add your PHP files to the 'public' subdirectory."