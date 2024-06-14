#!/bin/bash

# wget -P /tmp https://raw.githubusercontent.com/khaddict/homelab/main/scripts/post_deploy.sh && chmod +x /tmp/post_deploy.sh && apt install -y dos2unix && dos2unix /tmp/post_deploy.sh && /bin/bash /tmp/post_deploy.sh

DONE_MSG="DONE"
DOMAIN="homelab.lan"
SALTMASTER="saltmaster.homelab.lan"
DNS_SERVERS=(
    "192.168.0.203"
    "192.168.0.204"
    "192.168.0.254"
)
GATEWAY="192.168.0.254"
NETMASK="255.255.255.0"

echo "--- RESIZE DISK ---"
apt install -y parted
parted /dev/sda resizepart 1 100%
resize2fs /dev/sda1
echo $DONE_MSG

echo

echo "--- SET HOSTNAME ---"
echo -n "Which hostname you want for this virtual machine ? (not the FQDN) : "
read HOSTNAME
hostnamectl set-hostname "$HOSTNAME.$DOMAIN"
echo $DONE_MSG

echo

echo "--- SET NETWORK CONFIGURATION ---"
echo -n "Which IPv4 do you want as a static IP ? : "
read IP

FIRST_INTERFACE=$(ip -br a | grep UP | awk '{print $1}')

cat > /etc/network/interfaces <<EOF
# Generated by post_deploy.sh script

source /etc/network/interfaces.d/*

# The loopback network interface

auto lo
iface lo inet loopback

# The primary network interface

allow-hotplug $FIRST_INTERFACE
iface $FIRST_INTERFACE inet static
        address $IP
        netmask $NETMASK
        gateway $GATEWAY
EOF
echo $DONE_MSG

echo

echo "--- SET HOSTS CONFIGURATION ---"
cat > /etc/hosts <<EOF
# Generated by post_deploy.sh script

127.0.0.1       localhost.localdomain   localhost
$IP     $HOSTNAME.$DOMAIN       $HOSTNAME
EOF
echo $DONE_MSG

echo

echo "--- SET RESOLV CONFIGURATION ---"
echo -e "# Generated by post_deploy.sh script\n" > /etc/resolv.conf
for server in "${DNS_SERVERS[@]}"; do
    echo "nameserver $server" >> /etc/resolv.conf
done
echo $DONE_MSG

echo

echo "--- PREPARE SALT-MINION INSTALL ---"
DISTRO=$(cat /etc/os-release | grep ^ID= | awk -F= '{print $2}' | tr -d '"')
VERSION=$(cat /etc/os-release | grep ^VERSION_ID= | awk -F= '{print $2}' | tr -d '"')
VERSION_CODENAME=$(cat /etc/os-release | grep ^VERSION_CODENAME= | awk -F= '{print $2}' | tr -d '"')
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    ARCH="amd64"
elif [ "$ARCH" = "aarch64" ]; then
    ARCH="arm64"
fi
mkdir -p /etc/apt/keyrings
apt install curl
curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring-2023.gpg https://repo.saltproject.io/salt/py3/$DISTRO/$VERSION/$ARCH/SALT-PROJECT-GPG-PUBKEY-2023.gpg
echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=$ARCH] https://repo.saltproject.io/salt/py3/$DISTRO/$VERSION/$ARCH/latest $VERSION_CODENAME main" | tee /etc/apt/sources.list.d/salt.list
apt update
echo $DONE_MSG

echo

echo "--- INSTALL SALT-MINION ---"
apt install -y salt-minion
echo $DONE_MSG

echo

echo "--- WRITE /ETC/SALT/MINION ---"
echo "master: $SALTMASTER" > /etc/salt/minion
echo $DONE_MSG

echo

echo "--- WRITE /ETC/SALT/MINION_ID ---"
echo "$HOSTNAME.$DOMAIN" > /etc/salt/minion_id
echo $DONE_MSG

echo

echo "--- ENABLE AND START SALT-MINION SERVICE ---"
systemctl enable salt-minion && systemctl start salt-minion
echo $DONE_MSG

echo

echo "--- CREATE SSH-KEY ---"
ssh-keygen -t ed25519 -C "$HOSTNAME.$DOMAIN"
echo $DONE_MSG

echo

echo "--- MERGE REQUEST FOR GITHUB ---"
echo
SSH_PUBKEY=$(cat /root/.ssh/id_ed25519.pub)
echo "→ salt:/homelab/global/common/ssh/files/authorized_keys ←"
echo """
$SSH_PUBKEY
"""
echo "→ salt:/homelab/data/network_confs.yaml ←"
echo """
$HOSTNAME.$DOMAIN:
  main_iface: \"$FIRST_INTERFACE\"
  ip_addr: \"$IP\"
  netmask: \"$NETMASK\"
  gateway: \"$GATEWAY\"
"""
echo "→ salt:/homelab/role/pi-hole/files/custom.list ←"
echo """
$IP $HOSTNAME.$DOMAIN
"""
echo "→ If it's a new role, you also have to create salt:/homelab/role/<role_name> ←"

echo
