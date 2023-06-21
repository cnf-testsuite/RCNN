# SRS Ran K8s Install
`git clone git@github.com:cnf-testsuite/5gRanDemo.git`
`cd k8s`

### Create KIND Cluster with USB Access to B200/Mini
`kind create cluster --config=./kind.conf`

### Install Open5GS
`helm repo add openverso https://gradiant.github.io/openverso-charts/`

`helm install open5gs openverso/open5gs --version 2.0.8 --values ./5gSA-values.yaml`

### Install SRS Ran
`kubectl create -f srsran.yml`

### Start SRSRan 
`kubectl exec -ti srsran -- /srsran/build/apps/gnb/gnb -c /srsr
an/build/apps/gnb/gnb_band71.conf`

