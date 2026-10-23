#!/bin/bash
set -e

cd /home/ubuntu/hari

echo "Updating HTML ConfigMap..."

kubectl create configmap training-site \
  --from-file=index.html=/home/ubuntu/hari/index.html \
  -n training-project \
  --dry-run=client -o yaml | kubectl apply -f -

echo "Waiting for ConfigMap update..."
sleep 5

echo "Starting port forwarding on port 30001..."

kubectl port-forward svc/training-service 30001:80 \
  -n training-project --address=0.0.0.0
