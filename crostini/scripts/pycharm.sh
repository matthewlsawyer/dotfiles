
# Install pycharm community
curl -L https://download-cf.jetbrains.com/python/pycharm-community-2019.3.tar.gz > pycharm.tar.gz
sudo tar xf pycharm.tar.gz -C /opt/

# 1. File->Settings->Plugins.
# 1. Click marketplace, search for "Choose Runtime"
# 1. Install official Choose Runtime addon from JetBrains
# 1. Wait for install and click to restart IDE
# 1. Once back in project, press shift twice to open the search window
# 1. Search for Runtime. Select "Choose Runtime"
# 1. Change to "jbrsdk-8u-232-linux-x64-b1638.6.tar.gz", which should be the very last one at the bottom of the list.
# 1. Click install, restart IDE, enjoy!
