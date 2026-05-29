#!/bin/bash

# SSM Agent インストール
sudo dnf install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm

# Session Manager プラグイン インストール
sudo dnf install -y https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm

# psql コマンドインストール
sudo dnf install -y postgresql15
