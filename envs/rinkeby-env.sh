#!/bin/bash

gcloud container clusters get-credentials etheream-rinkeby-ssd --zone us-east1-b --project crypto-sandbox
kubectl port-forward --namespace rinkeby-ssd $(kubectl get pod --namespace rinkeby-ssd --selector="run=rinkeby-ssd" --output jsonpath='{.items[0].metadata.name}') 8546:8546 &

export HUB_ENVIRONMENT=development

export PGHOST=34.73.229.61
export PGPORT=5432
export PGUSER=postgres
export PGPASSWORD=ts2eMvGmslBrbtvF

export CRYPTO_COMPARE_API_KEY=38a2ceb5d53b2f1343b95e70d101701bbddabf92115cf0795ddfc3ac0c9bedb0
export JSON_RPC_URLS=ws://0.0.0.0:8546
export LOG_LEVELS='*=trace'

# yarn start
