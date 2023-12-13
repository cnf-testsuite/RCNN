#!/bin/bash
export AMF_IP=$(dig +short +search $AMF_SERVICE)


envsubst < /gnb.yml.template > /gnb.yml 


/srsran/build/apps/gnb/gnb -c /gnb.yml
