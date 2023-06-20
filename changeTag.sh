#!/bin/bash

# Define color variables
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check xclip install or not
if ! command -v xclip &> /dev/null
then
    printf "${RED}xclip command not found.${NC}\n"
    printf "${GREEN}Installing xclip...${NC}\n"
    sudo apt-get update
    sudo apt-get install -y xclip
    printf "${GREEN}xclip installed successfully.${NC}\n"
else
    printf "${GREEN}xclip command is already installed.${NC}\n"
fi

echo ""
# Prompt the user for the Docker image URL
read -p "$(echo -e "${YELLOW}Enter the Docker image URL:${NC} ")" docker_url

echo ""
# Replace the hostname in the Docker image URL with "docker.mobintadbir.ir"
new_docker_url=$(echo $docker_url | sed "s/[^/]*\//docker.mobintadbir.ir\//")

# Print the original and new Docker image URLs in color
echo -e "${GREEN}Original Docker image URL:${NC} $docker_url"
echo -e "${GREEN}New Docker image URL:${NC} $new_docker_url"

# Add to you'r clip-board
echo -n "$new_docker_url" | xclip -selection clipboard

# SSH into the server using the hostname
read -p "Enter the SSH hostname: " ssh_hostname
$ssh_hostname 'docker_url="$docker_url"; new_docker_url="$new_docker_url"; echo -e "docker pull $docker_url\ndocker tag $docker_url $new_docker_url\ndocker push $new_docker_url"'



# # Pull the original Docker image
# printf "${GREEN}Pulling image...${NC}\n"
# docker pull $docker_url

# # Tag the new Docker image
# printf "${GREEN}Tag Image: $docker_url | to Image:$new_docker_url${NC}\n"
# docker tag $docker_url $new_docker_url

# # Push the new Docker image
# printf "${GREEN}Pushing Image:$new_docker_url${NC}\n"
# docker push $new_docker_url


