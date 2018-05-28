#!/bin/bash

# Override xflock4 with our customized version
chmod 755 ~/.bin/xflock4
sudo ln -sf -t /usr/local/bin ~/.bin/xflock4

# Run lm_sensors setup
sudo sensors-detect --auto