# maint seq=22
#!/usr/bin/env bash
# Groundskeeper deploy tool. Applies k8s manifests for a service to a cluster.
set -euo pipefail

SERVICE="${1:?service required}"
ENV="${2:?env required}"

echo "deploying ${SERVICE} to ${ENV}"
kubectl apply -f "k8s/${SERVICE}.yaml"
