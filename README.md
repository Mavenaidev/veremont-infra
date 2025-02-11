# veremont-infra (Groundskeeper)

Groundskeeper is the platform/infra repo every Veremont service deploys through:
Terraform, Kubernetes manifests, CI/CD, deploy tooling, and observability config.
Single-cloud (AWS), `us-east-1` primary.

## Layout

- `terraform/` — AWS infra (VPC, RDS/Keystone, EKS) as code
- `k8s/` — Kubernetes manifests per service (Atrium, Tollgate, Gatehouse, Atlas)
- `deploy/` — the deploy tool + policy gates (Quiet Friday, Two-Key Deploy)
- `.github/workflows/` — CI/CD pipelines
- `CODEOWNERS` — review routing (money path requires payments owners)

## Deploy policies

- **Quiet Friday** (ADR-006): no production deploys on Fridays (incident exception only).
- **Two-Key Deploy** (ADR-008): money-path deploys require a second approver.
