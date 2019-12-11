
# Install vscode
curl -L https://go.microsoft.com/fwlink/?LinkID=760868 > code.deb
sudo apt-get install libxss1 libasound2 ./code.deb -y
rm -fr code.deb
