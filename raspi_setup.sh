sudo apt update
sudo apt upgrade
sudo apt-get install python3-pip

#install mopidy
wget -q -O - https://apt.mopidy.com/mopidy.gpg | sudo apt-key add -
sudo wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/buster.list
sudo apt update
sudo apt install mopidy
sudo systemctl enable mopidy
sudo systemctl start mopidy

#install mopidy spotify
sudo apt install mopidy-spotify
#need to update /etc/mopdiy/mopdiy.conf 

#install mopidy party
sudo python3 -m pip install Mopidy-Party

#install iris
sudo python3 -m pip install Mopidy-Iris

#build and install snapcast
# sudo apt-get install git
# git clone https://github.com/badaix/snapcast.git
# sudo apt-get install build-essential
# sudo apt-get install libasound2-dev libpulse-dev libvorbisidec-dev libvorbis-dev libopus-dev libflac-dev libsoxr-dev alsa-utils libavahi-client-dev avahi-daemon libexpat1-dev libboost-all-dev
# cd snapcast/server
# make
# cd ..
# sudo make installserver
wget "https://github.com/badaix/snapcast/releases/download/v0.25.0/snapserver_0.25.0-1_armhf.deb"
wget "https://github.com/badaix/snapcast/releases/download/v0.25.0/snapclient_0.25.0-1_armhf.deb"
sudo apt install snapserver_0.25.0-1_armhf.deb
sudo apt install snapclient_0.25.0-1_armhf.deb

sudo bash multiple_mopidy.sh -H 192.168.20.47 -O snapcast -N 5 -v

#install nodered
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
sudo systemctl enable nodered.service
sudo systemctl start nodered.service

#install mosquitto
sudo apt install mosquitto

#install docker
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce-cli containerd.io docker-ce=5:19.03.13~3-0~raspbian-buster
sudo apt-mark hold docker-ce
#test with: sudo docker run hello-world need special version of docker for home assistant to work. V5:20 breaks HA

#install home assistant
sudo apt-get install -y software-properties-common apparmor-utils apt-transport-https ca-certificates curl dbus jq network-manager
sudo systemctl disable ModemManager
sudo systemctl stop ModemManager
sudo curl -sL "https://raw.githubusercontent.com/Kanga-Who/home-assistant/master/supervised-installer.sh" | sudo bash -s -- -m raspberrypi4

#install postgres
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
sudo apt -y install postgresql

#install mealie - TBC
#install firefly 3 - TBC

#install and configure ufw
sudo apt install ufw 

sudo ufw allow 6680:6685 #mopidy
sudo ufw allow 1780 #snapcast
sudo ufw allow 1883 #mosquitto
sudo ufw allow 1880 #nodered
sudo ufw allow 8123 #home assistant
sudo ufw allow 5432 #postgres
sudo ufw allow Apache #Apache
sudo ufw allow Openssh #SSH

sudo ufw enable


echo \
  "deb [arch=armhf signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/raspbian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null



17  sudo apt update
18  sudo apt-get install     apt-transport-https     ca-certificates     curl                                                                                                                                                                  gnupg     lsb-release
19  echo   "deb [arch=armhf signed-by=/usr/share/keyrings/docker-archive-keyr                                                                                                                                                             ing.gpg] https://download.docker.com/linux/debian \
20    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.li                                                                                                                                                             st > /dev/null
21  sudo apt update
22  sudo apt upgrade
23  sudo apt install docker-ce=5:19.03.13~3-0~raspbian-buster
24  sudo apt list -a docker-ce
25  sudo apt install docker-ce=5:19.03.13~3-0~debian-buster
26  systemctl status docker.service
27  sudo apt install docker-ce-cli=5:19.03.13~3-0~debian-buster
28  echo   "deb [arch=armhf signed-by=/usr/share/keyrings/docker-archive-keyr                                                                                                                                                             ing.gpg] https://download.docker.com/linux/raspbian \
29    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.li                                                                                                                                                             st > /dev/null
30  sudo apt list -a
31  sudo apt list -a docker-ce
32  cat /etc/os-release
33  lsb_release -cs
34  echo   "deb [arch=armhf signed-by=/usr/share/keyrings/docker-archive-keyr                                                                                                                                                             ing.gpg] https://download.docker.com/linux/raspbian \
35    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.li                                                                                                                                                             st > /dev/null
36  sudo apt list -a docker-ce
37  sudo apt install docker-ce=5:19.03.13~3-0~raspbian-buster docker-ce-cli=5                                                                                                                                                             :19.03.13~3-0~raspbian-buster containerd.io=1.3.9-1
38  journalctl -xe
39  pi@raspberrypi:~ $  curl -fsSL https://get.docker.com -o | sudo bash
40  curl -fsSL https://get.docker.com  | sudo bash
41  sudo dpkg --configure -a
42  systemctl stop docker.service
43  systemctl remove docker.service
44  sudo dpkg purge
45  sudo dpkg purge docker
46  sudo dpkg -configure -a
47  sudo dpkg --configure -a
48  sudo apt upgrade
49  curl -fsSL https://get.docker.com -o get-docker.sh
50  sudo init 1
51  sudo reboot
52  curl -fsSL https://get.docker.com -o get-docker.sh
53  sudo sh get-docker.sh
54  sudo apt update && sudo apt upgrade -VV
55  docker ps
56  sudo docker ps
57  sudo apt full-upgrade
58  sudo apt autoremove
59  sudo -i
60  history



sudo apt update
sudo apt upgrade
sudo reboot
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=armhf signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/raspbian \$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt install docker-ce=5:19.03.13~3-0~raspbian-buster
sudo apt install docker-ce-cli=5:19.03.13~3-0~raspbian-buster
sudo apt-get install containerd.io=1.3.9-1
sudo -i
apt-get install -y software-properties-common apparmor-utils apt-transport-https ca-certificates curl dbus jq network-manager
systemctl disable ModemManager
systemctl stop ModemManager
curl -sL "https://raw.githubusercontent.com/Kanga-Who/home-assistant/master/supervised-installer.sh"| bash -s -- -m raspberrypi4
