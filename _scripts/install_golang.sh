set -ex

# Download
curl -LO https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz

# Save binary to /usr/local
sudo tar -C /usr/local -xzf go1.13.4.linux-amd64.tar.gz

# Remove
rm go1.13.4.linux-amd64.tar.gz

# Add to path
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
