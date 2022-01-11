sudo apt update
sudo apt upgrade
sudo reboot

#install docker
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
 echo \
  "deb [arch=armhf signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/raspbian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt install docker-ce=5:19.03.13~3-0~raspbian-buster docker-ce-cli=5:19.03.13~3-0~raspbian-buster install containerd.io=1.3.9-1
sudo apt-mark hold docker-ce docker-ce-cli containerd.io
#test with: sudo docker run hello-world need special version of docker for home assistant to work. V5:20 breaks HA

#install home assistant
sudo apt-get install -y software-properties-common apparmor-utils apt-transport-https ca-certificates curl dbus jq network-manager
sudo systemctl disable ModemManager
sudo systemctl stop ModemManager
sudo curl -sL "https://raw.githubusercontent.com/Kanga-Who/home-assistant/master/supervised-installer.sh" | sudo bash -s -- -m raspberrypi4


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
sudo dpkg -i snapserver_0.25.0-1_armhf.deb
sudo dpkg -i snapclient_0.25.0-1_armhf.deb

wget "https://github.com/ESteanes/Mopidy_Multiple-Instances/releases/download/v0.1.0/multiple_mopidy.sh"
sudo bash multiple_mopidy.sh -H 192.168.20.47 -O snapcast -N 5 -v




#install postgres
sudo docker pull postgres
mkdir -p $HOME/docker/volumes/postgres
sudo docker run -d \
--restart unless-stopped \
--name pg-docker \
-e POSTGRES_PASSWORD=password \
-p 5432:5432 \
-v $HOME/docker/volumes/postgres:/var/lib/postgresql/data \
postgres
sudo apt install postgresql
psql -h localhost -U postgres -d postgres
#password is postgres
CREATE DATABASE firefly
CREATE USER firefly PASSWORD 'firefly_secret_password'

#install mealie - TBC
#install firefly 3 
--link=pg-docker \ #linking to the pg-docker container
-e DB_HOST=pg-docker \ #refers to the pg-docker instance

sudo docker run -d \
--link=pg-docker \
--restart unless-stopped \
-v firefly_iii_upload:/var/www/html/storage/upload \
-p 8080:8080 \
-e APP_KEY=D4kcvVMBjYTI5lKbZBwW5gDdvOFAkvr5 \
-e DB_HOST=pg-docker \
-e DB_PORT=5432 \
-e DB_CONNECTION=pgsql \
-e DB_DATABASE=firefly \
-e DB_USERNAME=firefly \
-e DB_PASSWORD=ellingtonsteanespersonalfinance \
fireflyiii/core:latest

docker run --rm \
-e FIREFLY_III_ACCESS_TOKEN=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI3IiwianRpIjoiZmVjNWQ4ZWU2ZDhlZTk4M2M4MmQ5YmVhNWEwYmE5MTg3MTk1MjgyOGNjOGNmYTkyY2M4NzM2NDc2ZjkyNTBlYmNhMzI0YmIyODYwNjQ0ZTIiLCJpYXQiOjE2MzAxNTIwNzcuOTI1NDY4LCJuYmYiOjE2MzAxNTIwNzcuOTI1NDg4LCJleHAiOjE2NjE2ODgwNzcuODU3ODcyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.2bVROBHiyxpXLwjuVq3I32ZyU9pgsgW1YGKnsPLk3IrNyQw_lN0_zpXthUN7npv6TuuZUUE3NN9jV1CCGsMOxMTSfpsjYBNx3ZTCo8Q5udOTYFuKkNQkbDWKBYACc-4qE2vu-FGjHdpIUMewntv1GeT-qlEoYbHcJX-MvWMS2EXtm7KWhtUmb7s4hu6Tb7ljZuV3nHcwSx1wElHtf7d1JSyGGiKr2FgExGKxizXizUZC3f-5h2TDcoORP3MxdxtSU2O4s_qscwDpwf3wIIBprwr2KG2eLKT8bBNNjlJVFNxBoIN6QloqYXPVeRP658zgobffJqGxQz3N6ZYdCuNxMg5RlpeW6NFxusM64CW2PqFM38ZmGv4S0OIH72eb-iZ_9hGoROm-Aes5fAZLlZPhvbYSSjB3RsmxvwzzqakQW_rWa8XxF9-ekqzIOIz8wamha86_xY1YFvs6Gb9iPDoHd17BSd-dUu_tLyDil6rsLqu7RS7U-QP1wllDwWlRJ3Tk9ryRQkNlZvQuTqKUylWNw3WpXTpzCEznuWcm84dq9yykcvfM6Fu3pOb19LkG3HT9FCufkNZTbyEyznL3sA3WLinXtOoxbN2YGvH_9Iv-_654yGZITkj62fsywy9D2hA6Plom-BmLnvR8ypQNV9egFN2WUMFbTANL5kqioZLpkjY \
-e FIREFLY_III_URL=172.17.0.4:8080 \
-p 8082:8080 \
fireflyiii/csv-importer:latest


#install nodered - maybe not needed (inside of Home Assistant)
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
sudo systemctl enable nodered.service
sudo systemctl start nodered.service

#install mosquitto (inside of Home Assistant)
sudo apt install mosquitto

#install and configure ufw
sudo apt install ufw 

sudo ufw allow 6680:6685/tcp #mopidy
sudo ufw allow 1780,1704,1705 #snapcast
sudo ufw allow 1883 #mosquitto
sudo ufw allow 1880 #nodered
sudo ufw allow 8123 #home assistant
sudo ufw allow 5432 #postgres
sudo ufw allow Apache #Apache
sudo ufw allow Openssh #SSH

sudo ufw enable


#setting up home assistant
#install mqtt and opwenweathermap integration
#copy across automations.yaml, sensor.yaml, and optionally config.yaml (could be issues if not everything installed yet)
#sensor.yaml:
- platform: template
  sensors:
    rainy_day:
      unique_id: "93a71543-d6a4-40d8-9d01-ccc18b17d42a"
      friendly_name: "Rainy in next 48 Hours"
      value_template: >
        {% set p0 = state_attr('weather.openweathermap', 'forecast')[0].precipitation != None %}
        {% set p1 = state_attr('weather.openweathermap', 'forecast')[1].precipitation != None %}
        {{ 'true' if p0 or p1 else 'false' }}
#automations.yaml:
- id: '1615674689748'
  alias: Watering System
  description: Automated script to run watering system if it isnt raining
  trigger:
  - platform: time
    at: '6:00'
  condition:
  - condition: state
    entity_id: sensor.rainy_day
    state: 'false'
  action:
  - type: turn_on
    device_id: 494f096d2e9f4dab0519bbf913640c3a
    entity_id: switch.solenoid3
    domain: switch
  - delay:
      hours: 0
      minutes: 0
      seconds: 5
      milliseconds: 0
  - type: turn_on
    device_id: 494f096d2e9f4dab0519bbf913640c3a
    entity_id: switch.solenoid2
    domain: switch
  - delay:
      hours: 0
      minutes: 0
      seconds: 5
      milliseconds: 0
  - type: turn_on
    device_id: 494f096d2e9f4dab0519bbf913640c3a
    entity_id: switch.solenoid1
    domain: switch
  - delay:
      hours: 0
      minutes: 10
      seconds: 0
      milliseconds: 0
  - type: turn_off
    device_id: 494f096d2e9f4dab0519bbf913640c3a
    entity_id: switch.solenoid3
    domain: switch
  - type: turn_off
    device_id: 494f096d2e9f4dab0519bbf913640c3a
    entity_id: switch.solenoid2
    domain: switch
  - type: turn_off
    device_id: 494f096d2e9f4dab0519bbf913640c3a
    entity_id: switch.solenoid1
    domain: switch
  mode: single

#put automations & sensor.yaml into /usr/share/hassio/homeassistant/
#set up Openweathermap weather API

#snapcast clients
#sudo systemctl restart snapclient.service for all machines



docker run -d \
    -v ./staticfiles:/opt/recipes/staticfiles \
    -v ./mediafiles:/opt/recipes/mediafiles \
    --link=pg-docker \
    -p 8081:8080 \
    -e SECRET_KEY=YOUR_SECRET_KEY \
    -e DB_ENGINE=django.db.backends.postgresql \
    -e POSTGRES_HOST=pg-docker \
    -e POSTGRES_PORT=5432 \
    -e POSTGRES_USER=tandoor \
    -e POSTGRES_PASSWORD=tandoor_password \
    -e POSTGRES_DB=tandoor \
    --name recipes_1 \
    vabene1111/recipes