# SRS Install - Non Containerized - For a Containerized K8s Version goto k8s dir of this repo. 

### Install UHD Driver
`sudo apt install -y libboost-all-dev libusb-1.0-0-dev doxygen python3-docutils python3-mako python3-numpy python3-requests python3-ruamel.yaml python3-setuptools git cmake build-essential`

`git clone https://github.com/EttusResearch/uhd.git ~/uhd`
`cd ~/uhd`
`git checkout v4.3.0.0`
`cd host`
`mkdir build`
`cd build`
`cmake ../`
`make -j $(nproc)`
`make test # This step is optional`
`sudo make install`
`sudo ldconfig`
`sudo uhd_images_downloader`


### Install SRS Ran
`sudo apt-get install cmake make gcc g++ pkg-config libfftw3-dev libmbedtls-dev libsctp-dev libyaml-cpp-dev libgtest-dev git`
`git clone --depth 1 --branch release_23_5 https://github.com/srsran/srsRAN_Project.git`
`cd srsRAN_Project`
`mkdir build`
`cd build`
`cmake ..`
`make`
`make test`

### Check for Driver
`grep UHD -m 4 CMakeCache.txt`

//Enable UHD
ENABLE_UHD:BOOL=ON
UHD_INCLUDE_DIRS:PATH=/usr/local/include
UHD_LIBRARIES:FILEPATH=/usr/local/lib/libuhd.so

### Install Open5gs 
`sudo apt update`
`sudo apt install gnupg`
`sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 6A26B1AE64C3C388`
`echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list`

`sudo apt update`
`sudo apt install -y mongodb-org`
`sudo systemctl start mongod (if '/usr/bin/mongod' is not running)`
`sudo systemctl enable mongod (ensure to automatically start it on system boot)`

`sudo add-apt-repository ppa:open5gs/latest`
`sudo apt update`
`sudo apt install open5gs`


### Install Open5GS Web UI
`sudo apt update`
`sudo apt install curl`
`curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -`
`sudo apt install nodejs`
`curl -fsSL https://open5gs.org/open5gs/assets/webui/install | sudo -E bash -`

### Install Configs
`git clone git@github.com:cnf-testsuite/5gRanDemo.git`
`cd 5gRanDemo/`
`sudo cp open5gs/amf.yaml /etc/open5gs/amf.yaml`
`sudo cp open5gs/mme.yaml /etc/open5gs/mme.yaml`
`sudo cp open5gs/upf.yaml /etc/open5gs/upf.yaml`

# Disable UFW
`sudo ufw disable`

### Enable IPv4/IPv6 Forwarding
`sudo sysctl -w net.ipv4.ip_forward=1`
`sudo sysctl -w net.ipv6.conf.all.forwarding=1`

### Add NAT Rule
`sudo iptables -t nat -A POSTROUTING -s 10.45.0.0/16 ! -o ogstun -j MASQUERADE`
`sudo ip6tables -t nat -A POSTROUTING -s 2001:db8:cafe::/48 ! -o ogstun -j MASQUERADE`


## Setup Sim Card Reader
`sudo apt-get install --no-install-recommends \
        pcscd libpcsclite-dev \
        python3 \
        python3-setuptools \
        python3-pyscard \
        python3-pip`

`sudo apt install pcsc-tools`
`git clone https://gitea.osmocom.org/sim-card/pysim`
`cd pysim`
`pip3 install --user -r requirements.txt`
 
# Read the sim card
`./pySim-read.py -p0`

# Disable 5G
`./pySim-shell.py -p 0`
    
#Verify your ADM
`pySIM-shell (MF)> verify_adm 91411771`

# Deactivate 5G Fields 
`pySIM-shell (MF)> select MF`
`pySIM-shell (MF)> select ADF.USIM`
`pySIM-shell (MF/ADF.USIM)> select EF.UST`

`pySIM-shell (MF/ADF.USIM/EF.UST)> ust_service_deactivate 124`
`pySIM-shell (MF/ADF.USIM/EF.UST)> ust_service_deactivate 125`

# Configure SIM
`./pySim-prog.py --pcsc-device=0 -j 0 --type="sysmoISIM-SJA2" --name=Open5GS --mcc=001 --mnc=02 --imsi=001010000000009 --opc=C42449363BBAD02B66D16BC975D77CC1 --ki=fec86ba6eb707ed08905757b1bb44b8f --pin-adm=91411771 --acc=0001`



# N200 Root

Fix adb permission issues: https://askubuntu.com/questions/908306/adb-no-permissions-on-ubuntu-17-04

Download and Install Full Stock Firmware Package:
https://www.xda-developers.com/how-to-install-oxygenos-ota-updates-on-oneplus-phones/

Firmware: https://www.getdroidtips.com/oneplus-nord-n200-5g-stock-firmware/#google_vignette

Extract Boot Image for Firmware Package: https://github.com/vm03/payload_dumper

Unlock BootLoader: https://droidwin.com/how-to-unlock-bootloader-on-oneplus-nord-n200-5g/

Patch Image & Root Phone: https://www.xda-developers.com/how-to-install-magisk/
