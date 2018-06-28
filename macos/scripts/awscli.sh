#!/bin/sh

# Install the AWS CLI Using the Bundled Installer
# https://docs.aws.amazon.com/cli/latest/userguide/cli-install-macos.html#install-bundle-macos

curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
rm -fr awscli-bundle
