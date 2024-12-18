#!/bin/bash
sudo yum install httpd -y
sudo systemctl enable --now httpd.service
sudo touch file123.txt