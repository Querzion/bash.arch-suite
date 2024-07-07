# Install ani-cli (Anilist command-line interface)
echo "Installing ani-cli (Anilist command-line interface)..."
git clone https://github.com/erengy/ani-cli ~/ani-cli
cd ~/ani-cli
sudo make
sudo make install

echo "ani-cli installed successfully."
