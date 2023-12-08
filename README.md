# RCNN- Reproducible Cloud Native 5G Node 
![Alt Text](https://i.imgur.com/Hx2wFR2.png)
## RCNN Install
`git clone git@github.com:cnf-testsuite/RCNN.git`
`cd k8s`

### Create KIND Cluster with USB Access to B200/Mini
`kind create cluster --config=./k8s/kind.conf`

### Install Open5GS
`helm repo add openverso https://gradiant.github.io/openverso-charts/`

`helm install open5gs openverso/open5gs --version 2.0.8 --values ./k8s/5gSA-values.yaml`

### Install SRS Ran
`kubectl create -f srsran.yml`

### Start SRSRan 
`kubectl exec -ti srsran -- /srsran/build/apps/gnb/gnb -c /srsran/build/apps/gnb/gnb_band71.conf`

