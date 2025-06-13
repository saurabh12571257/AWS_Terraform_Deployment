#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y nginx

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Check if Nginx is running
if systemctl is-active --quiet nginx; then
    echo "<h1>Nginx is running.</h1>" | sudo tee /var/www/html/index.html
else
    echo "<h1>Nginx failed to start.</h1>" | sudo tee /var/www/html/index.html
fi