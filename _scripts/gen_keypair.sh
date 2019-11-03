set -ex

# Check if key already exists
if [ -f "$HOME/.ssh/id_rsa" ]; then
	echo "SSH Key already exists. Nothing to do."
	echo "Here is your existing key, if you need it:"
	cat ~/.ssh/id_rsa.pub
	exit 0
fi

# Generate the key
ssh-keygen -t rsa -b 4096 -C "alexander.richey@gmail.com"

# Add it to the agent
ssh-add ~/.ssh/id_rsa

# Print the public key
echo "Copy this to GitHub:\n\n"
cat ~/.ssh/id_rsa.pub
