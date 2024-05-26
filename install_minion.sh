echo "##### Download GPG key for SaltStack #####"
curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring-2023.gpg https://repo.saltproject.io/salt/py3/debian/12/amd64/SALT-PROJECT-GPG-PUBKEY-2023.gpg

echo "##### Create salt.list #####"
echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=amd64] https://repo.saltproject.io/salt/py3/debian/12/amd64/latest bookworm main" | sudo tee /etc/apt/sources.list.d/salt.list

echo "##### Update packages #####"
apt update

echo "##### Install salt-minion package #####"
apt install salt-minion

echo "##### Enable & start salt-minion service #####"
systemctl enable salt-minion && systemctl start salt-minion

echo "##### Write /etc/salt/minion config file #####"
echo "master: saltmaster.homelab.lan" > /etc/salt/minion
