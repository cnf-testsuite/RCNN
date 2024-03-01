# RCNN- Reproducible Cloud Native 5G Node 
![Alt Text](https://i.imgur.com/lXQG9MY.png)

## Why does this exist?
We needed a real RAN to test for the [CNF Test Suite](https://github.com/cnf-testsuite). We couldn’t find an example that ‘just works’ in Kubernetes so we made one.

## What is this, exactly?
This is Radio Access Networking software (RAN) combined with 5g core software, which together with the proper hardware creates a 5g node (base station) that can generate a 5g signal for a commerical off the shelf (COTS) phone. 

All of this is installable in Kubernetes, with helm charts, making it (somewhat) cloud native.

## RCNN Installation steps
`git clone git@github.com:cnf-testsuite/RCNN.git`

### Create KIND Cluster with USB Access to B200/Mini
`kind create cluster --config=./k8s/kind.conf`

### Install Open5GS
`helm pull oci://registry-1.docker.io/gradiant/open5gs --version 2.0.8`

`helm install open5gs oci://registry-1.docker.io/gradiant/open5gs --version 2.0.8 --values ./k8s/5gSA-values.yam`

### Install SRS Ran
`kubectl create -f srsran.yml`

### Start SRSRan 
`kubectl exec -ti srsran -- /srsran/build/apps/gnb/gnb -c /srsran/build/apps/gnb/gnb_band71.conf`

## What equipment is required for this to work?

* A faraday cage (e.g. a DVTest faraday cage)
* A COTS phone (e.g. a oneplus 10t)
* A software defined radio (e.g. an Ettus b200 SDR)
* A programmable sim card (e.g. a sysmocom sim card)
* A sim card reader/writer (e.g. an HID Omnikey)
* A computer to act as the GNB (e.g. Dell XPS 13 9320)

## Where can I see this in action
[![Watch the video](https://img.youtube.com/vi/fa0zQGwJ_AM/hqdefault.jpg)](https://youtu.be/fa0zQGwJ_AM)

[Slidedeck](https://www.slideshare.net/WavellWatson/an-open-source-reproducible-cloud-native-5g-ran)

