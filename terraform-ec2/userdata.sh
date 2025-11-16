#!/bin/bash
apt update -y
apt install apache2 -y
systemctl start apache2
systemctl enable apache2

echo "<h1>Ubuntu Server deployed via Terraform!</h1>" > /var/www/html/index.html
echo "<h2>Welcome to my website</h2>" >> /var/www/html/index.html
