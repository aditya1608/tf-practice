#!/bin/bash

#install apache
sudo yum install httpd -y

#enable and start apache
sudo systemctl enable --now httpd
sudo systemctl start httpd