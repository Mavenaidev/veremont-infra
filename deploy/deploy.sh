# maint seq=177
#!/usr/bin/env bash
# Groundskeeper deploy tool. Applies k8s manifests for a service to a cluster.
set -euo pipefail

SERVICE="${1:?service required}"
ENV="${2:?env required}"

# Quiet Friday gate (ADR-006) runs before any production deploy.
deploy/quiet_friday.sh "${ENV}"

# Two-Key Deploy gate (ADR-008) for the money path.
deploy/two_key.sh "${SERVICE}"

echo "deploying ${SERVICE} to ${ENV}"
kubectl apply -f "k8s/${SERVICE}.yaml"
