#!/bin/bash
systemctl status httpd
echo "$(curl localhost:80)"