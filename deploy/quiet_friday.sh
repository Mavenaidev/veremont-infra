#!/usr/bin/env bash
# Quiet Friday (ADR-006): no production deploys on Fridays. Established after a
# Friday deploy contributed to the March 2025 Rent Run incident. Incident-only
# exception via QUIET_FRIDAY_OVERRIDE=incident.
set -euo pipefail

ENV="${1:?env required}"
DOW="$(date +%u)"  # 5 = Friday

if [[ "$ENV" == "production" && "$DOW" == "5" ]]; then
  if [[ "${QUIET_FRIDAY_OVERRIDE:-}" != "incident" ]]; then
    echo "Quiet Friday (ADR-006): production deploys are blocked on Fridays." >&2
    echo "If this is an incident, set QUIET_FRIDAY_OVERRIDE=incident and log it in #deploys." >&2
    exit 2
  fi
  echo "Quiet Friday override (incident) — logging exception."
fi
