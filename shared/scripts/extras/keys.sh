#!/bin/bash

# Optional — interactive ssh and gpg key setup. Run after bootstrap when ready.

echo "Generating SSH key (interactive)..."
ssh-keygen

echo "Generating GPG key (interactive)..."
gpg --full-gen-key
