#!/bin/bash
 
# Define loading animation function
function loading () {
    local pid=$1
    local delay=0.25
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Update package manager with loading animation
echo "Updating package manager..."
sudo apt-get update &
loading $! 

# Install required packages with loading animation
echo "Installing required packages..."
sudo apt-get install ca-certificates curl gnupg -y &
loading $!

# Install Docker GPG key with loading animation
echo "Installing Docker GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings &
loading $!
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg &
loading $!
sudo chmod a+r /etc/apt/keyrings/docker.gpg 

# Add Docker repository with loading animation
echo "Adding Docker repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null &
loading $!

# Update package manager again with loading animation
echo "Updating package manager again..."
sudo apt-get update &
loading $!

# Install Docker and dependencies with loading animation
echo "Installing Docker and dependencies..."
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y &
loading $!

echo "Done!"

